#!/usr/bin/env python3
'''
Modules Docs
'''
import redis


class Cache:
    '''
    Class Docs
    '''

    def __init__(self):
        '''
        Function Docs
        '''
        _redis = redis.Redis()
        self._redis.flushdb()
