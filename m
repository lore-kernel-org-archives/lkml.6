Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeEEIdi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:38 -0400
Received: from mail-he1eur01on0053.outbound.protection.outlook.com ([104.47.0.53]:40149
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeEEIdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch screen support
Date: Sat,  5 May 2018 16:29:23 +0800
Message-Id: <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:puCJZc7PVbIgRagKhlntmGlZe/iMMNtIxkghq1aeKe9cEL0lkyVwR+RYx0CgZTixxDtUKP+QWLaGCqONilj7IF+r0s/61dv55onYlFsrivXhxY25EY8RxNkUxmO0GOXoH55AO9mm3zdShTWswEpi8N1+I9637l0QrlVMoiwmRIGYaJ7QHpBbBG5o2JLyxLxdhF+mA9G0x8TxpC0Q6ywrWwdJ+inEfaClYsOEIWAVGU3b/ADP/7uRwRNTFgkycny+;25:U3QRGagA32vl0dkrt5lQG6nQTQWUMSq4GuCxeJF3MIMpYk4X225ORruDsakFOWO0zkrmX1Fwi4viJTYJ64BJtenAtaq0tdvlZvTcj9Pz9YoRu+CLPo4rchW/tilOhy6U03+R612THyZUiP3/kl7Ro/DonbvIOihxV/MjaOQJh+9OUpwHtzHgQgtZZLpRQL1OUNCVydatp/oOgxI4f+g6Ui2UO1u8zg8HkDem7HKUrlsReC9asRe25gPDYKrirgGwaiiyk/5xraVCOmd3kUxBhYjinUobakOqHdIgSHu7BnZpw0tXWpRAAzKznzgFL6IaplW5WdXOeqoTetgGWKEPcA==;31:DuDCSVetk2iW0gW8v1dqpZpmyDaz+VHh9rhuHOXM3zMzN3VtkcjKse42sGiHsIXyorL2JYozorKb14DjdZCQo0+ymhEbAUBag0zyBkBYiKujRyHb5LVpVv5rTgwF6y9fxPJpzWNsC+7dp+H4LeTCne/ejQi0CYQwcLG35MaJsoNZxtDeE5GF4xW8udqQPSShayWMAlzL4kLRG5oW4VFCVoW1F+UduGVxBXdQVpPvnY8=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:nxzcfO2Ojz9Q8k8dnl3WpASGCqMGn4hnQY0Gz7HhXQgSIpDO7R1ezBp683UPnG+edHvSH1zgerwW7HO9CQT/08ZZMNsOCUqzvZCFTleLeTJvOUkOlztcqY1BK6keHUEmzBWt4+n8M+8ZrUzIYv+Fl+v0uEoPBBwjWI3iM97zaDTk/HOZo6hdVM6IzZM2KpSRDaQjmsI1OilhhWMsBfIOItybxdkXMj2qf7Bn0FE5nm+Czpy2jREWObRRTtQWqdUqh8X4spENIdA13WRfgOKCJe0O4Ekryub6brp00dPHTjKagYsfLeLRKK+pbQLwiCAJtgFsQLmCOVr2uc7tHzodejjlo3b/tHsVw2Jsk3PzBvIdB1vjRYUov+ADgwneFlR4YFIBsfKc10uzmajdlzOUzGU39ogJNBfDJMn+h2OhA59SvroLeh+4aGp2JzDXNJBb2HdWVliEvXhmcMh+mBcgDCYx6uBrGXitCOJ7/MfqH1mQQJkviVKr1SqphQpguNPg;4:nlvNwETQOgDjr/I73j809nyFkxWSB85NvaicxRrZZNFWzn80DEEw2EGnQfXMpNs9/3ZlRiQa/mPM8yA3GgtsN+zygtiXBPEjskz1gkmEq+a9BN33lHALc6CcuXqNvfSba1bh9bE+YIfy3B0CwjokfwanDKcpIy0bgk9xCHO/uEjxc40e8Mw2PAkxtIBpJbU9r1qEKYqXNeWVMbqGUjx35OXnkKmA21rmfjIEVipRpsZ3oEvvIHdqtqUda2wpuz+iL38tPYDza4VErp84x2qcQqqSTK4VssqYfwxdzG422zMbJ549zAPgeeux7c3UKMmZRho403rb+WwsNxYtjSCE2H83X4v82oZQ2xchAbiEMEE=
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315D1B6B300FE59A998DFBDF5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:uNoAVzuAr82i+VGo+btLvehguHEu2fxuT7BgcFAsX?=
 =?us-ascii?Q?Q5topR1GXWKxQhppJN4Wew0YyDgJF/6BW8bR/mGhyXCD1g+Qy9w8j+S4Ksdk?=
 =?us-ascii?Q?wtOBIuf4gfJqprZfuT/mHKq0LRzc1HloQ3p587pjP+R9NxQRmdV1CPobTyZq?=
 =?us-ascii?Q?McUPY1vT7jTZyRBqzPJn2V35LXF5H17w8oIr4rVyyhCioV+aiSivr+2zABk3?=
 =?us-ascii?Q?u0jHZCSzuke05vAOOpYR2VE0gbA4EyL83+6wk9SnlP27BfvvM8VStM1QF5b0?=
 =?us-ascii?Q?+yWzLTuf4UXlgALMn3Y0kj9I6HpwjwSekpJ8QiwotYjaIqkpAsAf4ntM9o24?=
 =?us-ascii?Q?PLj7JQilreVJ/5qbFXBHlCGGDI0db6tgOqEBGbcA+CgvpLqDWd6rwAUbTR1z?=
 =?us-ascii?Q?FAbOC45ret9ZORCI1ilGKIQyK1dPwHCmOsm6QWJLxXu48ZxMniuzuf74Q0+F?=
 =?us-ascii?Q?/VdMSyF6tYam5tIFQFsTwRo2KQFwoWOsbdn/XNKpx1pAZs8SD1N2ppf55vBj?=
 =?us-ascii?Q?v0y/na224Y1bqbhQmgYgWIgrAYmW4uzMDMbUtl4hSf6WzcnG9VQMwjLU2uur?=
 =?us-ascii?Q?hYfIVB+BiKW5gW3GV+R7xqB4hjSVLeY5XFTENdEiaHFS/3hfROA61pDxJ1YW?=
 =?us-ascii?Q?37nMdfB4rkpyWzvDRY45uk9GKxpXfuA8SvxYAkUhr8hp0FluuUo8b5u0k1cY?=
 =?us-ascii?Q?Ta8iwIylEzcSCuaKjQmKyriMuu36dDBJ0E17nkNV1lUjeKdmvk5sB311kLGf?=
 =?us-ascii?Q?J0edjQwUcCYgUckvtaSU+dhNH6tww2itOgtOMHhm59XnRq0en4hfiORLxa4l?=
 =?us-ascii?Q?rnt+F8VU4JKtyFn+6hBNh+zV6yeuX7/1drqE+9GVGNjbx9yBO5YxEdXCWXjJ?=
 =?us-ascii?Q?j+ls48tXAFWUEcnM4IMGivFZP6AAN/s2l5BjjHg4B8Zj9vhZttXcKWqJQS5u?=
 =?us-ascii?Q?kM6Av4alfTQb3Ll1of2eIXbbRyQ1LXg5xZAILeUWXb3FWI+CkBlKvbNw6GKE?=
 =?us-ascii?Q?6vGGhGeMTiIGOeYWyvEQT152sVbqdvFiFLPvKH7Eg2hpJcC2OBa8vasLoZU/?=
 =?us-ascii?Q?9PJ/IADLAhhtT5fic56Ggz4JjL6j3yPl+pTqs7gOrzsLJkCUrCE8rE7Ep6s0?=
 =?us-ascii?Q?2IYdtfhiiZCYnHSycHvzQiam09/6VZL8T0cl7syAYv/WD0rEwkZQnpC6KYRR?=
 =?us-ascii?Q?2d2TOPaZzEMawuIyT61hOZF8XN+crPDw0pOhcryrBC3qzzp372XJeCLOw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: q39Ir3mbhIC3AlZSOpOYrtEGvT1hF7XdAoh7nLDEdbC4VRvuy+M0V5LfOBIofuEZh1FvClZNVeE7l/68lP4VtP/tJ2H8Ui7Jwnb9H9quen+gj9BiMINuwaN20M9owjvmP6JEGMw31VVJdI2ax8ff2M7KVTCy92lL5xLuC5VvddK+wrYTVHZQpiRoKuyMNfog
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:w8sUochZxUHCwlOaakd0US/DjN+GI6/hUBGTUC2LChk71LDYMo/NWvRG6DBXz6NeBREpVc2xdGHBm091xmHHLkOoN2/VqATfJqRBfLQxa4PZyxXDzRPYgfoTmHr0QpkWRXY0AddT1T1g8kN6xwVQZPe1bbHuAlQ0ENshx/Gotsty6MysDC696yeacqFVvoDsylIr9EMymPJ3LKYMYdz82yqg/vJw0p13ANLwZITaW2TIjw4zI05FK+d4Ukg7IXfbqBdIgvJBvPwMzlkEaZmhf39MGCNsTx5YUSWUINVUROMxGoHp6wlYWya/Su/mr3s3r2GpHHShqfIPvVc4BDL5tH5UcbvB6CaqIHIgcxWsfDh+Z90hMoMZ1lsZKnS/0PJOfr1Se3+TSSzNs+C9sFP40vWuM1tYz5BHUKp7UUI/1FYeMeohs+zNlPQM2lHlL3Z32c7NRWLMXbuGbrcVzST+0w==;5:RhJGHTB5SXcKBFgqNFXhyfAlrbTB0j2by021yyRvj+xGTE8/gW22GtPm2UR6q67R0LxJLnmh4H3kMfhbAZ+/zOASqD3X55ZX0erYIGYQmIXZasM8OCj044lDzMn0Dxm06I9A0+ZfOlI5+0gQXhru5H16oYWhmZDVV0gibLk9kBQ=;24:QzynT1QwVdiA8WJAENf8ox09iZNSaZ/4tXppdaj5IYPkWx2HIoDkOY0fR5DXWQk80Yy968GWrF2LzBrjSYfH60zsc2XEgXnP51CP74N+jPo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:tjJYqVEBAbz9T1K5909q27yiHhSG56XN78ru9Wn4EyA9NPeXp+iT1Gdfmq4d7YxTYbYz1tZZhC+I2qRtT21ZjEO6fSVcKlssZhFgT8r81BkBOyzN/kkGuUPhlSghviEdcJ+UWn4PEKke6cffl8ck1wQH08T/eKLkVJzLvsvodmk2cQrE4UrQig156PrbjkfP1NGuWfoc5/qyNO6kZ9ImTxx7Rgj/brvpOuTcSRKpjS+ZQNIkGTOOs8J9/w26dUkO
X-MS-Office365-Filtering-Correlation-Id: b3a38d3e-d951-44e8-eb9b-08d5b262e084
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:33:23.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a38d3e-d951-44e8-eb9b-08d5b262e084
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V5:
	improve pinctrl node name and touchscreen node name.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 1dc5b58..3fe41d3 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -122,6 +122,12 @@
 };
 
 &iomuxc {
+	pinctrl_egalax_int: egalax-intgrp {
+		fsl,pins = <
+			MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
@@ -264,6 +270,16 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	egalax_touchscreen@4 {
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
