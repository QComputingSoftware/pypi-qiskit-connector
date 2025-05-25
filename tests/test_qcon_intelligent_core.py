# @Author: Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador
# @last update: 2025-03-01
# @Purpose: This script contains unit tests for the QConIntelligentCore class in the qiskit_connector software package.
# @Description: The tests check the functionality of various methods in the QConIntelligentCore class, including QConnectorIntelli, QPlanIntelli, QFooterIntelli, QBackendIntelli, QSaveAccountIntelli, QGetCredentialsIntelli, and QSummary. Each test captures the output of the method and checks for specific strings indicating whether the method executed successfully or if certain classes/functions are present or missing.
# @Note: The tests use the pytest framework and redirect the standard output to capture the printed messages from the methods being tested. The tests assert that the expected output is present in the captured output, and if not, an AssertionError is raised with a specific message.
# @License: This code is licensed.
# @Copyright (c) 2025 Dr. Jeffrey Chijioke-Uche

import pytest
from contextlib import redirect_stdout
from io import StringIO

from qiskit_connector import QConIntelligentCore

# --------------------------
# Test 1: QConnectorIntelli
# --------------------------
def test_qconnectorIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QConnectorIntelli()
    output = f.getvalue()
    assert "QConnectorV2 class is active" in output or "QConnectorV2 class is missing" in output
    if "missing" in output:
        raise AssertionError("QConnectorV2 check failed: Class not present")

# ----------------------
# Test 2: QPlanIntelli
# ----------------------
def test_qplanIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QPlanIntelli()
    output = f.getvalue()
    assert "QPlanV2 class is active" in output or "QPlanV2 class is missing" in output
    if "missing" in output:
        raise AssertionError("QPlanV2 check failed: Class not present")

# ----------------------
# Test 3: QFooterIntelli
# ----------------------
def test_qfooterIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QFooterIntelli()
    output = f.getvalue()
    assert "footer() function is active" in output or "footer() function is missing" in output
    if "missing" in output:
        raise AssertionError("footer() check failed: Function not present")

# ----------------------
# Test 4: QBackendIntelli
# ----------------------
def test_qbackendIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QBackendIntelli()
    output = f.getvalue()
    assert "list_backends() function is active" in output or "list_backends() function is missing" in output
    if "missing" in output:
        raise AssertionError("list_backends() check failed: Function not present")

# ----------------------
# Test 5: QSaveAccountIntelli
# ----------------------
def test_qsaveaccountIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QSaveAccountIntelli()
    output = f.getvalue()
    assert "save_account() function is active" in output or "save_account() function is missing" in output
    if "missing" in output:
        raise AssertionError("save_account() check failed: Function not present")

# ----------------------
# Test 6: QGetCredentialsIntelli
# ----------------------
def test_qgetcredentialsIntelli():
    core = QConIntelligentCore()
    f = StringIO()
    with redirect_stdout(f):
        core.QGetCredentialsIntelli()
    output = f.getvalue()
    assert "_get_credentials() function is active" in output or "_get_credentials() function is missing" in output
    if "missing" in output:
        raise AssertionError("_get_credentials() check failed: Function not present")

# ----------------------
# Test 7: QSummary
# ----------------------
def test_qsummary():
    core = QConIntelligentCore()
    core.QConnectorIntelli()
    core.QPlanIntelli()
    core.QFooterIntelli()
    core.QBackendIntelli()
    core.QSaveAccountIntelli()
    core.QGetCredentialsIntelli()
    f = StringIO()
    with redirect_stdout(f):
        core.QSummary()
    output = f.getvalue()
    assert "Summary Report" in output
    assert "QConnectorV2 class" in output
