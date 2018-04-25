Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDYDfM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:35:12 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:38806
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDYDfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:35:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Wed, 25 Apr 2018 11:30:30 +0800
Message-Id: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To DB5PR04MB1317.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1317;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;3:IyRh0vFli2LKz3nClLXw2pAyJPwOreldBMWXotYxptcttZ2aE/8iPz7aGJxX6AJxP/eXxcTW9+CjM4qdhS3SkdUYzWMWTATKSsTnbXZ4RxYpxsSS/PxKQRl6+YZwzt5DT1krm2btk18kgjlj/91TA7cQxJVq5pJTkdHg1AYC69HBJ3wHKLzls/tUIexRXckft/2ig7WnySpaIL2LdoMzsK70E4WX1K1aGs1yU9kT824+QNg93Ujxv/xEMWk1mRi3;25:0nxdtU+qaz8lr42uOtEhV7Awh4UucN+gsmGCJrkfiLH5Y0/nCrOfPy1S1vn0wX6lrTwLCdP3pbHHOiD+m3IgXXS7oAJa/ET4nG1Tfky33+kzJAd96KKpTEe0WbketIUncLIURoNU+jHyQx1TzF6cB0bAFpwsqpbkEwPbYUUESmrh+nSzLNNxuMiVIwkIHElY4CvAHfVZMDxGRl5IxcFe2aWwWZObC6J0o29JjgpTYlO9Zwu4hOakQoqsLagTGjMTnxTo7TLNJNbvmQykx4WpUGl+5RC6VOzhyZyHID0siSLll3btau3TQRaLm6IXlHObSijO/9+VKJ3VMNJ2thUc5g==;31:rssDsNTb+ZGnUg/BlMNftiwPIrD++Mpkkz+wW68ELHGdJxPxmeYE78gaV3qjwfXrMjXJonYMzlNoauZfQa7WezlSgkMIX4TtqmbeaEqRBEz8kQ+KD20SV9C458BzmNqu3FirVZD+F9cJKI42Ib6OAEdOHz3y6i//2rrjjUGPYjUNVTsIiv6uMbg2IR3BUAQHtURlfMYZGdXeLJLuroVcKZgxsoQoADFYZhRIEFCpfvU=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1317:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;20:V/B+mLKSJiiJpTwlrjIxQ4unwcCh/gEzZUi/IxlSqoT2CpapxTZmy/MIZQrHn1IFhINTrKKw8kUXRNEaP0KeUlNrGTLYo/HgX6ZYrLagp65ZT/InmOoLtoFiGqb7JzdktkF4yVgSV1j7Z1d98Dty8Il7AzAJVmbunWRkzAgh8HmA7AV2P2ztCUvwzsg5scEkMHLRnJfQUsg7Yrc19LVEvkkathHxvZMoAVdeA0cQosG7xuUGU6d3gijso3hTdVlocO175DGFZcxUf9TonIuvR3JuxhArqb6PdyBQH8ENbAIdQl1hjpNfetsa5f9niMsEEIjz6I/xQaj/+5vX8AAEcdmGI33CLv2jeP0pjKYTXEh4vDWz30T5u2Wh78veBHDvMDBXPOo2uly6LJL5bCSANiF82SMW2cXLmsQpdC9Do1XhWho+Vm1iiNsBXu4PowQJoa5e44s8ipsoMaxaf/y1JmxMWZhg3co+d38f2SHPSzCpZ7d7nHjYB3kP5iFsTg4a;4:20M9ulKYfOBRauZRPbzMeQaIjL5i8FjzZ6d62ZpwFFeaiFF4gvXEEEdgyHddWX9mKF9KCjxxqiFi5yUb/2UOwYlpV5//R5zwS7us/8+y+jxBOl/hXwp9+rdpGHcERxknGnApYN2ATGsODP+8w+EFmu2MW3A40Rsve8sjrzM9oCAbzce2lriycrg5/1OClbIFqLF6RcYdFqSfYTIz3Luk16Xufff5wyTeb4gsdsc1jbkUYoZaSG2wjvHSMxeIqvb8m/9Wt3Kihss/LK77/DF85MbGvMKYLXI7yTOfx3uZB9O0fp4ArKG8mCyzxYnXnWe4
X-Microsoft-Antispam-PRVS: <DB5PR04MB13172D16CAD48C1CDEBAF7E8F58F0@DB5PR04MB1317.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1317;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1317;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(199004)(189003)(36756003)(478600001)(97736004)(6506007)(386003)(4326008)(25786009)(6666003)(53936002)(6486002)(6512007)(86362001)(8936002)(105586002)(66066001)(106356001)(47776003)(68736007)(48376002)(81156014)(81166006)(6116002)(50466002)(5660300001)(2906002)(8676002)(2616005)(575784001)(50226002)(3846002)(305945005)(7736002)(476003)(956004)(16526019)(51416003)(52116002)(316002)(486006)(16586007)(26005)(186003)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1317;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1317;23:uDEn9eKpGdKwYCtDPaB6xd/4pcjbn/KC6bCZayEba?=
 =?us-ascii?Q?WKI0b1UziKIP5CRldjBM8Cz4qgQ7xkJ5F5YuWlw8CmQxx35rONhcr2P9s5Wj?=
 =?us-ascii?Q?PRT05EYOPOURvoDUYX6/NsAK8ai29SPJwzyu4syvz6mTsEvhcMeiTgvZ8XVX?=
 =?us-ascii?Q?9OsL4Nljq9igLYb1nUcV0HJXdI3LjdyV3bkOCTFVV/30SHj652biAQ6KZyUn?=
 =?us-ascii?Q?QSb5EMPYFHki1FYwrE7acQS0MTs6MbuRF/KUNkQhM9ZK/LXnu8DN5Sgj6E4B?=
 =?us-ascii?Q?MO4hBqfTL9kUKzQ3ImkvgGL+n39aJHFRBF0Iz5OIpIJLuaoemIdPsJXoyN17?=
 =?us-ascii?Q?s94O5NYDCe2WALpIEIeRQ7Zd/rjNjN5TMUOFr5ixIGiXXs61M12O7a5xggo+?=
 =?us-ascii?Q?9SdObvBEZqYBVAn+qj0R0y2Uvz9+XzoPg2EpYz2FIzPlYDUQLpxnyPE7Oypw?=
 =?us-ascii?Q?HIygkosaklVhPURybVP8i0ozbvhrm7kDIDbfpwHJX9nQlqHURWDFZeCLUcN9?=
 =?us-ascii?Q?LKAxYXV/7F2POWXraHHFtTRySV4VK5KDiop1rKmx6LxtX++O46/5yKogM065?=
 =?us-ascii?Q?e02rmumqZLlJL0fkatxmCLvq/qzDi3qFZ7jLKsQUxxDpWFRcyjnIQK6eDQVJ?=
 =?us-ascii?Q?YRQ/vdD9ldCIhYVncTly3zgo/4J1aF6ubJKd+qwuMWyqOhJEgTQ50X6/pWIy?=
 =?us-ascii?Q?Zo/gUpi6p5g5QZA5uUEwzOuznMGHCQMdwWalR4KenVB3jpRBuwY+1Lq3ts4i?=
 =?us-ascii?Q?S7SGTLQ3yAv8zUb52RPXhJ/mhl/l2BPed4BZOd+tD9eH/4F4FyQ8VqNkDIV2?=
 =?us-ascii?Q?K/FaFXBC0cpkxS1mETxLqQydK5JAXlJTuFymclu60VsgE3b+/JqPG89aoxSK?=
 =?us-ascii?Q?EizJMBl6fhw8ssA+vXBN6X0omm5ez7StbX0wYWZGDZ19csiB6YiU2cEZJS0m?=
 =?us-ascii?Q?dOnzHsEu3KfPGoAfaKksgk63C46LgM0ELstDjTH4SCV4PIlonPhzWzieiUqp?=
 =?us-ascii?Q?2QT0VxmLfPb6URSGVgyIJJWgfKye1gJOspwHWsuwbLUb3HQoAGb8dI0pQYn9?=
 =?us-ascii?Q?stHLJ+xIstGil78HUP01RxD7LF1aIL0fT7aOApHwnSzv0f3Cv3jhAEikqX5c?=
 =?us-ascii?Q?hYHqSbILLeTmhwv/U5k2qpx4k4Fofqgfao6qerG3JlRoVt4pXOUxomcWNIaA?=
 =?us-ascii?Q?PkJV2qhmVfdAuoE8CjZ6I51hRK1dAwTzOjM?=
X-Microsoft-Antispam-Message-Info: UO5IjK8taHlEAd6V6IFV4BqLHg5+bN/+Tut7VODKhEEQL8IUuH3FoGq0c4Eq3muuHcK+yHOh3zDfVkbPXuTaRnaDpZr2NmGuU1Z61BWFOU0sCSYkUBngd3I1QLTQunEbACLKqCSSkg6QZKQ+EWDYLtXHUjZNnlxM5R4c2Iyb+p9sJFgaESaakWMZ+hEgTJSH
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;6:qGfNv6RmkeqaK3HEJOFiuYQgE6AHzAJOFyFy/XBB1jFqxv2xSrlU7tnUxqQkGqRvkTI1CY+mj4lJYyinpOrg+fj9EZ5xH7VdII2yOicxu/oFH/P/NM/AuBqEEp2Ho8YPqX+p7LfGoQ025sr6J109QMApKx9HWrKJbgMl6stq6PjbMEz7uMwGnEOcHYws8dIiLU6xXFD5qIgYGMC0tG5YOIbmDGoNrBel3hWv9Fi4kGpMfNymVJ8XiSNFcMrr99/MOiNXxyOh9lHGHFiNYKcQ7T6RbSMZt7RRKVeCiyaY0cpSwZeLJ3LbKMm1lPMDEnfDFMHW6zvNy94QEic3KKSzpJE6DUY4clijN29nG1NgYNQuYFAS1uLk8VwKCfzMS2oV1eRQ1+xh3uQpetEpKFH4ro0e724ttppbZY29OCH1QzW2JaW29RUVRX6dGRHv8t5F9vd9p6MAj1rgDJl9hiDIeQ==;5:DHGu0dF6t8WR6SGq+nmnlnZVf4qr5KljsMqnhl53ygs4bQk5Lc3KddWvpX112pbCuSJQHVumwe35x8rBEft1gEjcNuZ9Lbe73BuYZKHj+rj413GUlL4n9jVjcfwVHrlYJEtg4Ms7DyvMWQJSYhj/0OPEke5yrf/T/9ipvESOgLY=;24:w8bsoli7W885Oq+cDZcWwILoYJy3avG0N7ir5ZozzP/0LIEt/Hnxtj3idNshvNZ4HPO9wKmFcDk6Lpee4wljnrxeK/BkYQzlmLJoLzfLA5o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;7:69RoXBZ4OQxHn9BaFNJwSwpGPHgTyJep6I+Qz1CfRaEeMIBh8wX24SZ8/q1DOZN0bDEcVz1IKDhSw65skahPqCCtj5y1ycOk935N5SFcx4niqOzi5UTKbTT+Uv7UXj+NwNbxD0/WElavfTUTXzuztGTufm1hVYHr0aCwBwlRGisVCXKWUkj3D92DKZPgV6pbvo1Fsnq2xLxfVxDt9OYbFZKyKtf5/k6mGiVRh3J8IHifZI6kuOafe1Xoou+6FUfx
X-MS-Office365-Filtering-Correlation-Id: 83250267-1ff3-4db3-4897-08d5aa5d87f8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 03:34:58.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83250267-1ff3-4db3-4897-08d5aa5d87f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1317
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V2.
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
