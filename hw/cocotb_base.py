# Run Commands:
#   pytest \
#       --collect-only/--co  # Only list all available tests
#       -k <test_name>  # Run only a selected test
#       --cocotb-xml=report.xml  # Generate a junit-xml style report file for cocotb tests (change name)
#       -n <number of CPUs>  # Run tests in parallel
#       --html=report.html --self-contained-html  # Generate an HTML report from the runs
#       --seed <seed value>  # Run the simulation with a specified seed
#       --gui  # Run the simulator in GUI mode
#       -r a  # Show extra test summary for (a)ll tests
#       -q  # Quiet (decrease verbosity) 
#       
#   pytest -n 1 --html=report.html -r a -q
#

from cocotb_test.simulator import run
import os, glob, warnings
warnings.filterwarnings("ignore", category=DeprecationWarning) 

# Remote Python Debugger
# from remote_pdb import RemotePdb
# rpdb = RemotePdb("127.0.0.1", 5678)
# import debugpy
# debugpy.listen(5678)
# debugpy.wait_for_client()

# ~~~ MODULE SETTINGS ~~~
top_level_dut = 'basic_axi_adder_wrapper'
top_dut_language = 'verilog'
# ~~~ END MODULE SETTINGS ~~~


# ~~~ SIM SETTINGS ~~~
compile_args = ['-nologo', '-mixedsvvh', '-force_refresh', '-noincr', '-hazards']#, '-vlog01compat', '-convertallparams', '-mixedansiports']
compile_args_vhdl = ['-autoorder', '-2008']
compile_args_verilog = []
sim_args = ['-32', '-voptargs=\"+acc\"', '-L','work', '-L','unisims_ver', '-L','unimacro_ver', '-L','unisim', '-L','unimacro', '-L','secureip', '-t','1ps', '-warning','3155' , '-suppress','GroupFLI', '-warning', '12110', '-hazards'] #, '-keepstdout ']  # , '-mixedansiports']
plus_args = []
waves = True
simulator = 'questa'  # Same as modelsim
#vhdl_gpi_intf = 'vhpi'
# ~~~ END SIM SETTINGS ~~~


os.environ["SIM"] = simulator
os.environ["COCOTB_RESOLVE_X"] = 'ZEROS'
#os.environ["VHDL_GPI_INTERFACE"] = vhdl_gpi_intf

# Get our test and hw source directories
tests_dir = os.path.dirname(__file__)
hdl_dirs = [os.path.join(os.path.dirname(__file__), '..', i) for i in ["hdl", "src"]]
test_dirs = [tests_dir]

# Glob for our files
hdl_files = sum([glob.glob(os.path.join(i, "*")) for i in hdl_dirs], [])
vhdl_files = [i for i in hdl_files if os.path.splitext(i)[-1].lower() in ['.vhd','.vhdl']]
verilog_files = [i for i in hdl_files if os.path.splitext(i)[-1].lower() in ['.v','.vh', '.verilog', '.vlg', '.sv', '.svh']]

def run_cocotb(module, sim_build_dir='sim_build', params=None, gui=False, seed=None):
    if params is None: return
    str_params = {str(key): str(value) for key, value in params.items()}
    run(
        vhdl_sources=vhdl_files,  # Vhdl source files to compile and simulate
        verilog_sources=verilog_files,  # Verilog source files to compile and simulate
        python_search=test_dirs,  # Additional directories to search in for tests
        toplevel=top_level_dut,  # Top Level DUT in HDL
        module=module,  # CocoTB test file name
        toplevel_lang=top_dut_language,  # Top level language we are using
        compile_args=compile_args,  # Arguments passed to both verilog and vhdl compilers
        compile_args_vhdl=compile_args_vhdl,  # Additional arguments passed to the vhdl compiler
        compile_args_verilog=compile_args_verilog,  # Additional arguments passed to the verilog compiler
        #parameters=str_params,  # vhdl generics and verilog parameters (testing proved inconsistent and broken behaviors)
        extra_env=str_params,  # Extra envrionment variables
        sim_args=sim_args,  # Additional arguments to pass to the simulator
        plus_args=plus_args,  # Additional args passed to the simulator (used for enabling features)
        sim_build=sim_build_dir,
        force_compile=True,  # Disable incremental compilition since it causes issues at times with Modelsim and CocoTB
        seed=seed,  # Seed to use for tests
        waves=waves,  # Should waves be dumped? Always, yes
        gui=gui  # Should the Modelsim GUI be opened? No, we are running headless
    )
