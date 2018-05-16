Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEPC3j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:29:39 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:32096
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbeEPC3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:29:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx7d: correct cpu supply name for voltage scaling
Date: Wed, 16 May 2018 10:25:48 +0800
Message-Id: <1526437548-32372-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:YU/fXh/ufDT6DMItjHwjJiiZCN2ZR7r8+CjkqCWfLMzdLdwzCtGGderDwomr+fKN/K3vClaCblbpKT4s/vQ2Due2KNG+mta3xhTn1TViFROliGNZhb8eyDMWMpjc0WXdrmZZ398Cb19XfL1kmo9QOQlxFsUqHWwL0ilQKio9BHX/LB7fG7VkgfzIbdUeGz4vhuq8MPT65EX1EcBZPsVGm5FnTpWYMveREbGbsgbaQ8Q0W/hQ6jSPYny5OghtRz3d;25:cMhTR5Fc3cX1JdZ1XaG6zlapElK+A5wSDshZflkXTny56Xb1NOtfdioAGxpimIyGL4OLdlcAmRK8PGVm5im23wOzn6fgPHkYdk05po6unuedLjoXEY+rIsfXhaIEMVw6VI14vqjLxS7wl9/aa88Uj+aE5fFlAMk0kf6c9vLb1DovPkIpD/BZg8v9zMw3EKve7TSPQvivErRc1QjY44/bT1DfBEVpUHNi/VZrCbX41T3rJxKGT35xd2zG7ZwX/8qQdlXyPso+/V+5+h3uzAqW2tJTh/aCmpTX/xI/F4lGf4QrR6eFnb92wRToStmaTLSRrfUB/fCdjwv7Co3sUMps5g==;31:EwmPakLITvgRUosGkWAph84QB4ijdskaXVIavvy6Fy8rnpmRE97Fei3pUePx5Ju97zsjAaYczCsB3F7i1fxfEOtP2XiRHH88B6e0fOm4dpdMiG+iF4ru5X7cuplnLlXG+66hQfX/c36R6rTXBKSnSQobYdSjM0l3amgxDxffcsgapFpRS4u94aKz5RjfRj+wokMgG8/szks8suTOfnC0NlGUmUH74IkbbkLUBj8hoAQ=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:iY+y8svJOaIr0lEFlExNpBYklsFSc1P5lOVVxAwvp01dK55lzO5j7Ws+RpygFdLYdWa/eVkGi3xWxHlXqHJhIV/9EnewnHKzikqMZuGDJLem6p0IXC9PEOXokKEJEDJEA8QXydEW0L2gnXDaw1w96UZ0DRCaUJxUbqDwaKkiyDsWK3gg6b6ScfngLALZZ916Ql3IoGgarcgN8vwISX8QQdb/xNL2dyR1A62QQfGSG1D6oqlVTJaaswSOFBhfm8qm9T2Szd8+lsjzr3e1jBy5MJh49EzqTb/jWWrb5QaXgKIpDQ6knvaqz7oIXoFMmFmmlTL3PlBbKfa0c/lUci7WETO4jSexwMNMhZR4RliWYlBYgVcwdPc0hacu5y8y0uuD+4yVtasraoKnmeHYEi8dkBLg7Om42UeDSqsPIkfPjmrjSxwacKwmz1nrqpE07Lc0NP3vhAB1Fe41A4qndhUs5sKLfo5R8lBH+0iYxPgI4jaMcsdBzSp/61wXFcuzPlO7;4:6neUPFMyvW3+oH2r2N9SJGANzjdV61KJGxhlho6TrU52oZD52xhcwtqze1vUXkyzP+9XJv8/RSWTqirMXK2io6aJJgbctW01zdHTrjgFQc9GVEXexamO5oI2d+X6rOCSBK1I5r2nswOP2z29y0jgoBN3tQEFlDYVXTXqLuB8xS1ozMgQv9EF52CNTGTP/XIT1viPVC1nRNuEeJRUF9TqtSGyLFPP/qX6PhBvLTqpaEFPZkKh5aJrFIi5o2y6B0+XudAdbzK2WQvklPolChWlzHe8Rn5a/J7XPuvEaKaT14Y17VSpr6LQ4hR+qZhqB2zv
X-Microsoft-Antispam-PRVS: <VI1PR04MB132640FFE57B62CF4E4C0F1FF5920@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(199004)(189003)(2906002)(4326008)(66066001)(5660300001)(47776003)(105586002)(106356001)(36756003)(81156014)(6116002)(3846002)(50226002)(6486002)(25786009)(50466002)(48376002)(81166006)(316002)(8936002)(8676002)(16586007)(305945005)(478600001)(68736007)(7736002)(6506007)(51416003)(53936002)(86362001)(386003)(52116002)(6512007)(2616005)(486006)(476003)(26005)(97736004)(956004)(186003)(16526019)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:hgGBkjo6TEkBWcTHfPFJGNYMTLexspfHHLXD5mIcD?=
 =?us-ascii?Q?1qMxR3AsUNisbTi9xiVSSn3q1y3STD8xkQFRBynJpPBpRM/CEcqdCYTTzc6g?=
 =?us-ascii?Q?bjAtX7Mx/WkLUSKnTTBmhe1k1Hfhk1z9dRQBtPsRmRKdd3XXG1rAvXWk4x4D?=
 =?us-ascii?Q?TKmhFjuoI0jtcRLy6KwxRkCmr16aqG56r0sUnkRX8mahIMEUuVqfgI1MELab?=
 =?us-ascii?Q?RFxenFA5oNWLbhxGA6j4h6M2Whvt096AZJiZfxNh3f94nKsU6Ltcdob3AXN5?=
 =?us-ascii?Q?ZDXicv1lxgcscn5ezNggUNX4I0H8EQ4Cs/+OO3vu1LhYUE1qvLgHiIuvocKt?=
 =?us-ascii?Q?mDel+wG5UHTOP8ui/dFM51FwhpowqU2Tgw5azVebj8N1Y1JIji3kOIGARLIr?=
 =?us-ascii?Q?hcyRS87qlhFO0MRUNEwufhVHOHuHPApocv/qwRLAfZT5/n9AzrPvnKL0CmEU?=
 =?us-ascii?Q?/q7fqnioskziWH3CvWsK2NUUwrh4M/qM2lRZAFXD7I8gbKpxZqorB+U76EBb?=
 =?us-ascii?Q?MxM5B68VnQM430hy/paNuMcNNuF0FhRQgPMZB5UkOsqEiHpAaw7RuVicyY32?=
 =?us-ascii?Q?0P6nvf1Vc5UGqZIXgmJbhkWu/lIbjxpZp+leBeZz60abah+Tmb2mUuilBIDZ?=
 =?us-ascii?Q?+mRYk6KTVGfaadZAPOK0j3K9L0X6klQxeLefQJoA0faUhKkDRBwv6b4JSzl8?=
 =?us-ascii?Q?AyrGG9QyL0GKfUTEQF6U6XuLDm+VoLYgtTpc+z86JGDhveIBaD7VK5LsgSdX?=
 =?us-ascii?Q?1F7aEsbkobTkZjKPoW4WhEbntnQSvMTns8tuJ3EzfSS+90u/PLotNWkjEB2j?=
 =?us-ascii?Q?drbG3bBk6+NCv73fDVUspVwAr00ohIMD7sD32lTg0PUbtMGA4DSUkBqOufad?=
 =?us-ascii?Q?JSzmHgIg/vtWopmmQhpn0aNHfHJczr8trCDHknVRQL2mzL4QmnK3pGwQo/fR?=
 =?us-ascii?Q?Zd32f0nprwjIhkS9c9At8qgGE9/h1wpVKmM3Im/WqEsNGkEp55IyhX6SYM82?=
 =?us-ascii?Q?XDgMSxuyNKaBZZpAmpT5ZJQPpx2Ip1wjWk2/XGUrUXpghAeK8XgzFouPN/ov?=
 =?us-ascii?Q?XeePepZf69EFdxvaThLdmiAI/6FMT7Z11vfgvzUHrYwzXvkdg=3D=3D?=
X-Microsoft-Antispam-Message-Info: eoZVq9XWUVkNVcZeENFAiDsYhUNZbXOQwNLULwX6SWqe5EJPwdXm2LiQGxq/zjvEOB54CwARqUuzBbwAe8qBjLJ/EwqIPtdPYEWMrrZKoFwskhbZkiGrNLzx26nYyEsbxbXQzlRk4VnZDxt9WAxcBZ5zOlAWrfY19dptK0T1iHVa2ZprWDhSqofk6bltaSOX
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:wV9mqhkdZccfjGJNRj0sx4K+yh7q6aVdc5k6cnoBIW1iqsqxXTgz51DffMekiIpXoJMUcAsM2mEk6m98n6tj+ZDOfKIctPSEJ8lLGHXwtun2R1BQaWWKn5zcCMMJsHmDkyYGaW1MJf3oMnZGBDnZuyuX6iY1mZ08rian3trousogur26aA68qSJGA3NfjD0FlH/8lyVJhqRv1PemO6rl1bESLUKhngkKowJTZ34n7AzkRhhNn2B7i1UOp9MkNlgQXl+bDBzogejx5WSxt8dcoO85tuHuYgdhX72uLmRVSDLXjUIwBwN0WHrIJ/1wQG8rZqRMgu9fTGhXFX3QO9//jf9mS+LUPKTUxYc13HILBUMc/rwb021DpSEs+maWRdtTcZqrXQt64rKYUUKRnfcOIgZs0cJRED7cpMfRdUPpVWF6qTYQMgTeI9DpKqy8yhNVnzUIZkANSjwawB1kMMTvrA==;5:CasPRSercjBFQ37VvgZC8mAmYm/5qSc544yTK5Mfwrn5tcRJ/5nh2wbkdJAvTINIqyuxhzfM1BFSrXu3o8BEtfOtVnWQ2QeYT89Ccsd6SPefN3D2O6VjnSyhTt9KUfqtQEQeItqeRi+NWQT7mj2GVpOS9up2YtLMe1J9C85aNyc=;24:9N4lAgQMN+OtqQBs+8BAJntHI9iiApnS1wybntLxXKcZyKjGsgQG0n+rQgXZrlb4OqXqUwoN7UvqsU7SKG5S66zkYYOrbBUJx9yf/BRU+Ag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:8wetIIV120wAZ+3z2TngemNl1YsUTfTUOBzPvaix4ksjGTytHYFy93XyVttmPFccD+Zx+P4+YG6beK1D6Nh342C8DALb1V6PjqPuAIgEUGMjb7yqtFkENjNorjuvoN3+egaZJXwzo3xfaRGCDLuMWsoIBU/6XhcY4ugbuVQKPOuTmPF8WPM/VBUwBVoYrEE9e3/NBEsHvWPORU4S2ZWP0wGPGjOzqi1YlvMr/geb8r0r+1HFJ4fPspe6QSm9AHOR
X-MS-Office365-Filtering-Correlation-Id: 354b25fe-780c-4db1-eb7d-08d5bad4dc03
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 02:29:27.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b25fe-780c-4db1-eb7d-08d5bad4dc03
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct CPU supply name to meet cpufreq-dt driver's
requirement for voltage scaling.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V1:
	fix the "No newline at end of file" caused by vim editor.
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 7f64568..8bf365d 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -33,7 +33,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &fec1 {
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index b8e73b4..70c53e5 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -144,7 +144,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &fec1 {
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 722a45a..9408491 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -141,7 +141,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &ecspi3 {
-- 
2.7.4
