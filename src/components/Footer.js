import VuiBox from 'vui-theme/components/VuiBox';
import VuiTypography from 'vui-theme/components/VuiTypography';

function Footer() {
  return (
    <VuiBox
      display="flex"
      flexDirection={{ xs: 'column', lg: 'row' }}
      justifyContent="space-between"
      direction="row"
      component="footer"
      py={2}
      pb={0}
    >
      <VuiBox item xs={12} sx={{ textAlign: 'center' }}></VuiBox>
      <VuiBox item xs={10}>
        <VuiBox display="flex" justifyContent="center" flexWrap="wrap" mb={3}>
          <VuiBox mr={{ xs: '20px', lg: '46px' }}>
            <VuiTypography
              component="a"
              href={`${process.env.PUBLIC_URL}/items`}
              variant="body2"
              color="black"
            >
              Items
            </VuiTypography>
          </VuiBox>
          <VuiBox mr={{ xs: '20px', lg: '46px' }}>
            <VuiTypography
              component="a"
              href={`${process.env.PUBLIC_URL}/activity`}
              variant="body2"
              color="black"
            >
              Activity
            </VuiTypography>
          </VuiBox>
          <VuiBox mr={{ xs: '20px', lg: '46px' }}>
            <VuiTypography
              component="a"
              href={`${process.env.PUBLIC_URL}`}
              variant="body2"
              color="black"
            >
              Home
            </VuiTypography>
          </VuiBox>
        </VuiBox>
      </VuiBox>
    </VuiBox>
  );
}

export default Footer;
