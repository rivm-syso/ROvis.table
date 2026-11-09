# Use a standardized theme for gt tables

![\[gt\]](figures/group-gt.svg)  
  
This function implements a stylized theme for gt tables.

## Usage

``` r
ro_gt_theme(df, ROfont = FALSE, ...)
```

## Arguments

- df:

  Dataframe.

- ROfont:

  Default is FALSE, will change to TRUE for next major release (1.0.0).
  If Rijksoverheid font is not available on your device, Verdana is
  used, then Arial, then the first font found on your device, whichever
  is installed first.

- ...:

  For internal use. Leave empty.

## Value

gt table object.

## Examples

``` r
if (FALSE) { # \dontrun{
ro_gt_theme(df)
} # }
```
