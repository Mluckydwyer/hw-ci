import pytest
from hw.cocotb_base import run_cocotb

#  ~~~~~~ Bring Up Tests ~~~~~~  #
@pytest.mark.bringup
@pytest.mark.single
@pytest.mark.regresSingle
@pytest.mark.usefixtures("request", "gui", "seed")
@pytest.mark.parametrize("data_width", [8, 16, 32])
@pytest.mark.parametrize("a, b", [
    (1, 1),
    (5, 0),
    (0, 0),
    (100, 100),
    (123, 456),
    (0xFFFF, 0xFFFF),
    (0xFFFF_FFFF, 1)
])
def test_single_bringup(request, gui, seed, data_width, a, b):
    module = "tests.single_bringup"
    params = {
        'C_DATA_WIDTH': data_width,
        'A': a,
        'B': b
    }
    print(params)
    run_cocotb(module, f'sim_build/{request.node.name}', params, gui, seed)

# @pytest.mark.bringup
# @pytest.mark.multi
# @pytest.mark.usefixtures("gui", "seed")
# @pytest.mark.parametrize("data_width", [8, 16, 32])
# async def test_multi_bringup(gui, seed, data_width):
#     module = "tests.multi_bringup"
#     params = {'C_DATA_WIDTH': data_width}
#     run_cocotb(module, params, gui, seed)


#  ~~~~~~ Random Tests ~~~~~~  #
@pytest.mark.asyncio
@pytest.mark.random
@pytest.mark.single
@pytest.mark.usefixtures("request", "gui", "seed")
@pytest.mark.parametrize("data_width", [8, 16, 32])
async def test_single_random(request, gui, seed, data_width):
    module = "tests.single_random"
    params = {'C_DATA_WIDTH': data_width}
    run_cocotb(module, f'sim_build/{request.node.name}', params, gui, seed)

# @pytest.mark.random
# @pytest.mark.multi
# @pytest.mark.usefixtures("gui", "seed")
# @pytest.mark.parametrize("data_width", [8, 16, 32])
# async def test_multi_random(gui, seed, data_width):
#     module = "tests.multi_random"
#     params = {'C_DATA_WIDTH': data_width}
#     run_cocotb(module, params, gui, seed)
