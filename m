Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeEFGci (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:32:38 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:46000
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751766AbeEFGcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:32:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch screen support
Date: Sun,  6 May 2018 14:28:13 +0800
Message-Id: <1525588093-29994-7-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:ZyPyCOHOmAYAm2Apseb3Ot/lDZjgGgfbdKRHtXiqZfxUGf7N5avspz9646u2RhWFCvxKuIKGLLHHafiA27B4d940VHEXkDwGsNpqtWnyIhPGm/1+fC6W4ARz17QWaUv+/zn9GjZlZBnchyBsVIIP0NSajpgMmVeZNeeX6cZfG7IJBVoPEwTH1oc8uW16X4OA0ZOFl3Wd+4rfUFSUTYwNtfeWMUoxBdq23FEHQd7xlrHzBVpu48qjgDpSpTMJpyH/;25:y2VIiGQwyfNVDAWekakY5PMulwYwPDPDRJDtA+lh9tc0LYeA9T44JNguKk6ctszmXW5BpwXU0sgNonULwB3/eDOSPb/4rDIObEun7zZCYGk/74R6Uj5kmu/ZITvEQUhoegehKFIIMz8KXzFViilvbYmLXJUq5gRPyy46Jjt6xPY6RM0dn88xeiGjs9S2MOhf21UJTgETnubNrFwpanLlEcmc4T9Evrw3sNUQHuuUAlw8VP9dSFxL0VbvbDnZNzVfd9AORlDCZA8GOIpbTKLIyMc2wXc49ikye873YCIPmA8AiYmE64lg4Y8VQ0UgFVmHoI13BfV6GRX24+SjHLj5Cw==;31:WUdVsvr5uLuZUhT9O4yWgE9TSI15aMsYcVCqv3jCQBwsCIb0oPB/P5l/Hv6HYnn9O65dy8c9YPFWnVi+h3wf5uJpV/DTsZKUJfguUhZMszQN6q1gP+L57Sz0MkV+m+bbB8r2kpwVtzIxBaaGYNj3LXKif0GQcnvw52ArDULY4FKBxeEIDRRt7Ahkzd+bwawN2qssb0g301Mkcz1j+f6Xd3PGkZ5vPpTb58P3qfzSZ74=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:Q7Rh6yTQjgHMYz9pRTV/gmodCxIudFeSub/DKQoA4PPqBFndseKnEo0ym7Majb9tynTtdvZ19CwB8tfmfm8YvXbIGqEARcR24vmEXVTTvAGz6SjCM6TY36wiVb1OF155nvzywDqwgy+gxWWdnAqWse7XtwlgRCfcuLWQWl1kWXrbkqq5Yg+t42TWja9GQvOIEB7UHoGJAp/jzHKd+OEeRXweBgPi8wHv7U28AmukWVZZeTNd7Wuj4g6e5QZUihMFxhcxy9IAaFxPhIfM85a1OFPVy9SHhaDr+u+BEcZmuFjY1m0mfaHew2wDgcNCHRm8Y6ZRbO57J7j30rDDqK9Ph86k7iyqOJozgwOkolXi39K+FoE8U+soGEwP92h0RkdJjTw3xkhgBs3hYxuJ0HVFBwUo6b8EuXPGIBAGg8o+nOTq3YZl/wQ8vvHxEezVH4PW21kGiUR/AELygpELGrLhtmUOqo4SWR+vX0G/HGA2yUk640oAwV0FUd+0zzNyCuNG;4:HGn0Vem7T/PZWIFUWXLHBYRZCCef7ZF0OoxGj0XwyZUlfd09+SkoI+lx/8GJFZGUSw89oghpFRWyA39P+rH1epa/E2agRedJ/59BlfvwaopuDYawYes/Zw++qKEFl7SC/JvlCpwUBa3I5g2DvkkBqdxRInCRcXV+q98vmpvIJvhe41CO9I42hofy3p1FeXZ4dW3dB2hYk1dxzMI5gmCLJE4Fh2mOvsJ3UAOrTRldQlA4+EFS5F2bNVssID75NN2H8DmxLBoUkrR+zJRLMAnc/URabRWg8oM9Dw2wV+f+hgEhTLoRHVe6v6cnnO+nDfL/
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323A0DD5074F07C3FB62B0AF5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(575784001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:KeCxKgsYfRn3jIqqSq5E2XBaUoFPNk008VGKwpjRt?=
 =?us-ascii?Q?xmyd0uFoVwv/fS0GC4MDiuUO0qSplRiiQZJZ4Og/DQM0gBa/KOikI3+oLjhf?=
 =?us-ascii?Q?eDf6ioCOr5F591u+HnEOIF282mW0BUpr2cWMyeCgnSLZGkjX5g3DmzwFrE1h?=
 =?us-ascii?Q?CfAHJNgeXgXPj1v72AfdgSgpZUgDNRzLdzQSubG59Udf9iHDj2xPBhBsJsd7?=
 =?us-ascii?Q?qPhoxMxwU2GAV2PEmoTVFPW3CYJDtjAOH7EymSKyqsm3b4BtT3owrgbDE2y2?=
 =?us-ascii?Q?Xx7gHTlT0pS/MUczE5dIB7zNnDJx0ezXUyGaTxK6+1pEeoUG77pQ1/k5v4fd?=
 =?us-ascii?Q?Ls5XJyegWizZ5BhP3JEUIZJITOT0Eht3QOO7QtT4pcLhpJljjugO//BQJu/3?=
 =?us-ascii?Q?tyWCnBBAVMG1NLzy6K/QOckse7ehgbvqs+Ati7M8NkmMfoHnyV/ikzH0yUwV?=
 =?us-ascii?Q?X3M5zNTmFEM5l46aQxDf4HZvHPQrYSooTnHBp+6bNz7y4Fc14mtrXHwdiGM1?=
 =?us-ascii?Q?jaFBEfdxmetL0tzdrnIEoxe4CGEeRo1wGYzUx3atG54CN0mouAeoMPrZ7NgA?=
 =?us-ascii?Q?lgb9s2R2vt4rfy4s0eUNWvi76XrVWMpdkTONwRE00/zDGRIQNWZTZex0FkTn?=
 =?us-ascii?Q?jD8aWnFzIb626yi0VVzND0WZumYXIKrxDXv+vlPCEVto9OwXca6b9ux1D/M0?=
 =?us-ascii?Q?AeXhsMZGRQ8sgLxvj3r1o+KYXuaXaL/EG2IVXOaJHMujLUHhqoumcPwNN8Dr?=
 =?us-ascii?Q?62PTjxWgVd3iogJgeOCXxIrBIdrto3264KMrUK/PuXxZ7e6/6nyftJZW+SSK?=
 =?us-ascii?Q?vab6SxoGeORmTodc2QuBKyPRIp1X72zbmx87quYbpYnrngrvA+RKnJPX/5qr?=
 =?us-ascii?Q?VTOODR+Hg5vg3DlLT7d9wxhDCr/df6ZLCrQ5/KMNZDUQ/0WkvXubesx2zCDm?=
 =?us-ascii?Q?Zx4WsLi4lxnb2+HiEe80OMA8nsNnw4XfeCZ08Nb9OQIAbhLcZ0BdaO7l+6Rm?=
 =?us-ascii?Q?7a73TVw3nwNvTpXM9ZV1Sl7fTlp06U+NdCcezgXV/k1X+PRf0b9t9jISSSVC?=
 =?us-ascii?Q?lYmB5vUKNn1RFnZt0d1z05Epsp0gdDIhDO7ZEklIgBKw4fnu9Vg2EHzwmJ6M?=
 =?us-ascii?Q?uNU+gwBhYm3AuOOar4scIKdb/u73jyM13tNqRrWYZ4Q/lLZdjNkFYFQCGW9c?=
 =?us-ascii?Q?TQnIMgTtyWEdX49p9cwdbYMrh4ibTcrz9co5rOQjUYohpYZiW8ye4TvQWWly?=
 =?us-ascii?Q?LpWJNTibAaVwNS0vL8=3D?=
X-Microsoft-Antispam-Message-Info: mdCtbChxd9AD0ilLghYyVqHNFBbh37D8kNTbGyllHkNrLBYfJia7tjKY3weXpudSy7P+gjXX8kfX5EjHAsMLphGDS8SunCdr1+5Nt5VAbYIBIF/sXzEQBr7vpIIviIkP5QXMfmh/Oss7H3xAWvI6IFugPzrY3mIMvpZguMkF5ypvFPziL4LUaj2NZDqbiePU
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:oacYO3BqH2VrrIgoHBx/0b+pssfzMhPybE73oIWVTfZH4wP/plB7CdSCeUTKSXxsUYr6upiKvGhCk0fSZp18McK44zCPvZ0kyz5M+imbukdi88X+oq6yUP5JzYLXSkGMmjjJqbbFCl8rLP3uAJ4KGQ5Iwyp6Y81BSdEC+OU2g97ARwAtoQQJP7gbpI8yCDNoTVOTbFjGB2OEax95ExUSa5yz2pm2kPkqcCgs3LrupaKArS8LxKAXcx6CgpGncPVBn96QlXGnL9xoNjjdEuXMNLpRjAbWmEubr0JsP3gaaWJahOstfJK+tuT+7eKGsmNdgDOiZuw91sSxr4zpRRKNEl/HMwsESdFz/HLqTiPiNTUKC0JQrmDtxJDJ0GuLQQ8RIJtGDmyrFuRmHh2pVszqvgfX6PZZbgveR0lSk8VBU6UkjOonUcXj4Rj/7NvkEMihwKaDAlvbZJUJo3o3XfiHnA==;5:Qy7TzxW4X+P3wjwoMGL4kFtKQtoNq3yk1/XfJgdNbrgaivkv02v+QfxzbA1R9KsOLOrDFKe69g6bgYCO1bIvjYHVAJyf4f4rSHtpyDw4leR/utXIhsPTAmrLa38RiDILTcdhRopqS/WUjIPFvyY3QGXNpvkI6L5uWGSGrBymLkE=;24:akrBWec+D6h7y9lLqvYpNjdg6TugbNpGuLi+Od6d+n8XsZvqjUeSUVH8RQ+UC37Mox/F+lJ1J2nmvgQb0RyvCLF1rURMOve+S+FZmTqqpbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:XlOuzdhmsmv8c6xADBfg90LvNgawWYz180L+jlSt0P3Oon1zRfvCKQUms6FUjZwD+N4U1/OQDvBQS82N1wUf6BL/GC+vMGK7Rec61Rz7PRXllpkurirJpZYzy5dY83bYiKkApxkgsHHM+wjPN0x5vvmlD9wQ+TyEvMMk5gjEqq9DJ1ipRm/RRNOAXEhHFx2JpKnfhkCRJmfohveIWtu2L4u9H4cYwOXmY35LrGgEv1QP1ZtG4w0AviD9cehCS8Z7
X-MS-Office365-Filtering-Correlation-Id: ea7dc1ce-8c59-42dd-e87f-08d5b31b1b8c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:32:09.8624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7dc1ce-8c59-42dd-e87f-08d5b31b1b8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off, improve node name and add PAD setting value.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 8e6bd9d..bfbcf70 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -111,6 +111,12 @@
 };
 
 &iomuxc {
+	pinctrl_egalax_int: egalax-intgrp {
+		fsl,pins = <
+			MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x10b0
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
@@ -253,6 +259,16 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	touchscreen@4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_egalax_int>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>;
+	};
+
 	pfuze100: pmic@8 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
