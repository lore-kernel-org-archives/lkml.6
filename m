Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeFCBr5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:47:57 -0400
Received: from mail-he1eur01on0046.outbound.protection.outlook.com ([104.47.0.46]:46880
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750991AbeFCBrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:47:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, michael@amarulasolutions.com,
        matteo.lisi@engicam.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Date: Sun,  3 Jun 2018 09:44:05 +0800
Message-Id: <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:EJ8Ow/NVtG/87GxLoh/07OA0wSTkbS+4A3cJePTycGbxzOkk8d083mmzdgJjVgv5NdTGeNZJ1Y5sPdPPWoxRrl5t6pgLmZd7UBqDbuw4wLQS3u2TnshK/LnjwiDQCVex5xmUYY2L8MnJYym5xa9Etg/iUi8vWJV19Mc3fGeUNpMwAUImTGtowm/f6UWwqyjK7kSJ14GSLvPmrWb4RWfJCtD8kKMwU8FlAgE+/EEnGOK2Qlj2Z3t41bSSQaCew6Cs;25:fKMj0TYg0TfQqrXMvRXvLb20jTw8JSrmaKk+lTw/6RbxLZEHsBDebqgdPeEX2c2mzqsSs8XLNyinncEaMLz83rkUQA6rMqrrTCvJrMnHfpwfyfQz+9dp8emlXJtn9NmbkbGumfJoAoarHB1aTBU3GJAkMfA27YNSmNnVuxl2uzQup+g6N//1TZ3Fq8OLGpZZ7U+v6lUkSR1VmHm0z8VMad+Pw6Z8wiKrRB82RX5s+QHWQ/VvJFuvppao9AKWIQVYhfzZhIxop6y5SJvIjVTn3mnVMNYXY7i2oSze6euko0UedNrGbyKXpXn1JIJ0PgrJHjlEeGSMbzhiueE7btYmrg==;31:BJWR41LHxwNmUqLswYc7myLifQRU5wLOQSrf0aNPLddcQlRPld/fVUYdx9P+nA43zhIu+y3dynqcXOAv8IvOS7QE5vaBrxYvPFDujUAf9esBCjMCsQ9koyKD1Vz9Uy5YU05qmxKlmwqlrP5y3hYNt0FfBGbCK3XE121tg86PHxti2kKMhlG63KIjMKJqNaIjQIymDJK9b7Luiq3tkEMqoBQsndP/DCGuJyGzTpXn/bI=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:1jm1hDGxN7s1dHVU+RXE5Xjij/Y17wyTW+vyyNP9a4vvfFqxS0Pqy6Eu1fowC3+WX8Gzo5oHpD67/4//vh8TJ4Ig/dLRWC/Te5JoEarVrNmbvlA6q52FMIieOja3MlIgYNTTEKTEDzTtG6XCirF5j7WFswaaDhsG+6sNInuCxKunzfJjiiZ4EcKg9hIBICP+mSIPfv48HHMQ2/q24ZRy6iAjMRrqDMt6FPN0+3ujnWV9oFE2YuqWrp7Tj7OKiF8nywJMghKG76hSAa7JKIgvg0tn1e1aeLJ7eB3OYT5KV88/XUJsGoEicWzOu/hEZlofqJzBJ6xck9t+Mj9c30pJi/soOYzTdqEBZNuAlcFBh2ab4NZEb4ppB9aa0TJ2B+f1ZD/czprT9ULIYnCHELzVVuexpXK60oXaSK89sEL+7S2SXER/scZCFy9YwW36wWVppp71tmtdf5VnZ09T7fyNzZX0uxSyEUIXha/D16DGQMpIvLYxK+MhcPUkhzqTa/7V;4:0BDbULtGNcoUMu+V3n0KT3nvrKTpf7f0l4GZf6AJY2LYwuA26VnELgKPV7tsPVgCga7NIEnMIJIOw5AvU3gigAmwcMbk1UvDoZiRQvhirsCW7+on8dw0xl5pDik5TJSXzqCe/H0GYMQjZrm91B5psXv7lVGaLsqwca7yuwYyuaIKmCoDcZGGjLcrfjOztnjCQoIG1O3jiKOpiWjeT0q5NvKYF5DydDISdvPVb1SDLsET6M/FSV9KmaHxuRwNNUABrA//RFCh0rJgw0E2nqt5vgvIbAG90bsl6Q5nl0B4yOtOf2yfz21e91yNkxKLcjER
X-Microsoft-Antispam-PRVS: <DB5PR04MB1320F584DAB737BAA94D97A4F5600@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 069255B8B8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(39380400002)(396003)(199004)(189003)(76176011)(8936002)(305945005)(36756003)(16586007)(81156014)(81166006)(8676002)(6486002)(7736002)(53936002)(316002)(6116002)(25786009)(7416002)(48376002)(50466002)(68736007)(3846002)(50226002)(97736004)(86362001)(446003)(11346002)(2616005)(47776003)(956004)(2906002)(6506007)(52116002)(476003)(106356001)(51416003)(4326008)(6666003)(26005)(5660300001)(386003)(105586002)(486006)(186003)(66066001)(478600001)(6512007)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:E31H+IxJvJzYMQDk1y2/iDDs6UhmzqJBlNrODKlwc?=
 =?us-ascii?Q?5M/74YSZlZhvD1H3dU0jHOv/gdFa/eLXR7u89Krzi//n8fOpXC6af1TA/viy?=
 =?us-ascii?Q?+foA3jNVeLCOw9SlEAVIhbOEasQMlaGFcjvKr5Hp/vtEU2nCQQ6ZMUevlTQ1?=
 =?us-ascii?Q?f2F+5el5R8IAMi838MhMpWQiFIaJiypFUIVsyNblZ54tvIW+qC0NkLAQ8gNg?=
 =?us-ascii?Q?EDkaVGh0V0DNimx4VfI4rXsLtxFAyMmfjYKUeKuxss196lsjEsFsudNwWrYV?=
 =?us-ascii?Q?ep88qn3pL0Os3sqRU+jEdf7Z9BXJXINn4Z+QxiMpMK0LTcG/7ji0mwnSzPVz?=
 =?us-ascii?Q?HzrGiw3ZemW4jzoVFsYd2faYEP47/P5gs3j895R9g3D3wf9wobd0jL42oaIa?=
 =?us-ascii?Q?KQ42UMlnlwK6glMq+EdlPZlmCd8dEJiJg/tIXT9vtiiSqzznMqH9XOxWpBDt?=
 =?us-ascii?Q?BwXygOvGtneHBZ9yk8umAbXIDlqCWmMlEFmLMetexLPSKwKav+Ui8NsWJGtH?=
 =?us-ascii?Q?GDwZNF4+j3ODBbcDDyo7cexx1cNbL9Cb8CrMZQCsRdx7sAaPEi7HgGEeO6gx?=
 =?us-ascii?Q?JgCdijaVtI5t1dBtG9tHZOCfCCvZVFRlDDYwUhUQrrGawHld+n/ER4ZTVP27?=
 =?us-ascii?Q?j6kMthekI4v/1ynpe0YrXTgSK53rCfE+ISUdmuLJqLQ8wM+xKM5CUdz/3UCJ?=
 =?us-ascii?Q?VDp1uY0uPnboH/QPdSK0XCDm/YuGYj3ymg4zhmQO4laE5LoEKauYZjAnKDSh?=
 =?us-ascii?Q?WwqadtUW9YAhDRQQXMB/ThMYo/pxZHhJA4IesXZJtetndySC4BW+cpwBmBQ3?=
 =?us-ascii?Q?FN4lipNWGgE2kRkWfQE8FzpYZDuroT0jDoOnQfG2jYdGr9ckg8WmMvqfr6Rm?=
 =?us-ascii?Q?cc98xGy/oIfNVWJY0D9yLeIST+FxphtHRuLaa9vMzDBBxlawl+5kCDg+GlIK?=
 =?us-ascii?Q?SIhCtoPEWejKOY1lH47bw12D7dOPY/N3Sp3DlJiLmjV8EB64r3agy+QI+QQ1?=
 =?us-ascii?Q?7TKjTW9sX1qYOQ9rwynx/azPjN99614kwUGHgqfTh67iZtQleuwsd9OVSSzE?=
 =?us-ascii?Q?bsfatEdkTLSfnFQAtMY3yUV8rkxxCXheFQZcAr7kMGeKHf8sfNg2xLjTFnM7?=
 =?us-ascii?Q?EM9KdZS7HEXqUfC+6oq9IP5yVZ+07SanoSQViZbmI15zZdLoatSUVqzC/vkd?=
 =?us-ascii?Q?Ex8gYIze1GFdrwhhRhIBwApuGnjiR7+Mii7?=
X-Microsoft-Antispam-Message-Info: CaSN7/2dX7Z4w0jthmtXFg0oX752CmTlFZUJLqS77h3enTTZfSqa40jF/SEx5RR0MEBkyL9KdScxAQ+pTjd2AamesrMSFBMoHa2n3aGQAtgFF58HQr2iGvzomXtGCiZXKsMojkch4ms1aFygdQE8SL10b06vR1Fg2F0c1isFh1z6EJcZGcSB0F+slv1TRqJd
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:sfKD+HV/2Y+PGHo2q9b1/UPk5icOBIMjbmBwne/MTC25F6avh3oqVXftVJvMgJHFVw0HTGKoACMYtETgjDO7rlX0PhpsE9vrsjmfMb9MjSwQLKTp8FG6mgkMEq2Ymf8fBG9TTwEj857WEi3SAWeNlPbOQBL3BYBuiuWIMR3mfNdyalJNVNVIhCVLISHL/mDbt6SjnPVeRGyOXeNdaBmVyAow+mXI8GnOJebJFtPbV/KH9t41/SepyzXtTpTbOyByjZQLC7Pyhvxi/Pn+/Pz1gzZsD9A7ztL+vPK/7vLDkMC5kcrIoe9lBRWXlvrjNWMtBnPxSu5OaxeeBQ1Di5gcSSQaI2r5SSACgqNw3U4YFOpUJF+8i10RmUef+iWbMQvPw3z0reOppZakguXJEFo73vJc/8VNWpInp1xcTrm0HDP/hYohlI+y9mh8hd623/wbg3/COxjkm8K5i7lWdCV6mQ==;5:D0yP5Xkk1ZZwl+c3x6fvTl/CPZpN1wFlm+QKvVNQY4uiXkeBH5+NYVokjVu/Wo/VC04Zaz5J/nK6D0eP8Nplt9ymO+OaY6tMAM5zQZtkMmO1Qk/C0u3nHH23w7huyZQ7fUnLqZIVsEkoKQTfknw8C9oMuVY20f9VfXSN3V2hosQ=;24:D0zIo1woeuxVMK2G+JxemJLIm4LdRrjxZE+MUwu9v0ppO2olsJye5oJ2gxfWYbk6O6FjkWndVZhqAcJE174XLE+sI/KzPMxhJPsmBCj0OpY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:YDzj/9/N2Z4KX1oQNrtpq/dX8PPFEEL31EaawTKDbDyGvc19Y0NXWELCX+onoxl1zAnshdUFLrTpQGxndi0btQHXFjFvdjJ7Tw/uZTUAo8kGlX8DYZKfP0XX97KjKXlxoGChFwIkM3Dc3I23lgCJ+s1EEEABjbh6tJqcXZri6W1SdXpCDvX7uOfKdtKG3NoVI1CRcbDaforEZucR7IAy5/twa1yNbOCLkRszbsWwVo0bA1s9d4bqLMurBb9Uvhbl
X-MS-Office365-Filtering-Correlation-Id: 0a31b571-03c1-4c58-59b7-08d5c8f402dc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2018 01:47:44.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a31b571-03c1-4c58-59b7-08d5c8f402dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL has GPIO clock gates in CCM CCGR, add
clock property for GPIO driver to make sure all
GPIO banks work as expected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	no changes since V1.
 arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..405e068 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -437,6 +437,7 @@
 				reg = <0x0209c000 0x4000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO1>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -450,6 +451,7 @@
 				reg = <0x020a0000 0x4000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO2>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -462,6 +464,7 @@
 				reg = <0x020a4000 0x4000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO3>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -474,6 +477,7 @@
 				reg = <0x020a8000 0x4000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO4>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -486,6 +490,7 @@
 				reg = <0x020ac000 0x4000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPIO5>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4
