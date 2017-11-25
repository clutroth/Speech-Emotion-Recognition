#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy
import unittest

from emo.model import *
from emo.stage import preprocess


class TestStringMethods(unittest.TestCase):
    def test_preprocess_3_1_int(self):
        self.verifyDoubleZeroSignal(numpy.zeros(3, numpy.int16))

    def test_preprocess_3_2_int(self):
        self.verifyDoubleZeroSignal(numpy.zeros((3,2), numpy.int16))

    def test_preprocess_3_1_float(self):
        self.verifyDoubleZeroSignal(numpy.zeros(3, numpy.float32))

    def test_preprocess_3_2_float(self):
        self.verifyDoubleZeroSignal(numpy.zeros((3,2), numpy.float32))

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
