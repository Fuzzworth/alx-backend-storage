#!/usr/bin/env python3
'''
Modules Docs
'''
import redis
from uuid import uuid4
from typing import Union, Optional, Callable, Any


def call_history(method: Callable) -> Callable:
    def wrapper(self, *args, **kwargs):
        # Create keys for inputs and outputs
        inputs_key = f"{method.__qualname__}:inputs"
        outputs_key = f"{method.__qualname__}:outputs"

        # Append input arguments to the inputs list
        input_str = str(args)
        self._redis.rpush(inputs_key, input_str)

        # Execute the original function to get the output
        output = method(*args, **kwargs)

        # Store the output in the outputs list
        self._redis.rpush(outputs_key, output)

        return output

    return wrapper


class Cache:
    '''
    Class Docs
    '''

    def __init__(self):
        '''
        Function Docs
        '''
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    def store(self, data: Union[str, bytes, int, float]) -> str:
        '''
        Function Docs
        '''
        random_key = str(uuid4())
        self._redis.set(random_key, data)
        return random_key

    def get(self, key: str, fn: Optional[Callable] = None) -> \
            Union[bytes, str, memoryview]:
        '''
        Function Docs
        '''
        value = self._redis.get(key)
        if value and fn is not None:
            return fn(value)

        return value

    def get_str(self, key: str) -> str:
        '''
        Function Docs
        '''
        return self.get(key, fn=lambda x: x.decode('utf-8'))

    def get_int(self, key: str) -> int:
        '''
        Function Docs
        '''
        return self.get(key, fn=int)
