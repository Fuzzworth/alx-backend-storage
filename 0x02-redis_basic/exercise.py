#!/usr/bin/env python3
'''
Modules Docs
'''
import redis
from uuid import uuid4
from typing import Union, Optional, Callable,Any


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

    def store(self, data: Union[str, bytes, int, float]) -> str:
        '''
        Function Docs
        '''
        random_key = str(uuid4())
        self._redis.set(random_key, data)
        return random_key

    def get(self, key: str, fn: Optional[Callable] = None) -> Any:
        '''
        Function Docs
        '''
        value = self._redis.get(key)
        if value and type(fn) is not None:
            return fn(value)

        return value
