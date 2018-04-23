Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeDWDvW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:51:22 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:29776
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753988AbeDWDvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:51:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Mon, 23 Apr 2018 11:46:55 +0800
Message-Id: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:cpF2L0VIeenmx0hOkWvUSNlSuWh6xGSrcWOwmfNz5SJP9Cx4UR395TU/B1ZQX4lqKi/QUQK4BZ/Vnu/Iumk4mT1Myu6l5XZlw7lP1yHVI9SoMDaZZzIrZvMkynCh7UKPHpS1VFMw2LpI/JV59EGjl7JGuNEwgHMibR4KBu5nj2iI7vS0bqelZLrV26sDijS5VW7awyqgYjejAKahTZgZkA7iXnGO4mLPZaUZniabCyl4hh+OjsUWofAkYvS0QeHq;25:gDztSgHdC6J4/YouilSWe1UQK7WujqyVbQ5oMb1fLh1d7icQxxHzGPrdTWks6ZoD9HcOyQ1A/KL0xFCwV5vUCLkiY2sqYEHm/ugd38m2/2lD0k0x0Pzl3QOeUeFfvOeAL+pwUzg2v2Nh3WNxND+uVcu/DRbUNaQmwyxpLf4JWQ+5DAcCKaEKG2tufXfYw6RF4FxEbAepb7gS22Ans2crUAIl72k5yxt9uMV+xIz8ILzvyirrNzrRp/ztnyhy0pRSEeA0atDXJYYzfYUQgvs3bQKK0VMGWAglPZPSG+PUNSdNU8a6smLo9Y/htJoxrsrlq0lBXtsARAvwkqTWSuaECA==;31:SMCXho2ZN+DyovPwuUIcXci+9LDtq2I0vPjzThcJYDqOLK5dlbaLdB3K/lX5I/AHLbQQaLtYo1agjXdsMfMQ0jWnosaTwWLWlbhbDA8Hyh9L+zKXA1snDUPzqmFcDmfyctQxbpcuhm2cs6CFjeF8gBDIHcaf1PQliCBHTY9pa28av+bEhhiBLv+CoJkzQEXCcaL1KAS/e08n64nx1V3wWB0gTCpe77+H8jJiym34TcU=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:E8sPA0WavEvFirP/A1r2hukxO0RCK5JVDt5VaEgf9pESYj4h1vLnyHBPPfj+DzMVzXTOYZybf3J4D6yYDbnXo7FBkQzuEsRgIgfZuiIJDNmv87h4xi+h0czcKlk+zKNUJbdIut2UlxNJWOTQOEJK7fIJ/x5a184n4GQrns+dujVuTVVUa+0cu1N+aWqW7BaIRTxUZqM6Jfde79wmc+QtykJfFcYheaNxtjoigibpgu031ENsb3Ilgo5FixTFyJCQvp6SCP5701g4YU2JHSnFCDLSZ52sivoqI16dUz7CeWzNJTtrtC1Uvo0vmsgbXnRJ7wnAtMY3h/dF7IBxQ2rf0aY3tJx/4iVJ72DeGBu6S87G2FJ59X0g/xwnU/xAoLNTTP+s3ZORD7wioKDPo+26ItGQAU1ZRDNy1Wcmsj1M7h8V9o42hjYCFVaPfjOYxJ0zJ3xAYo+Ix4sr99ff2pbxCsm7+ju8N9aNduoCZDObZIRVmvLE1o9pd7/y3VZ9uI5h;4:hvxQWZgo99FtPWkCfzbhXQ8Prxu4Ejilt2Yhq7taNkexU2v8sjaL85r1VLjAHkopFj1FRglu0czrQ/3j6qhi0ANdjlDuM86SVC37HUBpToHpr6q8XSTzmYq0Qy1AzbNeKHFjOMqaIcfIxzqxWGcW/YBlhJ8tIYbMIOaOgq9YjZJds4KA8uJmYzpCnuPSIf1UYGHWNW5OSIN18aqp1wcw5f0urB4S7Zxo4jLmDgDHuYiQ3oxDgodIynK4WWrTZWXhivNIsNLrWoz5t7/OcL+jsAO65BdecWEoKiwIp7AhlP6xMsULSQj9EJAlejdoYUjP
X-Microsoft-Antispam-PRVS: <HE1PR04MB13242EF7A68469B9B34FA730F5890@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(8936002)(6666003)(26005)(186003)(16526019)(386003)(7736002)(6506007)(6486002)(2906002)(316002)(16586007)(478600001)(52116002)(51416003)(25786009)(4326008)(575784001)(86362001)(36756003)(50466002)(6512007)(53936002)(956004)(2616005)(3846002)(6116002)(47776003)(476003)(50226002)(305945005)(5660300001)(81166006)(8676002)(66066001)(48376002)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:nov;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:O5k1T5SLqklkGEcjEgrt+qTeQHG8JjtdKlFqDWW7Z?=
 =?us-ascii?Q?zawP9bfPxiZiYtsVTfVDofEW6rJnFxylVwQhS29LRxGbxcQYOZOcr9DnjTKI?=
 =?us-ascii?Q?MubKiDJ2vWJFIlZixY+/xVkYmp9ReYe0M52v8jCE4pPkimYzpjq1TLRCP/aF?=
 =?us-ascii?Q?VfCzC5DHty2dLSxB5KtzPs2u4T9UZqg8LByWsH2btwr9on2Bn9N6pUZpVZZB?=
 =?us-ascii?Q?4sxD9uwZb5ymwNVSZ7elL31LzMLvZsuX2uQ1yyMGKL+v1EYyqiQ4oMaz4Y6z?=
 =?us-ascii?Q?clfD4KT2/RQa0GBiLGRp0AF+zl+DRA7pt7vUx9aGT+eUb4Cq/bg6/WBFt9u8?=
 =?us-ascii?Q?EUOxR6UmCpHoN7IffBP/mjBHnLNnrv7Pmnk3LTokE03MqoKIuq8fSIhbyQIa?=
 =?us-ascii?Q?YM0Uu37CjHTHnITTJqJC7HXLrP+YDpcLZgDCAgU8VjR29SU0hSB6GZ7KohJb?=
 =?us-ascii?Q?R+GUPj0spy4+yXqSvF8FSMzl2epq+jUUrlWpLL3CI898cPMiev0yHyg6QoaR?=
 =?us-ascii?Q?4ps1qNiaymReEQlMbh6LMztHiHoKqRkzk+ufee46GmENZtCyAPVin/iKVyi4?=
 =?us-ascii?Q?VY7iPPjWyDqxCzZUZiqT/wGmnqoUZ0XWu5DKSG870xy+XmNlvY2jhG73Zg5q?=
 =?us-ascii?Q?OdzcZnH05mofdHydihogOdu581YZsjHn9Jlp0104vvwiOJ5jOJW1zUdSHpQz?=
 =?us-ascii?Q?qWFObylxio6DR+Mu0Zf++bdrLoB9yFdgBqYzB6q537FUhd8LomzpbvHl8jEg?=
 =?us-ascii?Q?rJKg2MNRKcseSBIGJeXoHgdwGa8TGV2m+iBNqt13GhSERE/RXFawrzUvqtnX?=
 =?us-ascii?Q?Mbli9fa27PD9mCjr8j4XS4gCrnnRyB0xUJdyPjH8IwdIa77WGPVLotppJFWz?=
 =?us-ascii?Q?aGwfessN604IBWVn7j3zZ0HGm2IKj8CKwAe+3MaTqrXidfXEjVE2q0LnJ0RT?=
 =?us-ascii?Q?jtGC6NJQ4PZkuTzaEL4tw9LLOxS96EcgGxIS6n/CwkY6ZgEj1P3TdaCHOVDa?=
 =?us-ascii?Q?pZBzsL3U0yE4qcg/v5+algkhtKER5VPgi8bNFOZB+IyNw=3D=3D?=
X-Microsoft-Antispam-Message-Info: pxcVP2IvVR7blG3X58ujvFtYhpvwIiv2jJIcvQ3Hnqj5ku/OeRiCoXJ3j+lA59vu7yJNbg7fdWyDqUe0s5wD390d3BSJgY5/QRZZBPGQA4GbU/9LpSOeKlRj3cSZ6PT1SHSINOzy2XK1AJtf6bAJCh0VU4hsf9oeKJAq+5sL00/KixJib/f6+Ud5l6CfunUA
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:wQvim5iTt5wL3hFaeGfyxmge7bf3wkt9Xc24UnQNS4QHyRzzNvc5j7Rh760nXA0mns6fDQ5WHkc76tTLW1wm+O/uc/S9whw0WD4W7N6jKHYQfaHTBwTX37/6oE9C/TJ8vuo8orr5L4cdctsNNNbR0qp+lq7/sbfW+r1n0IJIbO9RIAKIQPYZdqCqC0A17g9pSGJtHXJ8NXAqEslVwYFJIaJdKHPxGga2v1jDrRewFbc8SnZ+pi7P9yjEI08JO1FGpuHGAv6ZVWrOMhVYfr35pNubGcWYAMNYoLpujaMzKJoO/NucoQg3k32FzVSpo4VupAU6kVYuAwj2QElAf0/WYmDwEcr2d0RYgcOtd6NtLhtlc8ixNmd8aBPl6wjoElDT9u0Ip6hXLyDk9JnRfW9Bx/MP+1+Ly1PIRmPDY+c7VnKl02m0EulEhoMI6s+L4Qttzit9R4sqJH6RQlaa4SstaA==;5:Hk713iU5yZw+EzSWqR599k72GMOXI3R+ntpac8gRiKuc0+V4u0O376ErtNPA1scdDR1HflJUl+o6aT/zA3zD/bEjVAV6nMqCKq3yOVt+TgVM7l5kHzwBQkPzXCNdRsTzcNvWXVv2/5SO3BIOMI9CovBHwa7Rv4PeyyvYTpMmfyE=;24:jPzUZ6O3eFkF4GpjwZ+Y22cA4T2+fPMojOfno0Sdmqpp5bJRYycuQ8ZjwMTB1j04GER6bsPZheGnPEO4rGqaBznVubG1sCXiRXX0qy24guI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:NASUu8aPEb1UR8YdcF+0m0+Bl9hnvmHa6+ZoE077osCKDCclQ5WRC8uVPLrlJfB5KmahYOTw2pR+cK2gpvj7oUcx4ZFvLnBTf+rlBguCkjHd9JqmtX145EutqHsAFVgr9G6V18ygfsvDUxJncleownp4gPd2t3gv3JZ2o8X5hxihtY83sPpx8CdI9okvsl4HKYl4iNhUTcGMIsMWEmm/G27/XSDKtibzrj5HaxQg2wkMS0GBxyLmdnIeT9O15jRi
X-MS-Office365-Filtering-Correlation-Id: 2c3b07fa-d612-47d0-257e-08d5a8cd75e7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 03:51:11.2793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3b07fa-d612-47d0-257e-08d5a8cd75e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
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
