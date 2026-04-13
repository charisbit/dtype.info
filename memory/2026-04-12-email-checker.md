# Email Checker Task — 2026-04-12

## Source
GitHub webhook notification for PR run failure on hijirii/pennylane

## PR #1 Summary
- **Title:** Fix #7807: Make circuit drawing consistent for StateMP/DensityMatrixMP with/without device wires
- **Author:** @hijirii
- **Branch:** bounty/issue-7807 (sha: 94ad120)
- **Changes:** +17/-3 across 2 files
  - `pennylane/drawer/_add_obj.py` — circuit drawing fix for StateMP/DensityMatrixMP
  - `pennylane/ops/functions/equal.py` — improved error messages in `_equal_measurements`

## CI Status (Run #24289074653 — Apr 11, 2026 18:43 UTC)
| Workflow | Result |
|----------|--------|
| Documentation check | ✅ SUCCESS |
| Read the Docs check | ✅ SUCCESS |
| Formatting check | ✅ SUCCESS |
| PennyLane Labs Unit-Tests | ✅ SUCCESS |
| Validate module imports | ✅ SUCCESS |
| Code Security Scan | ✅ SUCCESS |
| **Documentation Tests** | ❌ **FAILURE** |
| Tests | ❌ FAILURE |
| GPU Tests | ⏭️ SKIPPED |

## Failed Jobs
1. **Documentation Tests on Python 3.11** (job #70923290217)
   - Step 9 "Test 'pennylane' folder" FAILED
   - 19 failed, 4731 passed, 44 warnings in 166.92s

2. **Tests** (run #24289074680) — multiple test suites FAILED:
   - autograd-tests (3.11)
   - gradients-tests (param-shift, 3.11)
   - core-tests (1, 3.11)
   - data-tests (3.11)
   - qchem-tests (3.11)
   - qcut-tests (3.11)
   - torch-tests (3.11)
   - jax-tests (1, 3.11)
   - all-interfaces-tests (3.11)
   - capture-jax-tests (3.11)
   - external-libraries-tests (3.11)
   - device-tests (default.qubit, None, 3.11)

## Documentation Test Failures (19 failed docstring tests)
All failures are docstring lint errors at specific line:column positions:

```
FAILED pennylane/decomposition/decomposition_rule.py::line:212,column:1
FAILED pennylane/ftqc/graph_state_preparation.py::line:141,column:1
FAILED pennylane/ftqc/graph_state_preparation.py::line:161,column:1
FAILED pennylane/ops/op_math/change_op_basis.py::line:124,column:1
FAILED pennylane/ops/op_math/change_op_basis.py::line:154,column:1
FAILED pennylane/templates/state_preparations/sum_of_slaters.py::line:710,column:1
FAILED pennylane/templates/state_preparations/sum_of_slaters.py::line:798,column:1
FAILED pennylane/templates/subroutines/controlled_sequence.py::line:180,column:1
FAILED pennylane/templates/subroutines/controlled_sequence.py::line:199,column:1
FAILED pennylane/templates/subroutines/time_evolution/trotter.py::line:640,column:1
FAILED pennylane/templates/subroutines/time_evolution/trotter.py::line:644,column:1
FAILED pennylane/templates/subroutines/time_evolution/trotter.py::line:798,column:1
FAILED pennylane/templates/subroutines/time_evolution/trotter.py::line:802,column:1
FAILED pennylane/transforms/intermediate_reps/parity_synth.py::line:74,column:1
FAILED pennylane/transforms/optimization/merge_amplitude_embedding.py::line:376,column:1
FAILED pennylane/transforms/zx/optimize_t_count.py::line:85,column:1
FAILED pennylane/transforms/zx/push_hadamards.py::line:86,column:1
FAILED pennylane/transforms/zx/reduce_non_clifford.py::line:88,column:1
FAILED pennylane/transforms/zx/todd.py::line:84,column:1
```

**Note:** None of the failed files are directly modified by this PR. The failures appear in unrelated modules (decomposition, ftqc, templates, transforms). The PR modifies only `pennylane/drawer/_add_obj.py` and `pennylane/ops/functions/equal.py`.

The change to `_equal_measurements` in `equal.py` (returning descriptive strings instead of bare `False`) **may** be cascading into these failures indirectly, but the pattern (all line:column:1 docstring lint errors) suggests either pre-existing issues or a systemic effect.

## Action Needed
1. Investigate the 19 docstring lint failures — likely pre-existing or unrelated to circuit drawing fix
2. The `equal.py` change may need to be scoped more narrowly to avoid affecting measurement comparisons in docstrings
3. PR cannot merge until Documentation Tests pass

## PR Links
- PR: https://github.com/hijirii/pennylane/pull/1
- Run: https://github.com/hijirii/pennylane/actions/runs/24289074653
