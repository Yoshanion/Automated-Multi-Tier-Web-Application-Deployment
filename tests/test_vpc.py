import pytest

# Use the pytest terraform hook to pass terraform outputs
@pytest.mark.terraform
def test_subnets_created(terraform_output):
    public_subnet_ids = terraform_output['public_subnet_ids']['value']
    private_subnet_ids = terraform_output['private_subnet_ids']['value']
    
    # Check if three public and three private subnets are created
    assert len(public_subnet_ids) == 3, "There should be three public subnets."
    assert len(private_subnet_ids) == 3, "There should be three private subnets."

# Additional tests can be added here