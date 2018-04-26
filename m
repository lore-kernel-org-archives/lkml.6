Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeDZHDO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:03:14 -0400
Received: from mail-ve1eur01on0078.outbound.protection.outlook.com ([104.47.1.78]:65264
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753022AbeDZHDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:03:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/6] ARM: dts: imx6sx-sabreauto: add fec support
Date: Thu, 26 Apr 2018 14:58:16 +0800
Message-Id: <1524725898-27974-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:604:d::30) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:bIFvOLoqctIW0xPxI6xj/TTClm8AVJJATfabP6p//s9jbYNFrmUATTmE08WCY30DDE88PK3nZM9ISeGUbbmHISoIpAgnrpJziWrXfntSYhUkrltuXNxMz2zSupnMEI/6aZnYJ4rlOMJSFvXF0EqYG8xqd4ZaxdyvaRcQs7bgAAI+WqpJJQrsVf3Nn6bVsu8GlTAeGoddrLjMVZeBBP9+OZemAwEs8j+g/Iby1WAwwmuYnubmovLnBPy8XLabvfed;25:iXNt0UK0ojwsGCV3sMPqXcyphHg8OZkMme3DEb5MM080ESWQ6XXe+C7w6w6IDWsuNiPe7l/oFALftaCXNEYHFscmmv2BL8vEzuZBhpHgYE/U3hHRn0nniFXizb2C3GuNSz6NsUxlJUUkDJpBtTtAzT8YYj6ykjy3Ep/NXOXraOo1/hw//J8BXXXxHH2UH4TOvb+bbXtMyhi0y9gkVamUzLQKBBLF0+j0nkXaNK5SGQ5ULh2VDHhzWrPMAHYP+mwlZjpqssF/og50pcffc7U4S28gUeTZBISD8MtXLiKJcu6inR00VsTRcNzMdyvcvquhWxb/ms+yCG00AUBozZFrsA==;31:EHXjOd4TdZ8RnzEiQyAQhBIHXGLlrijX7rrhWhVdWgH66Z0C/fKOXdqI5/0/9667R3GHeqwCcxAS8aIFs9LhQKaaggPXyeaWmXinAt1uvu9XoGG9stYCoQg06Ity13Xj2uMVT9tMXtUnrrChRBcl6LVzglyjWtauDAEjvn31PLsPTO8TalyrVudvl+Be+aIoNaBDN7anmumgJoPccnTC73NeVvX2oRze/yGcQQlmm5U=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:ms6a08rsrNAyypjDWnKoPkc5xB4qk+VY8plJjkyv9jNlojkEehP3Z542gxkGOeXtzcjpMCgIwrILWRszz0dcLR8njvWeltQ/6gvv+FfEy/fsuOVI03IApyg4l7Qf0CuEXH5z9k/1e0sTRdQbr+U2+8z5bVb0f4puc8mknOT3+ZWdLNRxrAkrt5rwZ8VBOCXq9xuqNHFxO3BfNpPLfyghcEoj9fGocpg8sYoO4yc/dEOof3oP+HVsbr2wpPNxYW+JJ0kjqW2iRnpk39p3dq0jZJ5WR7mPMT6qDiVFZfNtu5Dn6Pt5QqcyC8PQ6SkfZWMs1CyNmfkfSkM06M/ZVgg2oPeSCMVKcov5SPsjlG752jZg1vriB+69PhsHqlo2aa2RPIAtfkncgU4uNszgIMK6/NBLy1FhparFZRnzW6sUT01XgDa9l5lw3E5Ej8wUqwhRNIkywf0XwinqJGLIO1nQa/LT2Rb65NlJWNpAZW8nE0XhblaEPGHdyUI7Zd9DjwqH;4:+hTJ+drx2c9pOrgdxGmrxTsr0usEvdx9RBpAQ/Fu3fjXyjGlJZ6Lz2svyKCQCy7fdROcVPuPyQJ8Ea1wUuoJGZHejQ175tDqQB1mJSWpIBnt53o6UXckZY7ila5gHG7PJ4tubm9B44S3M01rirGYTCv8FmjItz6+sGlcgNeREgo2IjjREEMjzlxTfO9VMH2j55fPGWifnIif1E2zHJdxJSVgDOznXc1KXz58mPqpK/qgFb9DkxURywhnjleC4bB4oNdTG/GT9zMlVDQUo0ZZTkjVZ2CSLXxsM+URoB7lIAxvj352/faDpMFYTMMDrgsz
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327D5998475CCC9DDC775CAF58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(11346002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(446003)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(76176011)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(575784001)(4326008)(86362001)(48376002)(66066001)(476003)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:e6vIIhUz5L+aitsblLfJuBLBSL8ThM/9JQJ2IskJx?=
 =?us-ascii?Q?dpGc/vWC4Yhb7raOnyJOxoNNEOUDj6cztBTR8QQny2fb99sFzv1r6cSFhbMT?=
 =?us-ascii?Q?9g1pOvmoafwPdAc2ZYSyq0ZkWaY7PZA+VkCoZyvvVU/njHl7d4F9Fp8y9y/x?=
 =?us-ascii?Q?c0yFnwUMZZbzsXjPqAPD1m089p/2SmK4En1cKWe+IN76ktnQ1IYVN7pyZ6kA?=
 =?us-ascii?Q?dTSctEGM6x7J3F+KNCga7SDqvS/9tBfdt/wR+SbShidhCUZ08mtQ7RoQwoIt?=
 =?us-ascii?Q?i/1iNWLnLuGG1/gItH3RE0rFc3dvhrjqsSyKgrhlEuh9h9IhESh3tQuVjS3t?=
 =?us-ascii?Q?rFIUkszgKQ50V+Imv24SQVFfeqtE7GBi9AVYleqEbEdYG8l/XLWIrKRxoWWD?=
 =?us-ascii?Q?rt/xwtMpbLOkjiqf+N57kfHYKouLqEgPA5+aVMh3IwxKSqucmTP+mHDvKIvo?=
 =?us-ascii?Q?tVuuJ1g4RwKJrh/hwwmMtSuo9iBa0htlrgNSA37oaqSz9yEIj7JduPX7t2zT?=
 =?us-ascii?Q?hy6JsQmrTSw9oIk2yIVRnH4Mq1GZThQ31YK7Usk69aFkxcJHOQ/7Wqw+pPCA?=
 =?us-ascii?Q?HFOeGawBqnEQJTTnPhul7W7amp8S4SFWX5an9Ptgh+FqaiQVYLp2yjspQwEI?=
 =?us-ascii?Q?PICi0+2ZNktIPxgiN3hGT9lpMWFTT31ZjsB8s7aQ1sP6ZFNyKLEazL03uiXm?=
 =?us-ascii?Q?svXkPhB4HuTN7g2aVDVwsxmbS22ht0HdNcxJLzcKbk/K7TOt7haqf9hl0OCn?=
 =?us-ascii?Q?1mbvS4Rj504mxN+CMQzUhBdEiuVf+DWTMoaHlquaduTtWl8l/iC1+ZQvNzx9?=
 =?us-ascii?Q?DKGulNFqnNymYwTOmNbUllzLhqSajaK8TvXaOsWxIAag/DjLiGADQXwnxWne?=
 =?us-ascii?Q?3AhCkXg48nGds1Nl4D5N0YW96Ayvpkj3zngN2hmhvs33lIJ2EDLK3IICueHY?=
 =?us-ascii?Q?FLaqnNAPfN+MaU5W7MxcAYyTl/VW8lxcd42qcyWWggBBVxJ0rV8eDFbxQY6f?=
 =?us-ascii?Q?8BFNXZvGXoGyDjJdxstBDfGBagb4xaJZ/ySoG9iC9PAWJPo2fGBjQQRmOb0s?=
 =?us-ascii?Q?PB+ceJVIvEBRvWSMUFjQYqmGXY85inM9tvCaBLcTVIFi8weBsE/FpgY2W8Yl?=
 =?us-ascii?Q?NYTgr5RqSthjZ83UHV1dYpe9yRqbuqCgiwbPSKW5ZY/YsXXLrs2qbiu+dAja?=
 =?us-ascii?Q?itKdBhgvoTuC83HFMEnloWFFkR3FkEOOyAx?=
X-Microsoft-Antispam-Message-Info: gn1zhkUFB6ScGLhLuLlQERv9J2wXXAgSAQanaLRWj4Cg5eNJSs77CD4opflLtscr3zVQrEzgw3XkTdwkZp6nc0Yl8UrR/MXpnDsbl7L9RMJC/TCHeAwh6BXdYTYrCgLLo37W7K+5ClLaE1fkUIcuouNhLLdkhyHmQkj5R5wTV3UcMHpFSEyPBC2rwuYgv87s
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:Gq92If2e39BdLdGPMM3Tyx1mwzhPskDJf9wMlW9rIpPuI/820fXPX3QU57pMTl+yhwjfWxbifO7gkiRxpIs4wz2aNmO/e8qmUnDMXqTX+vtMouoleDMCjnlF/8+FuAQYkXG9otde5YXtKVdxIp6u78KondXiJBKT8k9ZE5dFCF/Q/GGlTTCQELnJ/DCdIG2/QPqJafUGUUCKk4HGtlhVwIgcrx34GSEutPdb7Tzvw2BZKxqzF0ozml+GTQueM4wXrO/h9cTHjfwAdI6qQCuvxvcof8NsNQLQ2L5XvPc4WzHuZV7lBgaroByvgXcHXrTgSiDC5rrnkEH/CFLqYqn1KHuO2Y//Wmzc08rFnObjnKAfmAAdZVoU3hx2HTYLnjZ/F/LpyVrzrgZ+v/l2KokYyXvOzdZTcEHl59WUZRv8hBoQRiv+Bp6VPIOWRQbYqmcW6wD0GR5EnkGeUGnfrUVELw==;5:VhTM6TOeNgDKKBbnVa30QBbNKj+4blKhbCnmZaAfKzMZlQcW5U/oJ4DoSGXO0fFyasOHCdlLSwjPmd/SDuPRm0zetDGzNxeh/zlkzzSuZB5uRg3tXhEmgUpLUR/9XJLrxh2zNhrzzpS/NnyiZmFkIfVDgFMYHn9b2N0bIf+x/gE=;24:CtViOttNDIoqUNyD+8XE24iwh5SAa7cxr0zBa0B204UuLDBBgE4pf+/rkZWwJIQ6pryPwcCVItjUDVFUcri4Kfok04iB2m7Qgli+yHKEARg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:D3b9xEiU7ibWaT/gm4AVgbWEi2ArOLbZFtClPAX/OiIKdutXIdbEcBo0cuOu79HOwLOW6K8KLm6H5RornNPmECnLAdWXfUXw7Dbe/ugk4diiq1H3W7chKU01nzCFFkycevOOXouuSGV7UWsk944PLhbmnhHC7S3FtKKG3YSVdno9AzUdn7Rr8157GzdJuA6EU8NvR+pr7vDSkMdz2OCBfwV9eDBXLtaSw/xvP8BSyLy+Kl3dHEjnk2/RNmznF+t8
X-MS-Office365-Filtering-Correlation-Id: bf9d0557-f1cb-4047-3272-08d5ab43c0b5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:02:58.2518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d0557-f1cb-4047-3272-08d5ab43c0b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V4:
	add fec gpio regulator and set its default value to LOW for 1.5V IO purpose.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 80 ++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..088a66c 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -23,6 +23,17 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		reg_fec: fec_io_supply {
+			compatible = "regulator-gpio";
+			regulator-name = "1.8V_1.5V_FEC";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1800000>;
+			states = <1500000 0x0 1800000 0x1>;
+			enable-gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+			vin-supply = <&sw2_reg>;
+			enable-active-high;
+		};
+
 		vcc_sd3: regulator@0 {
 			compatible = "regulator-fixed";
 			reg = <0>;
@@ -41,6 +52,39 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2_1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -75,6 +119,42 @@
 &iomuxc {
 	imx6x-sabreauto {
 
+		pinctrl_enet1_1: enet1grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
+				MX6SX_PAD_ENET1_MDC__ENET1_MDC          0xa0b1
+				MX6SX_PAD_RGMII1_TXC__ENET1_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII1_TD2__ENET1_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII1_TD3__ENET1_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII1_RXC__ENET1_RX_CLK      0x3081
+				MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
+			>;
+		};
+
+		pinctrl_enet2_1: enet2grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC   0xa0b9
+				MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0   0xa0b1
+				MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1   0xa0b1
+				MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2   0xa0b1
+				MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3   0xa0b1
+				MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN    0xa0b1
+				MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK      0x3081
+				MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0   0x3081
+				MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1   0x3081
+				MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2   0x3081
+				MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3   0x3081
+				MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN    0x3081
+			>;
+		};
+
 		pinctrl_i2c2_1: i2c2grp-1 {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.7.4
