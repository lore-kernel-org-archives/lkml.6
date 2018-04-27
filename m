Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757481AbeD0HCj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:02:39 -0400
Received: from mail-db5eur01on0042.outbound.protection.outlook.com ([104.47.2.42]:22765
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757373AbeD0HCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:02:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6sx-sabreauto: add debug LED support
Date: Fri, 27 Apr 2018 14:58:08 +0800
Message-Id: <1524812288-799-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:404:28::29) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:8obTLAZDv5cHZi4YjyNflj1RnNnjnVTSh0KaM74JopTNpWUFvhnxNQSFgvnckjEggC9OJSi2eaz5vbnL0LlhSSQZ1kHfCDhnAtDEUJoXzcCNCS+jGfRwbBHwVGMq4mWt0Sz4m0jKztC4XCxT5bRMOk+P7qczh2GFVbVMXiux8Vge/AdbB7kR3Uwh3mgw8vq9pbssGGYlp6r+AOqO2YUXAG14aMeI/MNQKxvP+AFXto5gVe6CTKc7WoTRc+UJd4tM;25:5TU+OOgvKR9eU6xJcJtlbDovUnW4ims/XoW4wCmyjFX3v5cCNkikgshcYyUHjchjWFcetTrdjmh6Y1tE2nH6tAJZyjt3tN/ii6INX3Qk7/fj5+/0PdCptoK02KrBwf5mXmru8SznS3QrLq/MpPtAV9dVdeUZgZyamHaMscycdnmTgSPB9Hzeq6kMXBsWhfe8YNcaROTsB1Togr2rw50U1ekaJP5AtmdAKzs5fvy2vvG7A0cgA5LwBHT53eKhpDHXd3gQxD8ocgDai18ZZe0c64RzBpjttmAoOMZ4xFsSnyiqTQ/1sbfvasvXWHpA1fMz9pYoCLqxeql0UIhsqwu7yg==;31:qX8qJAPlexewkmsLEoTzQCF9KXG4MorifyjRONso5uYkMJEnlPdY2W7zeyROcrqcSzXl6ZcHF2NGofJe5gPa1qAQelPxj6fuBYC0ZVK3yNR3i7i9C0cu4ox+C3pbATPRZ5pPMnNwEGLPCU24cbBn6OHk00zoJk0IKieSeTWac5JuPTodvzw7h0fPuImxBIPG5/CkXxwXxh5Cxvlau7JaV9y7qypY9dkNscAsBbUXzyc=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:BcLb5pmtH/tHOyreHbBynDHHDBklz/mjv0e+KFYOnd7Vol0kmudj/3sg3FTMM58PWPWJgMdE4B3/tQ9qUBnEe6W1L83BukBZKAOmw+iCcPtN8n6Tjzq6G9c/jKi4L7t82ERTZ48E2KfvuAvT/fy+Ep0MY6gsMqOtr32uEUom3wI2PQYE/MwIZyEUo6g9kIpHb9Dz+XEHKiklR6PCZRS424wAxtIL+pQm0WebO6BPwoPDhDq4WhhFAgrRWY7pMGshQONDMIXBdfEJhXxjIPakAefar4+xND++cIxA/rrYV2Ngk+TEBK5xSuy6QDgtM082BAq3Qe+xYivoi7P/LCy3xxJDbxUBqfkfHcN7IRH25z+L52VpYVeCnsVDEnW1GnR9kt8dZG1OvC7Naccn2bD37UW6LD4ptRAAImoYsw1zbzT5VoFpSHBqXaNgAZqiXipNKaUCsMQp9ZinNDXAi2RYWaYCzdrr913+lPG4RUwpVzxYFx0xDTJNczozw7FWybNY;4:pu6wpO+To/1VkeOZ/4PN374ITKef4QMPLYBP5/10qTH0BYV1+bQrw+RXVu03PyJlyPCPubpGJEOlMeqob0Chn4nd/mdt6yuKlZi46GnN8du+qc1CACK4q0SKZZUY9GfVJcQIdIVoBkS2n0OBRAc0A9OqMAlMVVVzB7Z7skLHcJ3b0+2RQwjzAYCfygDwo9ZgaK6ClY4Dkli3qJQiuLLya7ckWIq3vTpQ1MDwfhi8zNjERVF19npSvR+nOliCAXworSjrTXq/DyMVx9Qvn9iS/pgB8Od0ggOp+vNutwHAq+PSXNEFql2/vyUFYFM+ajek
X-Microsoft-Antispam-PRVS: <VI1PR04MB1326B74DD40531FCB6CB12E2F58D0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(2906002)(3846002)(51416003)(6116002)(48376002)(53936002)(486006)(6486002)(1857600001)(6512007)(47776003)(6506007)(386003)(50466002)(97736004)(186003)(50226002)(66066001)(8936002)(4326008)(86362001)(105586002)(575784001)(6666003)(106356001)(7736002)(305945005)(26005)(8676002)(16526019)(5660300001)(81166006)(81156014)(478600001)(2616005)(68736007)(476003)(36756003)(52116002)(316002)(16586007)(956004)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:nI2+3Rb60cWd/q84TlOWxlW+uHElqu/je6LtmmJK+?=
 =?us-ascii?Q?Ol5SXIKRBqskvVAxkrHPUm5/4f4opP+yVVgjmwed8OvAOQeqibZPfyZanZC9?=
 =?us-ascii?Q?rAdd3Yf7J9aau5xsl7nqPFrePJHwPfl2w+3Axg6Oi7GXl91BFFRMgNX+D62P?=
 =?us-ascii?Q?P3TSlal5guUtVMM+2SzUBPAzrxT1ZJKGyApkCQDVEyF3X+t2ne6tGs6lFmkE?=
 =?us-ascii?Q?s4jBcLirCP60U76qYjil0YwRHssyGQpRRcQFp381vg7vvOFJxUNevXH/ghNd?=
 =?us-ascii?Q?lqY4IqrEaW5O0pVk6J/Vqr84io/X1cdV0lHrcjXbQaT5z1X+H7aza/JbkODw?=
 =?us-ascii?Q?nZiPAjU6rzexV55S4KFGsqdBeq2R07ARtfdCYRxwBbEkhPPJFIixFUfYXaG4?=
 =?us-ascii?Q?CjcMTGtrXlduMzR3+DF3wV/PV9tbDm5d5+XOSvn3w8GjLaiHpV3Nk+6xLiWr?=
 =?us-ascii?Q?ywR8vjJAqIPl1GiHTYhREwafnsFp7cYeure3Kq7xBeN/PRNkL3jVMlFvNghP?=
 =?us-ascii?Q?iMcyrP7Zo3WUTydjHx3YLMoe2/a3PfKlzVqmQg/VRH4Fx7o7w2zVEfXGA+Uk?=
 =?us-ascii?Q?gWcMo0cCMvZzr9Yf196cZ07qL/nTIHAqPV7Je9epxmHrfiXjt98WZ20dgoL+?=
 =?us-ascii?Q?RRyNJW3+zqy/mctwt0YgDoelBydk0wmCb0MmUsHF/wOUTS6PJNcYmRZopX16?=
 =?us-ascii?Q?SmBDl1CFVZV8V54jmXtKHSwQCC1VlfTPCFYxvBJvcjyTMrb5TyQ7cacm+lRI?=
 =?us-ascii?Q?m93uIok8yJBHVs1EilPRpcFf6I7rOHQIzJbnGN+ir61FhRS4kyplRxuQZAC8?=
 =?us-ascii?Q?5iLfIPrfcOkVRc18KbxvROlu1nIixQNcZDpZXNWGaxybFVYHxb114WCaHEtf?=
 =?us-ascii?Q?K9jWiwLfkiRZOWOmTFvhOmzktUFri4l2QzFr58EAxP+tsTUzyuevNk+eQIJX?=
 =?us-ascii?Q?Ky3hi2QLg3iBRJnN0+DV1PUvKmoLL1cSit1j6oWh0vEBduiHiidMDLCuhqHu?=
 =?us-ascii?Q?TDDdx2VGQNYyr2K3cm4yezHeHCeU6T/yTc5nC30BxGIFyt+IY12+MjQYp9Oy?=
 =?us-ascii?Q?E0nNRkUysc1aoInqYZ4iIOA+C/vDkH6AGB6eWFgAJoi+kwXxA9BPLNnPJtRf?=
 =?us-ascii?Q?dHy08/YqjwmVL9ooYvJvk8ogCPvyzuTUoVXngIv9/xNyCqcnN/BPA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9kAbi5oy+SHL06xIQwfB185wqSWq+1C0GAsbgrCcQVXwMkZhRmh7gew6lxzwvC2SIeDgj/u8n0KQcE7Ji1RSXB78oTQKjxgmmTElr5egKaz8c75MeSjeo041jZKpYGriE7/9q7zUhOo9zVBo3ppq/lsKx9e0JRfh8dWFNXhAFPLe2GZVMP3j4ec71DMry1d8
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:eOPYEJfVyIesowRHrguSD4YO+VNED2U7jinGNknSKPisnbB24Bh9n4J1yqYEAQ8AtodkQwn8PRv5PFW0DloGOuSXRWd5o3heY5cfewXTt0JvSclgcKPaf3SwjfHHWOr+gwbf9ADLRTHSLP6l9MXUEpu9oOi/2nLpS2msrzcoAq3omwR9KreeXAc6xDF2ANQalE1bWY1o6OHADjq1ZtVMIhYAZkyqjF4pR0AlfqgAOYLFY9NKdzBdXIk2jnZMJl1dPmduv+Y9zYmCLLUDzhuQvuAq0yv62VqnvuXzv+iyudd5YYlI05ecTeyX0T0CoHWmCzx8edyY91t0MnjKQY+/qt5bC8Pe9eVso7pAEQQxzi0wmnWArODYE/ZH6Z9eSWuHwsPmampQ4P0tngtlGU9brZKw6D5rEJ2YBzofHyTOM94zBBwv+1ZfS81C9NJrB7wnfgFeuTet5/gDKDaf3y4doA==;5:3y6FZ+0tVtBshfCO6w6Y07BRJ25Yr/F1APq6QPvf3fdqkZIgGQSm/JD45CQWtZ4+q1TvFS+eMT7k8STsXOFxVWslQqaV3c/sDVCOduxskndZ0K8PYOLApDzoc6mwqEPsntJICz+4SfNmuK6qWQOFFbWkMZljvfhTF0ukqlFO2Kg=;24:60B2Czcmf5M79LOULfw12bw+91nn4cr9imJxQt/5uUxeztGbW9Hq6d7fygT/32iVUB1Pn8LP59xzCmcgPL2X96lBbLPqSRRU2uS3ynpzggg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:yB5HSKA2wK6F3o52DeNjVSLEqKRtPbUyQF25bMW+V4+DBbdytGwVboAONpAJx4hOl/rVjDhaIWfYO1SQ37hd3JYlQGs86TJnuuCVxd7Y4MaMGQGU1X1BeMDLHll1yxU4QvaRQGbgqD8dAFevNODHgsrBkuJCHGpo2w2Vnr3LCOIH9t5SBONZkZPPqaQIG0tBrspGrjvDj4MpNZ1RbQH0dYzixPjQgxh/QCWvIHzcTIrolJBk0BfzpGYKs3YiQEc/
X-MS-Office365-Filtering-Correlation-Id: e4553905-6ff1-47ee-2a41-08d5ac0cd98d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:02:29.1971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4553905-6ff1-47ee-2a41-08d5ac0cd98d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a debug LED(D11) connected to GPIO1_IO24, add
support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
this patch is based on patch series (ARM: dts: imx6sx-sabreauto: add wdog external reset support).
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index eb1452c..6b94f24 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,18 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -119,6 +131,12 @@
 &iomuxc {
 	imx6x-sabreauto {
 
+		pinctrl_led: ledgrp {
+			fsl,pins = <
+				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
+			>;
+		};
+
 		pinctrl_enet1_1: enet1grp-1 {
 			fsl,pins = <
 				MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
-- 
2.7.4
