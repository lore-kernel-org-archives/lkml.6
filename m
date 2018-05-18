Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeERBGg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:06:36 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:19480
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751642AbeERBGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:06:33 -0400
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
Subject: RE: [PATCH 1/2] clk: imx7d: correct enet clock CCGR register offset
Thread-Topic: [PATCH 1/2] clk: imx7d: correct enet clock CCGR register offset
Thread-Index: AQHT7bs3V8XBo4AVBk6jB23uNmsD/qQzxy6AgADlxoA=
Date: Fri, 18 May 2018 01:06:23 +0000
Message-ID: <AM3PR04MB1315B94AD4563479BC9A35E1F5900@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526546422-7431-1-git-send-email-Anson.Huang@nxp.com>
 <96f2ab49e1a9c03ccd477346b8285c76@agner.ch>
In-Reply-To: <96f2ab49e1a9c03ccd477346b8285c76@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0647;7:imGQYdzV7q7Ph8B7Ipop8/wj70rVhE6S5yaf1y77aZ3nnpd62Wg2i7OaLp+SETAvo5sCeJU/3DiijiqQOQXuJLAiXp5zUUSDnzFnseExjmJcmPtr3twJHr/0xeQxlrc3viADAu5Gif/PGEG8+QseMKQrDeUx+aJXiOf6ez74IWjsEFx25q2tLTor90eiLt1CE7ZyImwXuDRcNuYE0xzewj4dEwXZcrNaT2Y2odhqHgncM3DrCaxQYd4FjxWY8lx0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0647;
x-ms-traffictypediagnostic: AM3PR04MB0647:
x-microsoft-antispam-prvs: <AM3PR04MB06470121EC9A64142A07740BF5900@AM3PR04MB0647.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0647;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0647;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(39380400002)(376002)(13464003)(189003)(199004)(66066001)(7416002)(229853002)(74316002)(7696005)(105586002)(53936002)(2900100001)(33656002)(446003)(11346002)(5250100002)(102836004)(76176011)(8676002)(106356001)(6436002)(3846002)(14454004)(86362001)(25786009)(97736004)(478600001)(5660300001)(99286004)(8936002)(6116002)(81156014)(6916009)(305945005)(26005)(7736002)(186003)(81166006)(4326008)(6246003)(2906002)(486006)(53546011)(316002)(59450400001)(55016002)(9686003)(6506007)(44832011)(476003)(54906003)(68736007)(3660700001)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0647;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Zwpo0Ccy1ErlK3J9SkEzrpWS2SmsM956f2C4E5O/OXCx+sshvQaioZB9R7i50mVYfPjoAC0uU5XTCJ3Hc2WG2jBr7+6acws/4K+6+1SMTgna0x/EmEsr/uVJ8so3iiL0fZnQJKqoavnpjIsXGAgxVlAYD4KelL0xre0TQRJGiN+MfIwOGdrW7Ol6Gcug6Myf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 58b5068a-4fe9-4e9a-0309-08d5bc5b92bb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b5068a-4fe9-4e9a-0309-08d5bc5b92bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 01:06:23.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0647
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4I16fKg025402

Hi, Stefan

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, May 17, 2018 7:22 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> mturquette@baylibre.com; sboyd@kernel.org; Adriana Reus
> <adriana.reus@nxp.com>; rui.silva@linaro.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-clk@vger.kernel.org
> Subject: Re: [PATCH 1/2] clk: imx7d: correct enet clock CCGR register offset
> 
> On 17.05.2018 10:40, Anson Huang wrote:
> > Correct enet clock CCGR register offset.
> >
> > CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
> > CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
> > CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
> >
> > IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY, no gate after this
> > clock, its parent clock root has gate.
> > IMX7D_ENET1_REF_ROOT_DIV/IMX7D_ENET2_REF_ROOT_DIV supplies
> clocks for
> > enet IPG_CLK_RMII, no gate after the clock, its parent clock root has
> > gate.
> >
> > IMX7D_PLL_ENET_MAIN_125M_CLK (anatop pll) supplies clock for enet
> > RGMII tx_clk.
> 
> As far as I can tell there are two changes here in one patch:
> 
> 1. The non existing IMX7D_ENET_PHY_REF_ROOT_CLK gate is removed
> 
> 2. Shared clock gate for the enet time/ipg clock is taken into account.
> 
> 
> I would rather prefer to have separate patches. The device tree change also
> does two things, so this would lead to 4 patches total.
> 
> We can avoid the device tree change for the PHY clk and even maintain
> backward compatibility for that part by renaming
> IMX7D_ENET_PHY_REF_ROOT_DIV to IMX7D_ENET_PHY_REF_ROOT_CLK.
> 
> 
> So this would end up with the following first patch to address the PHY_ROOT
> clock issue:
> 
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -738,7 +738,7 @@ static void __init imx7d_clocks_init(struct device_node
> *ccm_node)
>         clks[IMX7D_ENET1_TIME_ROOT_DIV] =
> imx_clk_divider2("enet1_time_post_div", "enet1_time_pre_div", base +
> 0xa780, 0, 6);
>         clks[IMX7D_ENET2_REF_ROOT_DIV] =
> imx_clk_divider2("enet2_ref_post_div", "enet2_ref_pre_div", base + 0xa800, 0,
> 6);
>         clks[IMX7D_ENET2_TIME_ROOT_DIV] =
> imx_clk_divider2("enet2_time_post_div", "enet2_time_pre_div", base +
> 0xa880, 0, 6);
> -       clks[IMX7D_ENET_PHY_REF_ROOT_DIV] =
> imx_clk_divider2("enet_phy_ref_post_div", "enet_phy_ref_pre_div", base +
> 0xa900, 0, 6);
> +       clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_divider2("enet_phy_ref_root_clk", "enet_phy_ref_pre_div", base +
> 0xa900, 0, 6);
>         clks[IMX7D_EIM_ROOT_DIV] = imx_clk_divider2("eim_post_div",
> "eim_pre_div", base + 0xa980, 0, 6);
>         clks[IMX7D_NAND_ROOT_CLK] = imx_clk_divider2("nand_root_clk",
> "nand_pre_div", base + 0xaa00, 0, 6);
>         clks[IMX7D_QSPI_ROOT_DIV] = imx_clk_divider2("qspi_post_div",
> "qspi_pre_div", base + 0xaa80, 0, 6); @@ -816,7 +816,6 @@ static void __init
> imx7d_clocks_init(struct device_node *ccm_node)
>         clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base + 0x44f0,
> 0);
>         clks[IMX7D_ENET2_REF_ROOT_CLK] =
> imx_clk_gate4("enet2_ref_root_clk", "enet2_ref_post_div", base + 0x4500, 0);
>         clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base + 0x4510,
> 0);
> -       clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base +
> 0x4520, 0);
>         clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
> "eim_post_div", base + 0x4160, 0);
>         clks[IMX7D_NAND_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base + 0x4140,
> 0, &share_count_nand);
>         clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk",
> base + 0x4140, 0, &share_count_nand);
> 
> 
> A second patch would then fix the clock gate issue and the third the
> unavoidable device tree change for the ipg clock.
> 
> --
> Stefan
 
I follow your suggestion and re-structure the patch set to 3 patches, please help review it, thanks!

Anson.


> 
> 
> >
> > Based on Andy Duan's patch from the NXP kernel tree.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx7d.c             | 11 ++++++-----
> >  include/dt-bindings/clock/imx7d-clock.h |  4 +++-
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> > index 975a20d..485ab49 100644
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
> > "sai2_post_div", base + 0x48d0, 0, &share_count_sai2); @@ -812,11
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
> > -	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> > imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base +
> > 0x4520, 0);
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
> > index b2325d3e2..fef0647 100644
> > --- a/include/dt-bindings/clock/imx7d-clock.h
> > +++ b/include/dt-bindings/clock/imx7d-clock.h
> > @@ -455,5 +455,7 @@
> >  #define IMX7D_SNVS_CLK			442
> >  #define IMX7D_CAAM_CLK			443
> >  #define IMX7D_KPP_ROOT_CLK		444
> > -#define IMX7D_CLK_END			445
> > +#define IMX7D_ENET1_IPG_ROOT_CLK        445
> > +#define IMX7D_ENET2_IPG_ROOT_CLK        446
> > +#define IMX7D_CLK_END			447
> >  #endif /* __DT_BINDINGS_CLOCK_IMX7D_H */
