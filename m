Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeDYFlj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:41:39 -0400
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:46327
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751461AbeDYFkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:49 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/6] ARM: dts: imx6sx-sabreauto: add fec support
Date: Wed, 25 Apr 2018 13:36:09 +0800
Message-Id: <1524634571-5914-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:604:b::25) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:8O0leyXt9QJrIPYg7yCPHgMeRIto5wQiZ+82CPXihePJQlP4GPk4RgvlvKd7isOhNn3lZSKN+s5yL89Ovm36TLj5jo9XdW2aw4y1hZFu6xKHJFtVexO87yCz31bhvC3HvVmUdq5Vl4oIjaRT42/qdlBqOaFDLdHK1hbLZa0HjWtUgmrc2gmgNsgT6oQ4e3+fJ4HnzeF0Ki0cYSp/u+KybQadthcyxvWY+UoqL/muRjESkuM/YPuTYgbagvaovO3k;25:a8ZXmlR/Hq0taHmktQMz4jsi/No9I/ahYmDJASNqEhgyXrCRoNzxc8/kRb3pjNxNNOXvYRNCx0vlzk76vSLDhUMxn14oKc1e2uX3lZnh8+ILx1ts02a/CH/4ezkHqVmj45VStZSb8Ju4L9Y+CfYautvDuZ1W5YfPr79E6zOYR8KGViMbRlLE9yvw7o6yOaRjnVFCCv5dRZ31Mu8lOvaW4gA4Wa6T2+hpeMSEWsEMZlASJU+E+kLR5ErMR5/TEDloIssKGStsa3Tk3BqgCKymy24ogcmfEN6RF1piYDkaej+KUYo9eLy7m8LmJgt+ufA8e92mEUv0384R1Fu+cJcwng==;31:5pt6AB57zX9wdZK5WFAkLll4rLJcBlUyDsoMRfvcFFXc1xbTVITaJWss/09gamtocGgHP4gvmAnTg+L5akIdrWNagLaxvQ6wQm8tF7OYVGJgcah1WsXJPZH9hsy/z0t6qav7yWUJSCEoD9ryFNuyHP26mpvXpcovLkepwJ/8/wplaNSLQX7cE55wCuufj05TN6igCKYanA2gu8FkI5wKW5zWTsQCJiTSlFZ+anzmz+s=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:zC9af1IE+otKx5C9cshZ26X3tgXuhg7hTILmN2Doso/Sr6R9hMOyppryLioR1Ps918UUYj7K9egEb8iM/X7Ty7jyXcqrQ3l+ZgTScLkomT/wezGRI/vB5wbMTYIDu8RehS2VQm0dDcnSSXRtX2anucXj/l0IxwJGBtFNX0kr6ZSuSZZntL3P3SAoCHA2IhRh0uqOm1c+9hI6OqYNyzumpmHCSsf30VDhJHsJM8v1kiCkssLPlr40XyKecmdUucCNOu9e/YS/+CCcs3e0flo4WMJ6S8Kyd4tL1cx4MwbInd047Ec4P5visJkl4gzf2fm4W5VjTwGWW660SS+bUKCuEWjPAI5gyDv3XAz46PBkjskhEhyj+gHJiIiH+UROVDX3CNEOiUULHO1IAZleBC48dDc5uKYvvUMIYHNrCiwQ6ZbWbrDSHlrRtjyiXsGVk8ZNTl6HEHSkZgw9tCvWBnYzLLSCabCe/KeYTMlMH2RsT/iLC5oFDXMQMDFsmsQfHplI;4:1UpmZK666gYcyu4DdIePPd6xW5ADR1skjgqugFK87D1zuVqjCLO2NwZHRXO9INXvrTLDs0g9mSfIZMQGHrdiW+zpCxdEimMp+Key3UFgj2Ul4qW2u03FVW8x0OIoZm2ZTBV5apy8H+VS3VIll6QJ5S3zrWTpnHZUo5jfp78J9eiV5reWZk4DvAgENHInAQ5Wt1WxPGjcR1GV8PYIAKKEw4u13pCLiaaYioJklOoLtJCLdb3cKmCmDrTG1WpnDJv6iHhbbl11OoGxS7MPfztRCQQjQIixOopv1uRRaNyz7zkdq8fwPxUSHDBqo5ByODrd
X-Microsoft-Antispam-PRVS: <DB5PR04MB131995E71E32845FA9C4295FF58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(76176011)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(446003)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(575784001)(7736002)(86362001)(8676002)(305945005)(486006)(11346002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:Fxr4rfMr8AFfDcssU+0VrQDTBQqXe8oGard2s020T?=
 =?us-ascii?Q?LfLTnDtVez5r1lWYHu/D9Bip0t9QGrVzajYZkPUJCHLQhG1EC8sOiqDuAX8s?=
 =?us-ascii?Q?kBTMQiUo7f3YXSq99KsRmTWDyKAuqHEEDTGXJRODpfWez+bpfkuRs3WzZa1A?=
 =?us-ascii?Q?I72xJoK17eUcoOy6im0DhMxjjvkjC5sOlKVzdg721B9ZAM3pB4Gc7OiQzl8R?=
 =?us-ascii?Q?1H+EDSUt+YIrKydw6iYZgf5DQWEYhXM/H8rOtgDI5fvJcWfE4HHSriP+c/78?=
 =?us-ascii?Q?+0/n/7ERC2sxiQPNZ8+JQU9KP8FO7fTsfNNGe5NrqgFPgy3297dTssDzzuxs?=
 =?us-ascii?Q?Q39Mv/yuzOHpqfmIz3dh/6YrqrBKAkmxKVlJk6WyvZn/zovc5hUqGsbmQQeY?=
 =?us-ascii?Q?kVBEgTYQm/waiYgjzqguH85PV6B/ibrzhOBKa8ujXXup/7kpWpMoZCyYD8fV?=
 =?us-ascii?Q?oZWbvQI7ajC4paZCcpVvU8aakO/Te01H1kKrt84yxARg88R9Ctzh9O71UKfS?=
 =?us-ascii?Q?C602anUItVduamxTdQ5r17pw0sW29CsrXTJqZvGpUltdbjttvvdZ8+W+H0GV?=
 =?us-ascii?Q?9sVrzHqnaIfBIRaBivp4CMbSubnC2VZrXS/AiKmXKI5nCx9YBAw4tnvNCiwL?=
 =?us-ascii?Q?U6jLXvUyzP8UwzTx/ais4eMlCDO3KcEjawej3Jx0zBGjgb2ky7J3S1+3vrCV?=
 =?us-ascii?Q?qUHUUUhI4DuaF0VJph0Gz3RCuq9sBd1pKDXgKG83NsQECJivdmUzl30sSt+E?=
 =?us-ascii?Q?61sDWc8rQCkszdjWLmafJD+iyR9To6dqK6JC4iJ5w/aL6VtZbSFxfIf6jvCi?=
 =?us-ascii?Q?CEVjy6Oa4LfMR9cOvKOIrOBx3kjENWeqT1jUCRzEUEEHkbbQb1rjg+iW10Uz?=
 =?us-ascii?Q?uJFYpIzZ5nQXaJ2YKxjUxnQHs4BHxnvWN7Hmmh6j+SXLSdjnSn3lNM+Y7ZbW?=
 =?us-ascii?Q?WV9AVqPor0zjLi7KHRGtmPi96D0IfqMlVhjkTNNnIubOC5yju626zqkMy1HE?=
 =?us-ascii?Q?UzIk0U6egXr8QD8waw5EW8BnMJ81to9imoSifJ7EgFpBDatYNOZN12ts1JlT?=
 =?us-ascii?Q?4QoeeJpBdvHypz31yIg8JcIHJi3r/2xF5/3NMg0Ezq9UnPsMs/BegxDtGDnZ?=
 =?us-ascii?Q?hIeQuButm1THPNpoOuGK+mLCDlpJT8R1J/Ac4tqXGW7R2quwA8hotN3f6XST?=
 =?us-ascii?Q?OSpBYDjC+gIBtnu+fqp07mbgUjTNF1oC+Ih?=
X-Microsoft-Antispam-Message-Info: KW7sUCc3CaovocNiMuJnSI3rUP4huwu0/TPdJVLv96MfeUXZ2Ai9EpdFb2J34xwLOU0r9eRYKtaBEyC8gm81xqIw09VTCcTdZpVGw1igk46wT5t0JFZVVqYTYGqIay/X/BGcIQXtepr1FmyYdK6r0tFIMKBkO9vmmhTsW3oBBPonzVUDoh56S6KwwPkW8Pot
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:QqF4N8YmlBFB8MdVon0QhcEMTG2IsMyXGFVnXY0lMJEyDbwyX0DkxwPPU27RuGna4VuZh+qhGpmuBuBc6AOQn/Y87OZoo55oUMDUtIZw+ku+FmeYXrX/eOLsH7637SnCdWgR9UgDxq0qJzRWdVPQ87oTXR5Tf7q5qVr5l/dplAXvYHJKvPELFYU12IvGatucggplqyuct0lr1KlIMXJ3aB51fDc4KttRsMNlahvxykl7xMuGgOdiF5uZFNOU5eV2b56kjElGBc41dRrQRIYDzIoTJpkd/E8v9JKjV/QLNUsY7o0gf7lfTs5+XWhDyUwGVRDcRDNgMCyGHGuEl4wV4uHCzb32GFQqp04Ka8+PijzmKcKmE/AFMt39KhcRDG9Ivv4L7pGAkJKLnkRyLxBE3C/C6I/rXStE5CFAjbJivZ46oVzc2lNQc5oB5EATV4H+I/yHs/ReCfL6oF2Q1wGo6A==;5:y6CZplr82P6aBL42bOuVdxB7YwYqMlMiLj2z3X35sPGcKiHNDfZ/gS2jY/hBNtT0SOMQ5D6AD7Vl1jQn7n1T5r9HLeMewQGjXJxClFID8LW9G334HV0Yev30sv5zRfLG26s7HXRKMPRcB5vjbPk2Ny60jGoEfv4ZqAjktDT8+YM=;24:6miJeHI0dGj53ek6FO/cRHW+nj8aXIw1w2ssQHve0x+EK7HWF+ykww7cEW1ceeFIH8nU3N63jDmoMtzk0+5SXGTuJyKIcaB6A4tZ1qwtnVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:Imb4k2IU/AA8FMuxOodATLHHAboUZfHQ+km0VK/s9B2KCa3Yi5pbp1XSmt9khQZjRwYKMF+E0v5mwjvII5C9Vm5AfclepVGHbjApO9/vSlQWKTL2h0WIz0ZImFoFixpO62cLgIW+8hTSOoQaboT6B/6MfmOqr7TGa5ybR21fRJ8m9vGE+ra2lxUjjEayBiDJOfex6BkYHZsr2iAH5iQnp7SSPdGQHueg6KOfOcnPzsloHUpN/hQcc5jt9QBQbtts
X-MS-Office365-Filtering-Correlation-Id: 6cd27b59-fd02-4824-cf87-08d5aa6f1843
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:42.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd27b59-fd02-4824-cf87-08d5aa6f1843
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FEC support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 812f40b..fdc642f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -41,6 +41,39 @@
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
@@ -75,6 +108,42 @@
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
