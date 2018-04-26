Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeDZHCx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:02:53 -0400
Received: from mail-ve1eur01on0043.outbound.protection.outlook.com ([104.47.1.43]:28715
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752419AbeDZHCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:02:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/6] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Thu, 26 Apr 2018 14:58:13 +0800
Message-Id: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:604:d::30) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:kw+HVR4aCUb9s6yHMl+/10a+vZD65OqtRVOKU6JBIZgiEAzIa24J/BK/T412ZKbzWMZYHJymdG63acE1NLW8SuBym5USAbJIbb7gUEmebi0SVPh+eXVtJ/b6K+tklLTeM7RNvTJlTsQifc1rAuQl33ZhenyD6RDqSey7zxApoCrSCpFeysteuJYbVX0WskAZOQmwnl71a+K2sg6ttf8/voFyQoJUCOcBSBE3r/lUbYPgCSecBd33JImhJXPCRxHA;25:VVgf3tNPJeQX7qdeobuk6AeQ6pXlRsb9f1k7ZBtYaVFzk2LpFNMV6IbhrebpB3TCagAssJ3vBXqCnbV7PXMlV9q5yZgKq5ytLgqrn4cwugtyjEee91pQdaa/n3IlprGBQDIHBFk2Jo0G2TV+5xpJpFWuPAlvT99QUdkX5W1RDhlNMvpI9bkW+b31DE7LNx3Xb+R55RqtrapaZdO77tUOzXJ7FRhh320Jtg4LWjbr+oV0W5kCbe2VqEmjiDh0YooXs2vCKTp4CYfUGvKYmPLtRXQQOaLlSUtQnW014Cs+tkvhP5uYsgZ5bGhQNvd651drtOZWX0TddhkUcNn8y2kJyQ==;31:MVGcTJz+3DeGmRG338jRgafDRUmpTSEDU9m/zcNPTFxbzjX7CHCeHdxEtNsnFEkVAu1II1D84wGQZJdmjRI1BMxpEqQQnkZ61j/wOyQfehTC24qcjP8lmNxQk60v2IP066ytzlKEcgnjQx2WM92tgdlySQB1tvRmKNOgEpDg/BooSgzU3qCxDkW3Yf+Zp8tSDAoVPF5Ilg3C2gcGpSvTlK5Xn1vP3nvIB53kfVGryTk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:35SIjWHQ95hsezvJqAbOIpX/XV8G6OUfWpvIv/qTJp9AKNQdIMekKalWOCyiep/Q9tNk/T07QgikDjnwwjyjs7rt3eZ4Dv2tr0D0ykRkBHsARDE1H51nW6LA6C1GJ52q69wF7GvbFfBA1QQZx/RYiETFJiC5dR4XgnyNhDveIpKD6eYnA35xQc3puXOIcSxPFGxI1s3Tk1UvU/4bJhfXpdB/FoJfdThrEf51gH4bqdrJoBvC0r/vxc6NErn6QQ/skLb2Uo+RspvagZVnmWIng25upIfjNyO5rjQPQcNNJsUQPTdklDP/c26Zf5OVv8BmEXPW6EhBOASflNRU3iIpDeFKt1oCTlR3Nf/Qyk+OEoAeQLJvgu1E2ccbBJflyLJ9g7RM2UB3/yKcwNGjmNxlZGgDDY54wO8IvNhgvnRnp53oMe0rOI34XVPYXX7t9bpUJg+wkAO8XXLkhrC8IjJXQ1e6Ddir2NiSaGu/rQ1JtuZtKNwMCxOQKmC3kkO/711J;4:YAY7xj342unbvg2tMwZS1JVQuP/U15FCDyEaqjVQrRh+sQFMqFwBslH0p7QyJiLeLzWRh+U7jXTfH7YLbVeHgfjyXgbmg32Ehfaq1Xex51kz8tUT4tu+MWs0kZCzCD2gqX9DPSlNCjR48ARLrE5DDkUNv6QveD6t5aHvJoaNQYMj9/tgbw+LuRz3XX3/iMZshZtkKj+fz1GVTjmsnvFV1I4JTiGmR0hA2deeyFKmU5tQkZwud90bOjxLvlwrV1D3/7l9KSAkl7OG3Sj+aZE1SPJBU8FYZn6mWuMY9tmJjnNwDUBAZCK0f6S5feKgrqGk
X-Microsoft-Antispam-PRVS: <VI1PR04MB13271911CC7648B3D71686CCF58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(575784001)(4326008)(86362001)(48376002)(66066001)(476003)(68736007)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:RmK+36u4xu/FRWx1kqqAuULuwEB+9NvEQS9SpkdSA?=
 =?us-ascii?Q?lmH1JcfVF/EW1fhO4xi/rvB00GBg/23yMnl/uLnmgS8viBTCtpO5I/AnUb3o?=
 =?us-ascii?Q?pHGPRC3/eOVigoyAsJPgFsdY4KFmS2Dy/eH3euFW8mxpHgPfLyCBoOIOvENT?=
 =?us-ascii?Q?+5+YdH4AX4wFFJNz9rpWv37v3zia8hTH3hSH7STNUKg1p0mdHbmPGzJQ76j1?=
 =?us-ascii?Q?LElSYwWN3VGbEk+uWpCRZhu5mWelxfgUnhGE7MV47qaQgxqTg7HBPlv6+nhS?=
 =?us-ascii?Q?YDQp40skg+7olY3tXaROktZj0sQdx8gx6HQXjcDIXuIPZno6mmXVd78FSKZI?=
 =?us-ascii?Q?BAm7rlsJqEiy/x5X9Yuu1G7C8apf1QpUMd/qUSA65mUouK4+nZHySTamkrt/?=
 =?us-ascii?Q?WaUsGBjx63Rck2gkm4J3SVNa7ySTnFL61QYvHPFfKhcpyeipqoMl7a0Ekv1h?=
 =?us-ascii?Q?DFsbVjh/kJeQdg60SNbvwfVf7JzIsQykYBUhhSUSspnGQyQsOVSKkLJnTjAP?=
 =?us-ascii?Q?BHTyH1KaUkMZukNXyDsFRK+zKR7TNQtuD1dJCems+c3g11OKpKYsF0mH1s6R?=
 =?us-ascii?Q?21CGdHRvuV05qi7dZDPxCTlAM3rfKDmscB0m5xm9uYE2RHF4Fm6uH7OIv7jw?=
 =?us-ascii?Q?NjNuOnoXlQUsHhzaY++2Od/5NtIwecdrWM+jAsTokFdaCp8ZYNtkaXYH/ncj?=
 =?us-ascii?Q?Uj1Dpp0NiunvCQA9yFkeSKHsbptDj3isEqYIpYPooM58Fv3WymTN3oP22Sos?=
 =?us-ascii?Q?hbuY6lkbtCH8hGyIQ2Bn3EFqV/ClrqF7oYgwUohE0CK5VWifY70oEmOG+dLJ?=
 =?us-ascii?Q?Yhg8U1Vj+OwSf6WsU+oMzr9kr1TZguzEUyptR5xnmWwMGy1hMRK1OUmX4irR?=
 =?us-ascii?Q?CmBx098s74T6m4h85Jzl+lyzmpeiReP9ED8PgrzDgOq1KWC5xGbF/n+eM0qq?=
 =?us-ascii?Q?xjFbFRABq2o/nK1K20Y0cZxh2SgNcNUTl2iqEG3YUA3s0U7k3LL3D9mLYnmz?=
 =?us-ascii?Q?1NbTJyaww3B0pNhDAoLBBbWYY0Ob5LU+EEcQCOZrMWA88HChu/IdBqXvuTUc?=
 =?us-ascii?Q?LN/FPzj/zYcz+FwPvxzvZT1UtbYyiFwvhjx6/3mOCKF3rnZMnMz98ViuCxa2?=
 =?us-ascii?Q?glqXIgSj5dN+CZKsRbqqKCtd4p2QFo9sSdVZCCvc9QkMRjO52xvyD4G47UP9?=
 =?us-ascii?Q?GsFcOkRzbjN9kaQSqloHxfF7ahtGjXBF446?=
X-Microsoft-Antispam-Message-Info: NDZw+k+LtYJ1j0UNpHlA1O/5DJmxvGIlKgFvpG9PmPbFAyFhAmnXH9mr/4pFaNfDFNlzdWQfO6LNGED6/Cc3kSNjjlXqMaA5ELVhGqbsyhMeu6i0Mlvqx1iGpi8VGZeVv+ocpuM8QRhiw2ovjB/3n+0cxKqooZxjgSF65PYQShBaSXckoQdU05FGhuNgpY82
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:UphsEtLaT4mFRRKmHBaef6HMcDuDilba8+W5XHZb0xCYx3wCzZFNABNUf3BtVUeMloExghZt+fft5JKke11pRYKRdLdTk+qof0qeqncXXOAkyX4ym++h7g+p//S7nRAB/mn3k3kV9mJB9KL7/VX8aVVxVB7u/0awHn3WWillWq4FTqvvXIwUp0mv3aTb8VrYb6+txFxgxNmWw2WhQ7Du8QYMpflXQXV7fIOmVJ0mkUCtFbJODTeRbIL2Zi2HFYf8XD9H6Io+2V3+PlkIyKqYcnTTHEBQzgSoAkEFVJE2hnXdUiSZbi4dSxnBvxqL9LxnIUAuPL6At8jBaoEXFo2kWAcQYu/5Fjj2xjWbCXnnbsnUsD8+x03GYuRuZmAis9uh0y3pEh539W4AS+OPz01WgtN+plS9ItCj6GSNO93jvLYFGrI11IwNGPQ5prhMThrSIARzAG1f2ISglz/ldfr2cQ==;5:u69zvfbEdALW+ZYpwZ0j/J4gj4W69LZzlsEP1j4KZCHtEKOR24F08c2d/bSxBQxIGEILJjFAel7H+PPzI8I9d1yIv/rVR6Dp7kfy31wBL61E9pfGvxS2ZpUw1oghtAz4cyseo42cnMY6UjDMWeuLOFNXurOp6b2OzWGgB5iLdqY=;24:/TqN/uJ1VSOr5UqZldRQRGW79pI8Z2JXMI7JX8Yudm3GHPm4VKdr8NjIg6c/x2hvS+l1onzFMdq5deuq0RMl75ygLZL6tInDra25oWtmRNw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:AOGI4sbgHpuaBVqgougg7I8MABPl+u3DuFV9/zhbbNyGDRJjYJZoLG7wgigZ67SVLaq5kpJnjF83Jx/+PmsIQFty9WLAFVegc/XQw97OPi+tJmamkkXDBZt6vORT0jzi4a410+14t0+ozpc5odo5j+8/ejmw4SYkh3pB0n6XdPZ9LBZ+T3RoUQmO++QZQTj9zv3OvAhkgNvFKWu8xwxtU7XyDphIwBHaOfSfSGlI8Fzyhjva2YSryHp1fcUEw7Zu
X-MS-Office365-Filtering-Correlation-Id: 81c99714-94c7-46d3-4b7e-08d5ab43b68e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:02:41.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c99714-94c7-46d3-4b7e-08d5ab43b68e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 117 +++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 57d1ea0..2caca934 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -74,6 +74,14 @@
 
 &iomuxc {
 	imx6x-sabreauto {
+
+		pinctrl_i2c2_1: i2c2grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
+				MX6SX_PAD_GPIO1_IO02__I2C2_SCL          0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -148,3 +156,112 @@
 		};
 	};
 };
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	pmic: pfuze100@08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.7.4
