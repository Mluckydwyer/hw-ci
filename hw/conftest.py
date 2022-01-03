import pytest

# --- Pytest Utilities ---
def pytest_addoption(parser):
    parser.addoption("--gui", action="store_true", default=False, help="Open the simulator GUI")
    parser.addoption("--seed", action="store", type=int, default=None, help="Specify a seed for simulations")
    parser.addoption("--num-tests", action="store", type=int, default=None, help="Specify a total number of tests to run (each test will be run at least once)")


@pytest.fixture
def gui(request):
    return request.config.getoption("--gui")


@pytest.fixture
def seed(request):
    return request.config.getoption("--seed")


@pytest.fixture
def num_tests(request):
    return request.config.getoption("--num-tests")


def pytest_generate_tests(metafunc):
    if metafunc.config.option.num_tests is not None:
        num = int(metafunc.config.option.num_tests)

        # We're going to duplicate these tests by parametrizing them,
        # which requires that each test has a fixture to accept the parameter.
        # We can add a new fixture like so:
        metafunc.fixturenames.append('rerun_cnt')

        # Now we parametrize. This is what happens when we do e.g.,
        # @pytest.mark.parametrize('tmp_ct', range(count))
        # def test_foo(): pass
        metafunc.parametrize('rerun_cnt', range(num))
