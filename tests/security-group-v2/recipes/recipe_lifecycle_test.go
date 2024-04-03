package recipes

import (
	"path/filepath"
	"testing"

	"github.com/Excoriate/tftest/pkg/tfvars"

	"github.com/Excoriate/tftest/pkg/scenario"
	"github.com/stretchr/testify/assert"
)

func TestFullCreationRecipeBasic(t *testing.T) {
	fixtureFiles, tfVarErr := tfvars.GetTFVarsFromWorkdir(filepath.Join(recipeDir, "basic", fixtureDir))

	assert.NoErrorf(t, tfVarErr, "Failed to get tfvars files: %s", tfVarErr)

	for _, fixtureFile := range fixtureFiles {
		t.Run(fixtureFile, func(t *testing.T) {
			t.Parallel()

			workdir := filepath.Join(recipeDir, "basic")
			tfVarFile := filepath.Join(fixtureDir, fixtureFile)
			s, err := scenario.NewWithOptions(t, workdir, scenario.WithVarFiles(workdir, tfVarFile), scenario.WithParallel())

			defer s.Stg.DestroyStage(t, s.GetTerraformOptions())

			assert.NoErrorf(t, err, "Failed to create scenario: %s", err)

			s.Stg.PlanStage(t, s.GetTerraformOptions())
			s.Stg.ApplyStage(t, s.GetTerraformOptions())
		})
	}
}
