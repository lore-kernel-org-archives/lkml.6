Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeDTG5w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:57:52 -0400
Received: from mail-ve1eur01on0089.outbound.protection.outlook.com ([104.47.1.89]:6208
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752771AbeDTG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:57:49 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
Thread-Topic: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
Thread-Index: AQHTvz6s919F6cG1e0yHL1ZH6g380qQIXvgAgAEL+WA=
Date: Fri, 20 Apr 2018 06:57:44 +0000
Message-ID: <AM3PR04MB131538D8AC69E95D1CB48E80F5B40@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <20180419145725.GX25429@dragon>
In-Reply-To: <20180419145725.GX25429@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1427;7:NHUmElG4lG8CqhDVF5XuFsWE+XS5D3MtfmsB7Q2MnPVlC6WB757oTvNul55kqR5n0ZAnVlHfRkLG+/5YlR4iVlgrGAGqknOzpU60H5gCbqsEEBcaRNC074f4huQJqI2xnHwMBDgv9FpOGsMbDn/S8ycOdu1vGoD1PX8+krbEURZCeN4WiK3H93fpPuhtN1rxC9Y13p3CeUUzhc1dLkWvOu9ulv4ge5zKmhpFarGX/Rrp8MlECfcx+Z3GFLWb58hP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1427;
x-ms-traffictypediagnostic: AM3PR04MB1427:
x-microsoft-antispam-prvs: <AM3PR04MB142708A3D7A83574E300AD32F5B40@AM3PR04MB1427.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM3PR04MB1427;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1427;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39380400002)(39860400002)(13464003)(478600001)(6116002)(86362001)(3846002)(7736002)(6436002)(25786009)(5250100002)(316002)(8936002)(446003)(81166006)(3280700002)(11346002)(8676002)(186003)(9686003)(55016002)(575784001)(6306002)(7416002)(5660300001)(2906002)(44832011)(53936002)(229853002)(966005)(6246003)(45080400002)(476003)(76176011)(6506007)(26005)(53546011)(4326008)(102836004)(305945005)(74316002)(3660700001)(54906003)(33656002)(7696005)(2900100001)(66066001)(6916009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1427;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: tROvjsQsXCCRsfqRpBtaM07y8DKTNmzwWpjeSOEUtkCNPmwGkS8XlqtpkZWGlT/8A0UTERdipOupNYeszJjgu0gna2OdAo1bCLGMvYgITCKa0NohfEWctOualTNovuyfKyyEx3yn8uIejzCqOjLVpw5Lyycp3S0Zv/k++f/8b9lUUpDw3bdfyFPSnfve/uIC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1ed8b317-c3a9-4f94-0a67-08d5a68c0490
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed8b317-c3a9-4f94-0a67-08d5a68c0490
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 06:57:44.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1427
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3K6vwRq001682



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Thursday, April 19, 2018 10:57 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> robh+dt@kernel.org; mark.rutland@arm.com; linux@armlinux.org.uk;
> mturquette@baylibre.com; sboyd@kernel.org; S.j. Wang
> <shengjiu.wang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org
> Subject: Re: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
> 
> On Mon, Mar 19, 2018 at 10:30:44AM +0800, Anson Huang wrote:
> > i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> > And this lvds2, along with lvds1, can be used to provide external
> > clock source to the internal pll, such as pll4_audio and pll5_video.
> >
> > This patch mainly adds the lvds2 to the clock tree and fix its
> > relationship with pll accordingly.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
> >  include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx6sx.c
> > b/drivers/clk/imx/clk-imx6sx.c index e6d389e..478ad0d 100644
> > --- a/drivers/clk/imx/clk-imx6sx.c
> > +++ b/drivers/clk/imx/clk-imx6sx.c
> > @@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
> >  	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy",
> "pll5_video_div",
> >  	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
> > }; -static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
> > +static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in",
> > +"lvds2_in", "dummy", };
> >  static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src",
> > };  static const char *pll2_bypass_sels[] = { "pll2",
> > "pll2_bypass_src", };  static const char *pll3_bypass_sels[] = {
> > "pll3", "pll3_bypass_src", }; @@ -158,8 +158,9 @@ static void __init
> imx6sx_clocks_init(struct device_node *ccm_node)
> >  	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
> >  	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
> >
> > -	/* Clock source from external clock via CLK1 PAD */
> > +	/* Clock source from external clock via CLK1/2 PAD */
> >  	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
> > +	clks[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
> 
> It seems to me that anaclk clocks are similar to ipp_di, and could be handled in
> the same way as ipp_di clocks.  If that's the case, I would suggest we do the
> following.
> 
> 1. Kill clocks container node by dropping 'reg' property and naming
>    clock nodes uniquely.  This is not strictly related to what we try
>    to do here, but just to address DT maintainers' concern on 'clocks'
>    container node.
> 
> 	clk_ckil: clock-ckil {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <32768>;
> 		clock-output-names = "ckil";
> 	};
> 
> 	clk_osc: clock-osc {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <24000000>;
> 		clock-output-names = "osc";
> 	};
> 
> 	clk_ipp_di0: clock-ipp-di0 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "ipp_di0";
> 	};
> 
> 	clk_ipp_di1: clock-ipp-di1 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "ipp_di1";
> 	};
> 
> 	clks: ccm@20c4000 {
> 		compatible = "fsl,imx6sx-ccm";
> 		reg = <0x020c4000 0x4000>;
> 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> 		#clock-cells = <1>;
> 		clocks = <&clk_ckil>, <&clk_osc>, <&clk_ipp_di0>, <&clk_ipp_di1>;
> 		clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
> 	};
> 
> 2. Patch clock driver to have anaclk1 and anaclk2 handled in the same
>    way as ipp_di clocks.
> 
> 	clks[IMX6SX_CLK_ANACLK1] = of_clk_get_by_name(ccm_node, "anaclk1");
> 	clks[IMX6SX_CLK_ANACLK2] = of_clk_get_by_name(ccm_node, "anaclk2");
> 
> 3. Add anaclk1 and anaclk2 with clock-frequency being 0 by default, just
>    like ipp_di clocks.
> 
> 	clk_anaclk1: clock-anaclk1 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "anaclk1";
> 	};
> 
> 	clk_anaclk2: clock-anaclk2 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "anaclk2";
> 	};
> 
> 	clks: ccm@20c4000 {
> 		compatible = "fsl,imx6sx-ccm";
> 		reg = <0x020c4000 0x4000>;
> 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> 		#clock-cells = <1>;
> 		clocks = <&clk_ckil>, <&clk_osc>,
> 			 <&clk_ipp_di0>, <&clk_ipp_di1>,
> 			 <&clk_anaclk1>, <&clk_anaclk2>;
> 		clock-names = "ckil", "osc",
> 			      "ipp_di0", "ipp_di1",
> 			      "anaclk1", "anaclk2";
> 	};
> 
> 4. Overwrite anaclk2 clock-frequency in imx6sx-sabreauto.dts.
> 
> &clk_anaclk2 {
> 	clock-frequency = <24576000>;
> };
> 
> Please test and let me know whether it works or not.  Thanks.
> 
> Shawn

It is working, see below clk tree dump, I will send a V3 patch, thanks.

Anson. 


root@imx6qpdlsolox:~# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
   clock                          count    count    count        rate   accuracy   phase
----------------------------------------------------------------------------------------
 dummy                                3        3        0           0          0 0
    cko1_sel                          0        0        0           0          0 0
       cko1_podf                      0        0        0           0          0 0
          cko1                        0        0        0           0          0 0
             cko                      0        0        0           0          0 0
    usbphy2_gate                      1        1        0           0          0 0
    usbphy1_gate                      1        1        0           0          0 0
 anaclk2                              0        0        0    24576000          0 0
    lvds2_in                          0        0        0    24576000          0 0
 anaclk1                              0        0        0           0          0 0
    lvds1_in                          0        0        0           0          0 0
 ipp_di1                              0        0        0           0          0 0
 ipp_di0                              0        0        0           0          0 0
 osc                                  6        6        0    24000000          0 0

> 
> >
> >  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
> >  	base = of_iomap(np, 0);
> > @@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct
> device_node *ccm_node)
> >  	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m",
> > "pcie_ref", base + 0xe0, 19);
> >
> >  	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out",
> > "lvds1_sel", base + 0x160, 10, BIT(12));
> > +	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out",
> > +"lvds2_sel", base + 0x160, 11, BIT(13));
> >  	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",
> "anaclk1",   base + 0x160, 12, BIT(10));
> > +	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",
> "anaclk2",   base + 0x160, 13, BIT(11));
> >
> >  	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL,
> "enet_ref", "pll6_enet", 0,
> >  			base + 0xe0, 0, 2, 0, clk_enet_ref_table, @@ -270,6 +273,7 @@
> > static void __init imx6sx_clocks_init(struct device_node *ccm_node)
> >
> >  	/*                                                name
> reg           shift   width   parent_names       num_parents */
> >  	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",
> base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
> > +	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",
> base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
> >
> >  	np = ccm_node;
> >  	base = of_iomap(np, 0);
> > diff --git a/include/dt-bindings/clock/imx6sx-clock.h
> > b/include/dt-bindings/clock/imx6sx-clock.h
> > index 36f0324..cd2d6c5 100644
> > --- a/include/dt-bindings/clock/imx6sx-clock.h
> > +++ b/include/dt-bindings/clock/imx6sx-clock.h
> > @@ -275,6 +275,10 @@
> >  #define IMX6SX_PLL6_BYPASS		262
> >  #define IMX6SX_PLL7_BYPASS		263
> >  #define IMX6SX_CLK_SPDIF_GCLK		264
> > -#define IMX6SX_CLK_CLK_END		265
> > +#define IMX6SX_CLK_LVDS2_SEL		265
> > +#define IMX6SX_CLK_LVDS2_OUT		266
> > +#define IMX6SX_CLK_LVDS2_IN		267
> > +#define IMX6SX_CLK_ANACLK2		268
> > +#define IMX6SX_CLK_CLK_END		269
> >
> >  #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-clk"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger
> > .kernel.org%2Fmajordomo-info.html&data=02%7C01%7CAnson.Huang%40nx
> p.com
> > %7Cfaec2b0e3f024446b4b908d5a605f71c%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635
> > %7C0%7C0%7C636597466911971203&sdata=YXDSFv3JbKb26ncEJmpf0kUUp1
> DdVY6Fmc
> > utQZW1%2FM8%3D&reserved=0
