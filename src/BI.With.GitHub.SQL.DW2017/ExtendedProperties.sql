EXEC sp_addextendedproperty @name='BuildNumber', @value ='__GITHUB_RUN_NUMBER__', @level0type = NULL, @level0name = NULL, @level1type = NULL, @level1name = NULL, @level2type = NULL, @level2name = NULL
GO
EXEC sp_addextendedproperty @name='BuildId', @value ='__GITHUB_RUN_ID__', @level0type = NULL, @level0name = NULL, @level1type = NULL, @level1name = NULL, @level2type = NULL, @level2name = NULL
GO
EXEC sp_addextendedproperty @name='Repo', @value ='__GITHUB_REPOSITORY__', @level0type = NULL, @level0name = NULL, @level1type = NULL, @level1name = NULL, @level2type = NULL, @level2name = NULL
GO
EXEC sp_addextendedproperty @name='Workflow', @value ='__GITHUB_WORKFLOW__', @level0type = NULL, @level0name = NULL, @level1type = NULL, @level1name = NULL, @level2type = NULL, @level2name = NULL
GO
