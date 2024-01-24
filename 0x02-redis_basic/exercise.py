#!/usr/bin/env python3
'''
Modules Docs
'''
import redis
from uuid import uuid4
from typing import Union


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
