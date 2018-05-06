Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEFGc4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:32:56 -0400
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:1953
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751123AbeEFGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:32:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 4/7] ARM: dts: imx6sx-sabreauto: add fec support
Date: Sun,  6 May 2018 14:28:10 +0800
Message-Id: <1525588093-29994-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KAXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::29) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:urNDbBYEzy5v3opzs7hKXNyJHjy92AhfWshOMPoe4W9SwSMJdC/Kk6b2WXd1CMcF7CEJEX/bxrfDNz3xm/znVLVNejjvxpMJNBMiYSfXbP0GOd938iRmwo3qEj364W8ud/Sz2PwDTmVvvlV+FbOe/k5K03kl5NH1T3xfawGHsMC0fUIR9eUuWyA8S3NDY6wj9NYyIEcN9uzig71rJvb5a61TQzHkFaBJlEbx9+D4lDXSunjHH7cn2Ef4XmKvTpvV;25:j1X/yfgrcRyslJYyOccuAFWkTQa9t6FiCg/F8dWP3tQ/pQRT+Nfuu1cWjFT67YimMEuF8Yk3Pevovw9dsgTNyOYT0eEssg72SSWmZh9hBeKTv4p/HSKl4o2PutEmHo2MPjLlzDVoYEOkTrQsdaDqPN1CTyD+j947MuRT4mLfKQzNwBaR9mKM0j1huXyiaOMWO8ZOD3xygY5j8Ua+B57ysBYBh8H92gaN61nh7wz09FICVKGF1GtA/mz55PU2ThbgE/3KH6cwJQhVTCkhQpbucvQ8GRLZkS/Qm/n6N6yCbrnHXAIbUMYNF09j2j91PHjw4wvGHWawUCFGRH72DvAF6g==;31:U1Ew5WKjH3IHy4YZMMy9XWUpy8Z+xU9y1EpkAS3TJQakhBrmB2ofLZNdvibY+MIMWPV+xuQP9UKmHGUOC2S3MpfdJw6V6VywpFj5lw/QHg6qXzZE83MbrKuvHIib83QaGGKTZUXQXORhTKmsHIKX53n89Jddzqgw1YqHMG+qKDdWKeIil1AlfOZidzyW7BJwnEzWjXbbt/qkP6yBi1o5D9NJFVUQFa7UEegrtCtrcNw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:Kb5KbaQtSIsQSjTPF/Cx377hdgiq+SanRAxeSbxEWKO6zTCOYp9Lv+kLgJfvdkgNjSg/f+Quvo8Rm8vr4JzlqXIsRefbqQVcvxCM2Pc3kNwfTRwPyxq8ZMZBflq0EtArrgpDMenuHpnFwj6i11lQbrl0UggaTby0KdA489W4aq87Sgj3jMe7/V1/htqFDDc057AxGgsy0gF8kDm+uJwp5OBxoyhaMtoxlopigM979rJGkdfIOcGwCSjmypeQm9RqZ7zqV3LGHLqoo18m4US/O2mRZik0GGvhc5NKAzyk/OIWfs1qijE+kAKPUo7ZFPMQT7X2EuYFzZLCNnACNBFaqpw/aYqZnN++P0hGughT4saPIAdz6oqBp1/k5YqA8fEtiPP3RW/aPL5LPPaW0m8ixRb1JHxT6s1if67nTflfPPmTTYZTGMxZ0La7WaJoNCwTYwTH32h2JNPXYOTIjIFSBrayhq2MnXZfADJ2DKp8N45CikB5eRYUAFiZiXgFSMqh;4:zcSyzgsf9+yw8gbEB+mwmTWsw+/IHHBUfpIOBXPItNp70wYnKr1NU4PvYJ1WwKASVrcgFVdukGIaMWisOTi150QxD36UUaRaQ/k23PzAWuhVcWHYQG0FGzB8utpcr9Q6sCfUDio2nEXtUjg2RZ+lRUBVLJaEIq36QumAgn/L0eW5PFzgnNZt84qUPWkFPaiMGf850iH3XiiEnrN6vwdGLlQDH1EFbXEsVYKY1HYvO+0wRA4+EGH16ccLKQ7Znp5L3AVhaqixQ5ckHsYGSkL4gpH4Bkj4+Jnq7N5PfuQhC3rasDse8sMy7LhF+26iuR5c
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323EC243BEC69A35F15D68AF5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:bYp46ZzDylOpJmpYS5/On/9lAj05hFaVvC9xzWQJL?=
 =?us-ascii?Q?cNSNH2543IR6YDaa1tk8YlicC8BVFdb8Ojlllpk+hnXOJcxktSKWwZlfGexF?=
 =?us-ascii?Q?qaI6PV19xaBZqB9PF09eJA3r7RkAaF9mr6i5JnbM1obLeBDST2qHe/DBipdA?=
 =?us-ascii?Q?bOKuLtnBXCLI1mKjEZIqVC6hiOsqtRcqtevQV7tJBKUGEjzOUJ3MKEJngbGW?=
 =?us-ascii?Q?dFgWFwGcmQUqApMZHSgeDquLl9FnsafgDd2ZGB060FaBt2KyKDHWxcum2nbJ?=
 =?us-ascii?Q?Jlgq35ATsmSSqvOSfSxFO+ZNNw/cIbmTRI04K7+Xj8y9YJO7s1L0MF09x9/X?=
 =?us-ascii?Q?7nC+RvHB246MZlomftM4u0s9FVdaSKGp3tc+SwdJjma+jcrxNEpP0GVyY1Fm?=
 =?us-ascii?Q?Apv6RC8ficUOKB2m5S2gmgJ/LdyGAUEia2dBowE8cXqtDi5axQ5Nv5KRT0D8?=
 =?us-ascii?Q?rU58FrT5u4SS4bMzD+A/IdIvvEwc7r0BGGdaohcmE3xTcw4N2O1jTmBkpMgU?=
 =?us-ascii?Q?NYqXYqYv7uiOrV5+wuH4uTdHv+FYaj5Ue5sMvhKWMgIosgvcwi4njYmAOasS?=
 =?us-ascii?Q?qKaWjQ7JQsOjEQdXv7kjOVeayMrIsRcgm3f2mxqxoDqUOPu7VLIoirhVyH9+?=
 =?us-ascii?Q?LQDfWEJ2G+Y/yTludkvbFHtgX9ZcRyBPZO3Ysrhq4fbV/B6b0lh3FsqRxjsz?=
 =?us-ascii?Q?pJurF49dnTDZoZED5ZQ4dSC444ERWFk7kfGzrVdA3dF5DuAeW8zl4sfMXO0/?=
 =?us-ascii?Q?hKZ0Q1Bvkg1wq4zU2LapSqjx3xz/gRCxPdI6h2CSR+xzDxKD2UutH+ZYrxxE?=
 =?us-ascii?Q?QFmCG2t9hhHmMVOj/MIGwyVy4dnggxUn4/gOdIIn057kq6az46ZkLVE2qyTL?=
 =?us-ascii?Q?D8nEw0d7aUML5G0hAhBAE9+8ltEPlBZCiCOHQusreIQQaHErTEhzNmGUo2qy?=
 =?us-ascii?Q?OZ2xZx1/QJfDfWELL9wPHTQDh8lHYRU2hNKD+DLdHPy8tAWfTNp+Owfzb3MY?=
 =?us-ascii?Q?bqkcGUkvJmpUs5jvaKobA1SRh3IhJvBms2TOZtM/cHsT4OVT+i/YyXJYLd0U?=
 =?us-ascii?Q?TGTeV6zMjayU1aVLlMY6SXHuWTgy1lolZJhLsSFyln6nEYzKeQApyG2GlTdE?=
 =?us-ascii?Q?qpnU8LKYgk97ihsd+5N1dHpis2IilY8CUupeQUzwHWSN5QT1uPyubmnpLI3R?=
 =?us-ascii?Q?3jgpsh2puG2WPyeNKzBJw035fiYMjD9OJq2Hc6//dc/n9O2kykIknnx+NLkR?=
 =?us-ascii?Q?Qjkqycc1b8DOFv7Pnw=3D?=
X-Microsoft-Antispam-Message-Info: JD7fsE1l+KayrApNv5osUEZmlxkJ27QBeM3zQSERlczkHB9O0XxebTcusxauKLoLx7tvqZZ8Vj+kE2yIluZpuvgGa7HuokW7CsW7o1s0XMGhGS/+74ehssxVcU8XGw8tnTxNVlI6zjEDr4r3Wr+4RHNxy8PyLPq/utzGwEaxyHRIEFvkHKK/hj3FVsBTu3sk
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:O5Kpx8xymv5J8IqiUe3xfJiugkSM/TvtEkdp1C2Rb3bxOFXBtelgYbGtcGEXSZBgAwdwzYhCL9nxlKJ8F9Wa86NS1u7WmbpQKbiJ4AW9Zvk/c6T75YJAfiS6ylmwqdPLMRKSPGh8CvNQuWoY61XGb/+FWIdeTnQ9hQSdxmNVkcI7629B3I18Dq4jK3inIBxtfHFVCzZ9KDaqc4g1crt9UqSe0CF5hIipjWO61QO3yTPo86+9KUzSxVB4JHkD9ZLtQjHgt8YE7XbLoCUShLnCp8MD3h+MIyQqVBx/RbQixz+EhbjVoiPk9TqwN6GZ6ymHnuQRFHd9rY2Eee1VnQQmTwHEafZU1HVOYtnffZu8PwnbPloG2MAcoLnKYql7/Cm5UwOHSpHLotS36yhjstu1S075q2rd0PEhMCxaZVI9f9XUq/XBsOU+FDTf9Saj6caHdbnoC+AHI2auJXMs4pgI6g==;5:hkZwh+KYZAlM/OgwmPDEGIXIcscW/4RqZavwh4IPRz30pqoQoaOSRkmZTlhkKldIQjB0FPSZ64VGj0jWZqOhmxsO7ND8Ptk/l27BhHS+rU1E11ak0aa3pN8u4Y/8pwg+UYJR96hIbgCM/siENPKXxDvLjbqpXueYdDylNh5y0Yo=;24:5/M9+4AiAO0mpDFo/kTHmZzoIXgPRFiZMKR6xBAsz38Y4Wrvw/mBINBrIeH7SZ7/aGrH6nJxhjoz4T3rmsic73uPMm85hkeFs4q9PT7BIPM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:iRv6CYhnvZC45q4xYkIaGudyebyRVkigL1116SfUonekWnJADffazNhzjlFe/jMCZGqiqUxtftuW0SG5KnoUUokir273p0c/NnSbjIlixwnlXn55froV8PEwg4erFfibBbPSne2wFRXT4uAWbzBtPiujfHsW+pDaIIYnhmDd9c33x8Q3AG341vgbdy8dcq1grHFbOn0KmAEUopx8s9neINgzTnth7Voz6S5yKZfnw7tZYSAx0wy2Haog8tQIr/nT
X-MS-Office365-Filtering-Correlation-Id: a9aaf624-2aad-43a4-fd4b-08d5b31b10d6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:31:51.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aaf624-2aad-43a4-fd4b-08d5b31b10d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off and remove unused regulator for adjusting fec IO voltage.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 4d41b4d..fff0081 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -34,6 +34,39 @@
 	clock-frequency = <24576000>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
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
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -66,6 +99,42 @@
 };
 
 &iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
+			MX6SX_PAD_ENET1_MDC__ENET1_MDC          0xa0b1
+			MX6SX_PAD_RGMII1_TXC__ENET1_RGMII_TXC   0xa0b9
+			MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0   0xa0b1
+			MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1   0xa0b1
+			MX6SX_PAD_RGMII1_TD2__ENET1_TX_DATA_2   0xa0b1
+			MX6SX_PAD_RGMII1_TD3__ENET1_TX_DATA_3   0xa0b1
+			MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN    0xa0b1
+			MX6SX_PAD_RGMII1_RXC__ENET1_RX_CLK      0x3081
+			MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0   0x3081
+			MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
+			MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
+			MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
+			MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC   0xa0b9
+			MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0   0xa0b1
+			MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1   0xa0b1
+			MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2   0xa0b1
+			MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3   0xa0b1
+			MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN    0xa0b1
+			MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK      0x3081
+			MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0   0x3081
+			MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1   0x3081
+			MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2   0x3081
+			MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3   0x3081
+			MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN    0x3081
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.7.4
