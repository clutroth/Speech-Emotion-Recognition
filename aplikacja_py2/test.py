#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy
import unittest

from emo.prezentation import map_to_table
from util import filter, binarizer
from emo.model import *
from emo.stage import preprocess


class TestDataFilter(unittest.TestCase):
    def test_binarizer_wirks(self):
        sda = [0, 0, 2, 2, 5, 6]
        self.assertEquals(binarizer(sda), [0, 0, 1, 1, 2, 3])

    def test_binarizer_wirks2(self):
        sda = [3, 2]
        self.assertEquals(binarizer(sda), [1, 0])

    def test_if_works(self):
        x = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
        y = [0, 1, 2]
        allowed = (0, 2)
        [new_x, new_y] = filter(x, y, allowed)
        self.assertEquals(new_x, [
            [1, 2, 3],
            [7, 8, 9]
        ])
        self.assertEquals(new_y, [0, 1])


class TestPrezentation(unittest.TestCase):
    def test_map_to_table(self):
        # (columns, rows)
        m = {
            ('a', 'A'): 1,
            ('b', 'A'): 2,
            ('a', 'B'): 3,
            ('b', 'B'): 4
        }
        expected = ((['a', 'b'], ['A', 'B']), [[1, 3], [2, 4]])
        res = map_to_table(m)
        self.assertEquals(res, expected)

    def test_map_to_table_asymmetric(self):
        # (columns, rows)
        m = {
            ('a', 'A'): 1,
            ('b', 'A'): 2,
        }
        expected = ((['a', 'b'], ['A']), [[1], [2]])
        res = map_to_table(m)
        self.assertEquals(res, expected)


class TestStringMethods(unittest.TestCase):
    def test_preprocess_3_1_int(self):
        self.verifyDoubleZeroSignal(numpy.zeros(3, numpy.int16))

    def test_preprocess_3_2_int(self):
        self.verifyDoubleZeroSignal(numpy.zeros((3, 2), numpy.int16))

    def test_preprocess_3_1_float(self):
        self.verifyDoubleZeroSignal(numpy.zeros(3, numpy.float32))

    def test_preprocess_3_2_float(self):
        self.verifyDoubleZeroSignal(numpy.zeros((3, 2), numpy.float32))

    def verifyDoubleZeroSignal(self, enterSignal):
        sig = Signal(enterSignal, 1)
        excpected = Signal(numpy.zeros(3, numpy.float64), 1)
        actual = preprocess(sig)
        self.assertEqual(excpected, actual)

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

            # ['/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/RA/AKL_RA_T.wav','/home/wdk/uczelnia/mgr/materiały/agh/EmotiveKorpus/NE/MCH_NE_P.wav']
