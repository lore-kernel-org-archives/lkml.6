Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965158AbeEYHwG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:52:06 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:14492
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965049AbeEYHwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:52:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Date: Fri, 25 May 2018 15:51:08 +0800
Message-Id: <1527234671-31755-7-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:vaFJ5lpcl/39ZdhjgbESNhT8pSsK7rb7d3NuR7ytOradWMT4cL30BOMxzzCUUfbGbuyIQSon2HF2wwd+v+sfL3l5/HOiCX/PoLAbM0eMyzwg974e8MmMQA3Jj2/GSEOhppARNI8pHC5eE0K7qmIKsrwQHVWRH9Cb57ygXcM5vM1stv6287ve2vHZ7+KmRl6lNrf9o3UH4tbIF+h3o+XL8Jy5acxVNM3MFf5L2M2buNNH6/V+4SW7F9jGvQO6sV+d;25:axRhG+UuAD63h8p6cAaMqlEWzNhAKz7VqDmPBdpXF6KyOFMKbLs1FUmWXbZrymuK083o2nyJ6toNmiLpQ7WbrjcCEBdUE7fUYye5kFYfsa2EFP8228xLuRvZ2uczvEb0aupiroM5yd1Q2/+3fy8+mD2r+kqt2x05NG3nFfqWAIso5/yn7MMB9845BMOnKfV/uSNmkSUTuxEDdIxk+KFj7XUHp9h1Cys0udzQVZB/oDrJ5I/ybsYOKcq7zbVxtq9WaPps3q25iVSHTh96ulKX6BL6u08E18WwNaPZu6sfXhs+kcDJOI/uJLLP8PK1HAvDfHb9KAR07oDXf7AcAgtZUg==;31:RoXNk592jhXxLlV/sknAmlKY17/jE1/ZjT9bn8jSsXxYROxmPkwkoFudtBmuZl2w7ezfTbNajvIZIOqukwnXlTHvuZ+dr8n5LiEoF2S+e02D7EAYPCJP2l64Ni4i7XvvVM694OQvfsW8u0FEourGpi2DAI6tNzYEFqAiC1awTG3GTLZI5Dtme1F9IKndEpbBQU5iGkSSur9k6tOYL8faU4rhtfOcK/BEExMwEZbKh6I=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:YkA0h7JcvgVR93ZBne5ZUQG/S9kY/nCs6wu4A0b1CTD6dZuH1t5Abt8I0K3Ld0qVM1Qk2HMtjkLHK37BImMyAx0FoVOGnH55VCjqNQAL3DBeMgUFmgipXFgyJb+65dvXuCX0xvWX09kYcSx6OpxtXPiyT7tYjjfwbMBIHdVunu8+RaHBN9P6O6KG6iCRp2v5d78a2VdHtUn8FJtcKJ6o6BE4wHf0Gitoo7LCLuSwoS+sXqBmCZt0F9T0m+SNklybXLhSm3NFkxrxOu+JhMVbV23pBYrg75XcPf+uBD9f9JyZIFzhW+X+0dRzQ5Iiu4VIySgi4+ZUa3z6PxtZSekU1bH6iw0+ilxnn+dr2S3svj5/g+Qhy68yFTPnMPZylch8blrxepY4H1NpZXBnNQEGcULeRCS7TvDJFz7SRvRWJrwVLAxVCMX8v6Vld8QnFforxVOL5jIcIAcLSQdmervBHAOxPKAxFMgODCgnvE7WLCZearsnXRU8bbFHfVqHnAmH;4:qKphRHVIvdcweTCi6Knm3AUy9Ai1YZJPuy2bi+Mluui6a1u7DlN1RQ/qzRFdF0zuRBYRGPno9ZkyW8PvrJ17lAZGcZTrFNz24lKQ0Yoz86Tf1vIJ9pmxckkWvMXmPPjcUFjUu3SvIhFZhF9gnMpyiVHeZ96+ZPClEriMA1V++3yAi5ObWskE3xWeffsQBe+VcYEQ0UAAs9n2ZWYVQD46qwkpcRYIY5C3Zw1C7WCAKuEw+Qkg/fmkhS02+t+fM/eF541EfiLz5p6df1ZEVHFFBBMn0CmN8qZ5XLGjYtvoEFCm07W9fuDnRNZR6Dbk9y0fj/TM41zFwZiJgS/PokB11kgUIDn/cYDIzj+RjXZ8HAALn+slZOQQ+IUbwGFmJEJd
X-Microsoft-Antispam-PRVS: <AM0PR04MB421064733A5F54A8CB3C9C3E80690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(7416002)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:7OBCJsSWn0yCOesc0jtjS0LLD03oJZSWgHl1dgYlG?=
 =?us-ascii?Q?mUifu7xrsbL8wayhY7KDhGi9lxVv/a0sl6AEl4yOBR6p0mrqNTExpEIV8L7j?=
 =?us-ascii?Q?UhGvUNrx0E55Edom3yFsV0Vu9qa7YayciGffb/x5eatHa5IJqHo13Hi9j/BG?=
 =?us-ascii?Q?Kio/fD88m5+7a+eFzG0nw8YmO4A+DL921JFfVRi4PIIbAO5zXtp8R6zBLDub?=
 =?us-ascii?Q?OLpqJ0Y3ZbE4LB+YxUXhZoaT8X7fYwrm8vLq8UvvdRN6SJHMe3j+w9mHkU15?=
 =?us-ascii?Q?xjDrjuC8b9+m6c3i9QIYeBGxBqeu4qRpylIsNYk/6IWgSOWKeSNoz1nO/Oy4?=
 =?us-ascii?Q?b4RwyWuelrIsP7U8ftiVGg9dud0lDCZeXX5b5f3R4Ao36kQymLJKONYtWYFB?=
 =?us-ascii?Q?OYP/4klWZh/k5Ce/VopEqAMCke4m21y6NnlAfahcKN0b9XEjCn2Y7oFmdnvw?=
 =?us-ascii?Q?AjMUyl5W/Hal8v7Epe6+2m2z33eIbkewU5iE3jWMHPsF+buo9b884TcSoEzO?=
 =?us-ascii?Q?8e5OmMQYwx6VffVbajJ9yA7EushTOjhqSXy5kwxZVqVu4mtgQGQNseY151Ga?=
 =?us-ascii?Q?pBIoJNEsTfS6h9jTnYiBOpdkqQ9xkfo0syIkTJvcsbwTu2IOUzNwJipk21iQ?=
 =?us-ascii?Q?+KbtBzdZ/mogpF0uHIhoPI9+hOU9eW38lo2jjFavXUxdl3uomoFvxKqp3PXc?=
 =?us-ascii?Q?Az8mdoINrX9Dxmp3/gyTTE3qG8t+4RF339zdoLNNJ+dt1LDTaPiL0dAike1X?=
 =?us-ascii?Q?Q+Ojd/E/zFbjLcM/Pj5SBqJtjlAnaXb9T1VVFpgMJsOsfnkGf+6nrmXjq3Jk?=
 =?us-ascii?Q?b5ZpxZ5IfC1RMgqccrL0Gie51ugJKGa4U3Nu/IupRst8ENyi/2svUgHtqVr2?=
 =?us-ascii?Q?ID2N40SuDWmPUTsuJxZH77wIDWeeu17Mvj2oXXVs8w+lSgRvwGaoGJV+f98L?=
 =?us-ascii?Q?7Zo0HFDhUoPs1avRzaS+E33qH6crZmLYx29aU4+lNIB2AHUUj6JmLi4lMa8T?=
 =?us-ascii?Q?pWfr/Ac2vGaCUPAJXglGeWOmtAqhjGsoCa43mgf0QHQyO0efwZ+qssuEps1s?=
 =?us-ascii?Q?cJzDNyfcT2T0unDIlnYDFy1VE/3AEIdYpMhyQVtCW5Y2xA/xMlx0uR/h1Fp9?=
 =?us-ascii?Q?DdIGIkAZzd5S7DpE1IFYn+tucscXrw8tC5oLKj7yUS2FNOZrdx4rakGxXNet?=
 =?us-ascii?Q?PiMrc9VlPxiO3PDBt53M+TA042cMUwoxj/SEkHXS3DMm79wpxY6HzFRNdBla?=
 =?us-ascii?Q?lXGLcc32lKmRGwSofws7JeBVH/hPxSNzthUVagVkKSunRPY1gybnvOMAH5hF?=
 =?us-ascii?Q?NjDWjksb+bU6DZ4W3C6RdW7+1/D1gHrpyAQ7jJYjugw?=
X-Microsoft-Antispam-Message-Info: j0ASe76xSI7/fxTmc+NeNr4KkaXM7lKZ1Mwl46W9XogkQugigeF3EeyTyo+t2OXFvqQ8b8BnZnIy8mbXd+7oD4qJmOYoNBydcxZ0yRM07uBhk7eJIgSoEFz0QLUJT2BiBjL4BETfGpTpPLU4jryMqBXmpD9YXo49s1RANiUWI7g5pmESwoPN8/5fChYQGdtF
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:imS33wUQhzU1fmDN2m/vSuee2nvIRvI02I8/OqGHBajTvfY6gExP5x4Jqyxcwx/U/JG5nawvnFQ1GoafIDzreusEI5ydeHQ0kVUaJM+Kr2czU2tnkJDi0EWezUS90eXmLVTQFOdc4QEf7IQy5HdYWj7A9fD+dY2AtDxxcvT/EoqYSKooqNR+l6kkkqoiswvGFqhPGRyuJF3bkN4AGTrgrOl+tGkpZ6A8FRT1KT/0ytxVy+UgxqTlenX5/hXocTT9upTRTUwSBziwFeMYPtuG5Tt2b/EQ8Y11rSj5YHLXWr5Q/eZMPvQtgZl5KurdDn5Qt2NRv8QTd/04uAaz+S67SShaqWXB4IQWWqEO3lRVlu+EzLDtMr3aTb+3vDYnWIoPklaXBfzsYvVysLcFxlO/YgnMA3//EvHiUmXI8F0exCGkY/zO3dskdVCbF3A7dvofMyjYuiIKD8couoL271a3/w==;5:m/vI7Ve/4MDD0X4enKvrHhFMT1YrfaUPqzadMLBXoNUfFm4hGYsDqcDXEGhESjNZF+2euh1SNVVPs4shr+XR+eCxfvxFf9MEIHZHHPi3JhJxreDuuiY+fHPOKsSH6+ECtCMjJCg9NggLtd4mIuAIMsQHBfQJEnPi3iWmm+cmJ+M=;24:EvN1I7OXnHVaiRHLdZLsUHQerG/jEEmZDsztNF6BTIK6UlrENUVhRQCA0B2vnA8ZlH9D9c0EHpedNh+Iolwn3X32ag+/3ZrfaaXEP3rDbOs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:C3F+LNarDk/LnGTijYjbdNB+UiDOYm7qEe4fef3qH/xCwbIy/ByZ096Sk0QhOnks2ToPLEELESxmRN2gqikKLPBl71U1cRKA5vrLprL1ldtYGDLg9ukzhfE3OI4/ZmqL6MyTK2pNfsyBSMhD9yQhr93g8fgjCcn9yhB+6+U7j3iiVGtB1BzkMaes4f8yxZsBP/sigj/yLNcsYw8TO1/UFgxqCt9bUAt8/klb52pAp2dkuehmgb7xOSnY9z09jxVf
X-MS-Office365-Filtering-Correlation-Id: a2b6e796-83c8-4082-5f3f-08d5c2146415
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:53.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b6e796-83c8-4082-5f3f-08d5c2146415
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

Note IMX7ULP has two clock domains: M4 and A7. This binding doc
is only for A7 clock domain.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++++++++
 include/dt-bindings/clock/imx7ulp-clock.h          | 105 +++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..76ea3c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,62 @@
+* Clock bindings for Freescale i.MX7ULP
+
+i.MX7ULP Clock functions are under joint control of the System
+Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+modules, and Core Mode Controller (CMC)1 blocks
+
+The clocking scheme provides clear separation between M4 domain
+and A7 domain. Except for a few clock sources shared between two
+domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+and and the Fast IRC clock (FIRCLK), clock sources and clock
+management are separated and contained within each domain.
+
+M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+Note: this binding doc is only for A7 clock domain.
+
+Required properties:
+
+- compatible:	Should be "fsl,imx7ulp-clock".
+- reg : 	Should contain registers location and length for scg1,
+		pcc2 and pcc3.
+- reg-names:	Should contain the according reg names "scg1", "pcc2"
+		and "pcc3".
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-name:   Should contain the following clock names:"rsoc", "sosc",
+		"sirc", "firc", "upll", "mpll".
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See include/dt-bindings/clock/imx7ulp-clock.h
+for the full list of i.MX7ULP clock IDs.
+
+Examples:
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+
+clks: scg1@403e0000 {
+	compatible = "fsl,imx7ulp-clock";
+	reg = <0x403e0000 0x10000>
+	      <0x403f0000 0x10000>
+	      <0x40b30000 0x10000>;
+	reg-names = "scg1", "pcc2", "pcc3";
+	clocks = <&rsoc>, <&sosc>, <&sirc>,
+		 <&firc>, <&upll>, <&mpll>;
+	clock-names = "rsoc", "sosc", "sirc",
+		      "firc", "upll", "mpll";
+	#clock-cells = <1>;
+};
+
+usdhc1: usdhc@40380000 {
+	compatible = "fsl,imx7ulp-usdhc";
+	reg = <0x40380000 0x10000>;
+	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&clks IMX7ULP_CLK_NIC1_DIV>,
+		 <&clks IMX7ULP_CLK_USDHC1>;
+	clock-names ="ipg", "ahb", "per";
+	bus-width = <4>;
+	status = "disabled";
+};
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
new file mode 100644
index 0000000..2b6a29d
--- /dev/null
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
+#define __DT_BINDINGS_CLOCK_IMX7ULP_H
+
+#define IMX7ULP_CLK_DUMMY		0
+#define IMX7ULP_CLK_ROSC		1
+#define IMX7ULP_CLK_SOSC		2
+#define IMX7ULP_CLK_FIRC		3
+
+/* SCG1 */
+#define IMX7ULP_CLK_SPLL_PRE_SEL	4
+#define IMX7ULP_CLK_SPLL_PRE_DIV	5
+#define IMX7ULP_CLK_SPLL		6
+#define IMX7ULP_CLK_SPLL_POST_DIV1	7
+#define IMX7ULP_CLK_SPLL_POST_DIV2	8
+#define IMX7ULP_CLK_SPLL_PFD0		9
+#define IMX7ULP_CLK_SPLL_PFD1		10
+#define IMX7ULP_CLK_SPLL_PFD2		11
+#define IMX7ULP_CLK_SPLL_PFD3		12
+#define IMX7ULP_CLK_SPLL_PFD_SEL	13
+#define IMX7ULP_CLK_SPLL_SEL		14
+#define IMX7ULP_CLK_APLL_PRE_SEL	15
+#define IMX7ULP_CLK_APLL_PRE_DIV	16
+#define IMX7ULP_CLK_APLL		17
+#define IMX7ULP_CLK_APLL_POST_DIV1	18
+#define IMX7ULP_CLK_APLL_POST_DIV2	19
+#define IMX7ULP_CLK_APLL_PFD0		20
+#define IMX7ULP_CLK_APLL_PFD1		21
+#define IMX7ULP_CLK_APLL_PFD2		22
+#define IMX7ULP_CLK_APLL_PFD3		23
+#define IMX7ULP_CLK_APLL_PFD_SEL	24
+#define IMX7ULP_CLK_APLL_SEL		25
+#define IMX7ULP_CLK_UPLL		26
+#define IMX7ULP_CLK_SYS_SEL		27
+#define IMX7ULP_CLK_CORE_DIV		28
+#define IMX7ULP_CLK_BUS_DIV		29
+#define IMX7ULP_CLK_PLAT_DIV		30
+#define IMX7ULP_CLK_DDR_SEL		31
+#define IMX7ULP_CLK_DDR_DIV		32
+#define IMX7ULP_CLK_NIC_SEL		33
+#define IMX7ULP_CLK_NIC0_DIV		34
+#define IMX7ULP_CLK_GPU_DIV		35
+#define IMX7ULP_CLK_NIC1_DIV		36
+#define IMX7ULP_CLK_NIC1_BUS_DIV	37
+#define IMX7ULP_CLK_NIC1_EXT_DIV	38
+
+/* PCG2 */
+#define IMX7ULP_CLK_DMA1		39
+#define IMX7ULP_CLK_RGPIO2P1		40
+#define IMX7ULP_CLK_FLEXBUS		41
+#define IMX7ULP_CLK_SEMA42_1		42
+#define IMX7ULP_CLK_DMA_MUX1		43
+#define IMX7ULP_CLK_SNVS		44
+#define IMX7ULP_CLK_CAAM		45
+#define IMX7ULP_CLK_LPTPM4		46
+#define IMX7ULP_CLK_LPTPM5		47
+#define IMX7ULP_CLK_LPIT1		48
+#define IMX7ULP_CLK_LPSPI2		49
+#define IMX7ULP_CLK_LPSPI3		50
+#define IMX7ULP_CLK_LPI2C4		51
+#define IMX7ULP_CLK_LPI2C5		52
+#define IMX7ULP_CLK_LPUART4		53
+#define IMX7ULP_CLK_LPUART5		54
+#define IMX7ULP_CLK_FLEXIO1		55
+#define IMX7ULP_CLK_USB0		56
+#define IMX7ULP_CLK_USB1		57
+#define IMX7ULP_CLK_USB_PHY		58
+#define IMX7ULP_CLK_USB_PL301		59
+#define IMX7ULP_CLK_USDHC0		60
+#define IMX7ULP_CLK_USDHC1		61
+#define IMX7ULP_CLK_WDG1		62
+#define IMX7ULP_CLK_WDG2		63
+
+/* PCG3 */
+#define IMX7ULP_CLK_LPTPM6		64
+#define IMX7ULP_CLK_LPTPM7		65
+#define IMX7ULP_CLK_LPI2C6		66
+#define IMX7ULP_CLK_LPI2C7		67
+#define IMX7ULP_CLK_LPUART6		68
+#define IMX7ULP_CLK_LPUART7		69
+#define IMX7ULP_CLK_VIU			70
+#define IMX7ULP_CLK_DSI			71
+#define IMX7ULP_CLK_LCDIF		72
+#define IMX7ULP_CLK_MMDC		73
+#define IMX7ULP_CLK_PCTLC		74
+#define IMX7ULP_CLK_PCTLD		75
+#define IMX7ULP_CLK_PCTLE		76
+#define IMX7ULP_CLK_PCTLF		77
+#define IMX7ULP_CLK_GPU3D		78
+#define IMX7ULP_CLK_GPU2D		79
+#define IMX7ULP_CLK_MIPI_PLL		80
+#define IMX7ULP_CLK_SIRC		81
+#define IMX7ULP_CLK_SOSC_BUS_CLK	82
+#define IMX7ULP_CLK_FIRC_BUS_CLK	83
+#define IMX7ULP_CLK_SPLL_BUS_CLK	84
+
+#define IMX7ULP_CLK_END			85
+
+#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
-- 
2.7.4
