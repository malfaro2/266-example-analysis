"""Python step of the pipeline: correlations by region.

The runbook calls this from a {python} chunk and passes it the R data frame
`analysis` (reticulate converts it to a pandas DataFrame automatically).
"""

import numpy as np
import pandas as pd


def regionCorrelations(analysisDF: pd.DataFrame, year: int) -> pd.DataFrame:
    """Correlation between fertility and life expectancy, per region, in one year.

    Returns one row per region with the number of countries and the
    Pearson correlation, sorted from most negative to least negative.
    """
    oneYear = analysisDF[analysisDF["year"] == year]
    result = (
        oneYear.groupby("region")
        .apply(
            lambda g: pd.Series(
                {
                    "n_countries": len(g),
                    "correlation": g["fertility"].corr(g["life_exp"]),
                }
            ),
            include_groups=False,
        )
        .reset_index()
        .sort_values("correlation")
        .reset_index(drop=True)
    )
    result["n_countries"] = result["n_countries"].astype(int)
    return result
