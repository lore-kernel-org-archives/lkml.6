Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeDYFkk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:40:40 -0400
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:15520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751334AbeDYFkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:35 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/6] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Wed, 25 Apr 2018 13:36:06 +0800
Message-Id: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:604:b::25) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:+sWx9RW2Nluk5rESvCiBbRk7JznlNfzAn/0vdTdTTELxFiFt+5fB75LqLLdpgpLDKUjXd1ZIQv5/WglnOl72x+ovGEayCoxiXFlkTPnA9Hs4aGV8KMIK+4sLtUZNShHL6ZlJUVuriFc3z//x6sSOP+VGi+Xl6wl6GRjA8vdneRuTzEh2A8Wb0uQ2BE6Rv+YA1/2fk+FR83hQdvwUX25UQAubHltK6rXbbZS6tWlbICZrhH8nuD1vlTdS5D9oehTu;25:h7bEZp70thUFQmvnW6/U8LoOg6bi00NwzLuZPYfNr9pIXms6x/9M2WdmbTamERqE/0iZGuh941kuqaBz0jGDGbnXiwaM6IFhWV3HvcqMLryUcGlrdYR5PgsHbRzOpAUIPVDmluYPt85BUMVBpyXkm4khiMDKSw7GZUYZ1DXtGCN/UJspFTsZKuWDbxJyF7APTQio8jCych4gc2JbfxNPfOgRE++F8mteiJqm+M0+IkqPpqdLl4B75x8REMTOOWVzrLVuOObjiss3R5/qASbsrHGNvqggWG4TV5QNusXz6PuCp0RQc39+jaeAFemRP/NKxhULjRxlRIyWa6SXTcbamw==;31:iJNBNe0vcHt9Pn4J7BQjQbDleA5w1XCN3tRYMJjedkQPRHOyDe4PgH8v0W72YiNfDkfJbAK5nRCHEvjkE4FylPzT51UNJRjxt176puiRV5IF7iTdBzkT/jK0+zeNuMFNhQpznN5l3IecSLaMi+FV4GQ1MlHi+Yrl+yKIhHm8GmprEfIoZ9pRm3++H/adcWXgvo1wSAWi61U+W1vZ4xy3gUs0VzAyFkuP5GuARMP5IJY=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:sUcfZwsL1vF5GlVAwihqBy/Dv5Xy8H3cwx7J1Dy1WAp20/FySr6fevRl7XWndm/QEso4oYiAfGo1GWSfTpfrnvRZD7uzM9hDc/u8kMpdp06juD4+vvIBjp2KfAdZouDo0LOligBgp2eTLA1igTx95bkfRM8OkgVBL7K1K1ujYzbljv9EjWya4gDKBAOLQ5m7k7/8/qNkCGBfusYKV18EMvwe8CDaxZPI5I4qAk8N0SI9V0JoDDTzQiZ7stE3nfeGX5nM21kI4YI5u8xj/h3U1hnVj0r+LCwNoPU09/Q/Xb9Z42wdCQaRhoXovf0u5twxCRacwsWYA6C5RuMKcf3Xu4pbACXtikrjcHso/qERjVkTeIslDC1ILxk88C57VWJI4pD2j8EjEGro9mT8qxrEfhssNaAxzn0KWfRvT4tcmTjh7YnSYPPnEuQTD8GD3S2dbieVLEHVQRddlBnXUEM2ZTpzXQ0uxHYJ5iT+VNsOXXpA09lPIAEkNNsjgxtaB8zX;4:1oXJu9ZObBRTDMIOcewce63s0JtEvgz39p2LagoKSmnDppwgyrd4NqLM+DYPXT+GiJbR4oEpFd9Y8LRoaDWQUVuHBlivAYmcva1EyA6utnfp9K35AF3IYr8wXIg+7DERRMj4AvyboVq784qK4mw3I9npsC2uYzhXGyBv7rv9ShQPM15uFvXoLoHP/CtRUlok+GGzAZbN0YKMLZyv+FXDN3wm0hCqvJFRGnkAsH8OhHuHIRFDnBj6zGqcPyrxazQhBvs7frDgFd6Iy44iFTsgPKlyNmI83sxeHBFyPVrzj6s4YOjUJ93ka2AIGR7ljR7+
X-Microsoft-Antispam-PRVS: <DB5PR04MB1319F4A1C334231D78C2AEE7F58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(575784001)(7736002)(86362001)(8676002)(305945005)(486006)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:qUEtJjbO+hfI0YsP5dgy9q76r3v5syup2e9EOZt86?=
 =?us-ascii?Q?ueKJMQ9E6rlvFqOKlS96ve74UndwwYO86KBV98IaQ/U9CNClrOf0FLCk5AdQ?=
 =?us-ascii?Q?sSg9ZzGJVMs6NN+5VqrQXkiFyn5B26pnkYdMYbzbZoiR8yGDZni45irJLGfM?=
 =?us-ascii?Q?wPQZrmuRr2uh3IYqKRNrc0lUhlSoCb2kANs5bKUuEyd8I3gpVdnn+DNyrbJD?=
 =?us-ascii?Q?4L0GSsUrfurVcM/2/VFmY0lvZ2bpxD6RiY9/j2+oxOim6WeEX6Ks5X6CY8du?=
 =?us-ascii?Q?iWlPgn7XscOXYxCObi3sO4gy6J2edr1A2cfPIOSQQxBtIHzLvjU7thAoPqXC?=
 =?us-ascii?Q?XnvOCZiMiaqw9ATBjCMkQ8ceXPUQNYBxjMAe2e96TZYjMLPgg1aSsgOxgG34?=
 =?us-ascii?Q?xp0FaWI4q3oyiDtDrFn9bxpM7t3gXO/JG5XGgQ06020rEh22e7ar5dCr9+J+?=
 =?us-ascii?Q?Pv8aL0xA2WYzIIXtFgy+kFdQFe/dPl8SuafBV2C8WKiZlKrkUkQBc39rciOn?=
 =?us-ascii?Q?ogExxWkoktWlppwDpHOMAYIUjD2zzIWNiqLBLYfVKuEz8lfaKE74QYSMIb4p?=
 =?us-ascii?Q?PVUQEn9X5kH2l+HH2RdNbu9Czw4ZDrxdWD9V6J/lsya1ZThfxhcAynSHSNhW?=
 =?us-ascii?Q?rQ8C8KAE36ucoq6xKBexpbbXqtUj3KL0VgUW2mwwQtRz7MLm2eVoPfinOAC4?=
 =?us-ascii?Q?d1OTNpRKxy+Rt+Wc8G/o48cAzprr1cVZeKfqTi52VBWgo5YQPpokVaOwBYly?=
 =?us-ascii?Q?KZvZFcN5wokT3go/TrGJ4xGSQLfO5pdKA+p6xe+0AiXM8g/zjRmDYNx++BCJ?=
 =?us-ascii?Q?ef0Bgac5hCzbRMnvG1WB29KdZD+8u8rYx0ZcWkOcP+4mBK3s76YsIG73FrZ4?=
 =?us-ascii?Q?3NfYqW3+KBZ2Nkm1LBPblWp9jnBB1jjMN/0dF9ONu+z7zuQXeW/Q2ZFIZ+lp?=
 =?us-ascii?Q?GIb+LlVkmMOsvhPPupS1xvhc5fcjIdjLsX8HoKw6gQIp9gV47sHLQ4AGtZih?=
 =?us-ascii?Q?V0cTS7d5l7nkY5J9uzOCjX+ZoqbiDY855xU5k8vEicqqhwawlv7XkHMzTau6?=
 =?us-ascii?Q?0ZypLrsELESiPIzlFMS9ixqz122DQAMyfKt4tnZA73Y3F8fdRDYQq6nE8+TA?=
 =?us-ascii?Q?XQzLkgz1iPu+TZCTjozbniOn6Si5c6Znm/x2IVruY8wyNyMTDqMkoxxr5kIr?=
 =?us-ascii?Q?IKkSN4855nZVTHzDg+UIpdZEbIzii0U28zC?=
X-Microsoft-Antispam-Message-Info: WaPI9ZugIu40FnLHgkv14W1Y2on5503uF0T+8J5vKWY6CpnbdPVi6p6Nu6YoQKSrZ1mT6Fi+CeQ0hO/E0qtx2ToAA92Sg3g0Mt8FhSfFU2rFmHGM8CEdOvkQsCSNJdE6ad1Q4BBrUzMo2XzOIt0EPk7qImK8FTkjc+fvGjTp67FjycJYH9GFkH8z1Jen/4qE
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:io/T43jEJpKRfEcRfzZ7/LiGv0370Wa9MCzyPk+9ijUtXKbqZ3Zx6gibvmmZbjfCddJWiXgs9jobnpeYcQz+d4LQ9fP72G2E4uRHpN0d362RiyRPOcxKjNg9OQYnmcONNucXGSzd0umGXFQsaag0E3XwRrEYAiT4TEvxETA/q3tfxVbcMTYRV5TcM+w48YPuVod+kvek19AfXILNKD/wocc3UR7LhokmDBjLp9lBdDZDfOtdUas0JiAvYEF6j8jQSc1bcW8b+hdU9yt/6qkFI2zlbMc0C/QzG7kNmA2eMyFTbR0HPsQBwoteuSM2SfmLSCPNVSzOCJ+g55pEebyurER3SDE/TUnsRH2Z3V+tUEuDV5NGFEqiYBojMzLWvXSlGvwApVo5ABYhmRx8S4eE7PtgF2OIzW5mhs29Wxayo2z1Ic0c3z6P3tseKdpRLWepqbVICSHxhDXoguSZ+1KRMw==;5:/vabrrYlASs+RlsB2vmc3jCslta3jvbQpwj64IlLXz0/mSCKi26XH+b6xET5dAa16HV3PZbraedw1l3YxJXn6SIha4SABsTSxgbxpl2H2Uq5ES6CxOB6RJamz1JmZTZLOU7Za16ILcPpbbZYRPFs8Gn/NdmQnRCQ8SBuPDZ4JbM=;24:l1pCepcCgskzY2fiSCJIdJjyRkfsl3k7whbWeZuZoqOMuJVv/kluv1WMqkc/g8AuGLGc42TmNaYxhGccEZcYsKUKQ6FSb2uhbg+qQk4H8Ig=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:mtkvxmiGv3h8DrHXSoXNZtvW04Wb2FhRgXAFIAhFmSd571SpMN2PxsgYPl1msVZS81N9Jm1R3V7yfiJLQV3YAOFNNnS/ZFNs2W6QoLuUYRVpDnX1cETUPltGup96DLQ7y78vFymqcD91SsUJn7PTc0+A/xbloK/AwOB7b5cnuHJletL3ku/G65c0/xJbtg6kYqQdkWuMFkvZShphgCesXlHQjsXx7JjxS4LYJYhQWSlYny8cGhLEhn4K+gBrdWZl
X-MS-Office365-Filtering-Correlation-Id: c25f0b2f-4d8c-455e-2220-08d5aa6f0fca
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:28.6413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25f0b2f-4d8c-455e-2220-08d5aa6f0fca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
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
