Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeEUCf1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:35:27 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:51424
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEUCfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:35:22 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Stefan Agner <stefan@agner.ch>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Adriana Reus <adriana.reus@nxp.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
Thread-Topic: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
Thread-Index: AQHT7kQ4PILLSsIoP0qk5wnhKU2GFqQ1dGcAgAQGcEA=
Date: Mon, 21 May 2018 02:35:17 +0000
Message-ID: <AM3PR04MB1315417C51882B554AEBC617F5950@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
 <c42c4274cfd06297d1699c96d3253125@agner.ch>
In-Reply-To: <c42c4274cfd06297d1699c96d3253125@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB436;7:stPB9UN1sypm7OXZSKn4tCquWeDeJ7JRLbyG4C2OKdDNSpwaK3TlJHqb/NxHMZpYB/SownnX0QUs1WRcUu+tGa1H6ausry75um7GGcEQT+7orWh/yCCC0nuswqnjyV0UrQbJmX5s05u6q5KT+Y/DmAem8ICbXSHw5Kwx44EfVt025f76GwjZu6XzAD4oEjBIW/rQc4LgD3+rbeN++VrUhVrHq1N06nHU2nBqBwa/8C+n17qis+O4j0zSoUo8BNvz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB436;
x-ms-traffictypediagnostic: AM3PR04MB436:
x-microsoft-antispam-prvs: <AM3PR04MB436FCC1DD5DAC936FA97E01F5950@AM3PR04MB436.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB436;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB436;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(199004)(189003)(13464003)(966005)(2900100001)(3280700002)(53936002)(97736004)(106356001)(5250100002)(86362001)(575784001)(9686003)(446003)(6306002)(105586002)(6246003)(486006)(102836004)(3660700001)(4326008)(2906002)(186003)(478600001)(45080400002)(476003)(44832011)(11346002)(25786009)(26005)(229853002)(7416002)(6916009)(74316002)(99286004)(8676002)(6116002)(59450400001)(76176011)(7696005)(5660300001)(66066001)(55016002)(81156014)(81166006)(8936002)(316002)(53546011)(3846002)(6506007)(14454004)(68736007)(33656002)(305945005)(7736002)(54906003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB436;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QUOg+bkA1u374CLpNbRL4LZTFDwwCNcGK9DolJM688xo2tQ1dXeSoP/U4/8FRsIgobPjXAa20sDaAZhDOBb5uQT52PouVlKlWG8qnIev+PZ97dbCX1jkc40sSyOAwctgWJ5ZYr/BWRROfe+dIP+vkj9eWx4pNweCOwKguN5dP08oYSrnnlJZfBd9pnBY+X8J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8c0f0309-a187-4d1e-10f0-08d5bec37d87
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0f0309-a187-4d1e-10f0-08d5bec37d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 02:35:17.5365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB436
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4L2ZXxn030391

Hi, Stefan

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Friday, May 18, 2018 9:02 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> mturquette@baylibre.com; sboyd@kernel.org; Adriana Reus
> <adriana.reus@nxp.com>; rui.silva@linaro.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-clk@vger.kernel.org
> Subject: Re: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
> 
> On 18.05.2018 03:01, Anson Huang wrote:
> > Correct enet clock gates as below:
> >
> > CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
> > CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
> > CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
> >
> > Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
> > IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.
> 
> Are you sure that IMX7D_ENETx_REF_ROOT_CLK are not used?
> 
> I understand that the reference manual does not a gate at 0x44e0...
> 
> But in a earlier revision of our Colibri iMX7 we actually used clock out, and
> referenced this clock to enable the reference clock (see also:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F9211371%2F&data=02%7C01%7CAnson.Huang%
> 40nxp.com%7Cea0856a68d8e4b921ba608d5bcbf9c02%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C1%7C636622453508888330&sdata=rEhwj0innLDc
> AEgxJyqd5vtG3SNVS05r2hEFvSc%2BQQs%3D&reserved=0).
> 
> I guess if the gate really does not exist, then we should/would have to set
> IMX7D_ENET1_REF_ROOT_DIV to use the SoC provided ref clock.
> 
> --
> Stefan
 
I looked into the RTL and also checked with our design team, they confirm that
there is no CCGR78(0x44e0) and CCGR80(0x4500) on i.MX7D, the register offset
are there, but no hardware wire connection for them. That is why they did NOT
list them in Reference Manual. So I think we can remove them. 

For your case of using them as clock input, maybe clock tree auto use its parent
IMX7D_ENETx_REF_ROOT_DIV which is existing, so it works.

Anson.

> 
> >
> > Based on Andy Duan's patch from the NXP kernel tree.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx7d.c             | 10 ++++++----
> >  include/dt-bindings/clock/imx7d-clock.h |  4 ++--
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> > index 23d5090a..d4936b9 100644
> > --- a/drivers/clk/imx/clk-imx7d.c
> > +++ b/drivers/clk/imx/clk-imx7d.c
> > @@ -26,6 +26,8 @@ static u32 share_count_sai1;  static u32
> > share_count_sai2;  static u32 share_count_sai3;  static u32
> > share_count_nand;
> > +static u32 share_count_enet1;
> > +static u32 share_count_enet2;
> >
> >  static const struct clk_div_table test_div_table[] = {
> >  	{ .val = 3, .div = 1, },
> > @@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct
> > device_node *ccm_node)
> >  	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk",
> > "mipi_dsi_post_div", base + 0x4650, 0);
> >  	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk",
> > "mipi_csi_post_div", base + 0x4640, 0);
> >  	clks[IMX7D_MIPI_DPHY_ROOT_CLK] =
> imx_clk_gate4("mipi_dphy_root_clk",
> > "mipi_dphy_post_div", base + 0x4660, 0);
> > +	clks[IMX7D_ENET1_IPG_ROOT_CLK] =
> > imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base
> > + 0x4700, 0, &share_count_enet1);
> > +	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> > imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div",
> > base + 0x4700, 0, &share_count_enet1);
> > +	clks[IMX7D_ENET2_IPG_ROOT_CLK] =
> > imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base
> > + 0x4710, 0, &share_count_enet2);
> > +	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> > imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div",
> > base + 0x4710, 0, &share_count_enet2);
> >  	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk",
> > "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
> >  	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk",
> > "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
> >  	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk",
> > "sai2_post_div", base + 0x48d0, 0, &share_count_sai2); @@ -812,10
> > +818,6 @@ static void __init imx7d_clocks_init(struct device_node
> > *ccm_node)
> >  	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk",
> > "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
> >  	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk",
> > "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
> >  	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk",
> > "spdif_post_div", base + 0x44d0, 0);
> > -	clks[IMX7D_ENET1_REF_ROOT_CLK] =
> imx_clk_gate4("enet1_ref_root_clk",
> > "enet1_ref_post_div", base + 0x44e0, 0);
> > -	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> > imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base +
> > 0x44f0, 0);
> > -	clks[IMX7D_ENET2_REF_ROOT_CLK] =
> imx_clk_gate4("enet2_ref_root_clk",
> > "enet2_ref_post_div", base + 0x4500, 0);
> > -	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> > imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base +
> > 0x4510, 0);
> >  	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
> > "eim_post_div", base + 0x4160, 0);
> >  	clks[IMX7D_NAND_RAWNAND_CLK] =
> > imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base +
> > 0x4140, 0, &share_count_nand);
> >  	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
> > imx_clk_gate2_shared2("nand_usdhc_rawnand_clk",
> "nand_usdhc_root_clk",
> > base + 0x4140, 0, &share_count_nand); diff --git
> > a/include/dt-bindings/clock/imx7d-clock.h
> > b/include/dt-bindings/clock/imx7d-clock.h
> > index b2325d3e2..0d67f53 100644
> > --- a/include/dt-bindings/clock/imx7d-clock.h
> > +++ b/include/dt-bindings/clock/imx7d-clock.h
> > @@ -168,7 +168,7 @@
> >  #define IMX7D_SPDIF_ROOT_SRC		155
> >  #define IMX7D_SPDIF_ROOT_CG		156
> >  #define IMX7D_SPDIF_ROOT_DIV		157
> > -#define IMX7D_ENET1_REF_ROOT_CLK	158
> > +#define IMX7D_ENET1_IPG_ROOT_CLK        158
> >  #define IMX7D_ENET1_REF_ROOT_SRC	159
> >  #define IMX7D_ENET1_REF_ROOT_CG		160
> >  #define IMX7D_ENET1_REF_ROOT_DIV	161
> > @@ -176,7 +176,7 @@
> >  #define IMX7D_ENET1_TIME_ROOT_SRC	163
> >  #define IMX7D_ENET1_TIME_ROOT_CG	164
> >  #define IMX7D_ENET1_TIME_ROOT_DIV	165
> > -#define IMX7D_ENET2_REF_ROOT_CLK	166
> > +#define IMX7D_ENET2_IPG_ROOT_CLK        166
> >  #define IMX7D_ENET2_REF_ROOT_SRC	167
> >  #define IMX7D_ENET2_REF_ROOT_CG		168
> >  #define IMX7D_ENET2_REF_ROOT_DIV	169
