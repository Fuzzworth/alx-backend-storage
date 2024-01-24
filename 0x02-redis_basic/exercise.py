#!/usr/bin/env python3
'''
Modules Docs
'''
import redis
from uuid import uuid4


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

    def store(self, data) -> str:
        '''
        Function Docs
        '''
        random_key = uuid4()
        self._redis.set(random_key, data)
        return random_key
