Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeBTLz5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:55:57 -0500
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:9376
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751435AbeBTLzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:55:52 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH 1/2] ASoC: ak4458: Modify SPDX license format
Date: Tue, 20 Feb 2018 10:56:07 +0200
Message-ID: <1519116968-31759-2-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
References: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131636013437764458;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(36756003)(16586007)(54906003)(110136005)(47776003)(316002)(450100002)(51416003)(50226002)(105606002)(76176011)(8936002)(81156014)(956003)(81166006)(104016004)(26005)(97736004)(8676002)(336011)(106466001)(305945005)(68736007)(86362001)(2201001)(356003)(50466002)(48376002)(2906002)(4326008)(26826003)(5660300001)(498600001)(85426001)(6666003)(53936002)(2950100002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB476;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD010;1:zj64KwlqUqBmwoU2EsXQwGjZRVnOfly0ejVPHD+s3G2LlL3O9uHa2XZoE+3PU2TnNojD7EoJd2x3zvLiBobsQ6Gjuc+Y/rejzr6ZqdH+eNfVrmzbfCaNBclxKJKz2Ywu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f104f5-684f-44f2-75a0-08d57858defa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY2PR03MB476;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB476;3:XufvLUzEtQ9LPnWrzB50eDBemDOToFxAUNB2/9Dxw+oxG137D4nXCWkSRvDHI1hiyNdDvDhMyG9MIPepB9nEToWoOck8y/tvdAi99X1DEk9k9PnSBpNxqeTn/IbADv0uOLpTCat0vUY6to7fU1D9lFdHfj7cWDrMMFA6N4XUUUaGUtdWUVFKCfKZemt4IDJyUMVyS6J5Qo+m4hyy9WIG+GKvP5WdU5MzEqopxavmj9lQZ7NWY0Y866iuZ8M5z3/VuQ1bqv86dqaQa4QqHfkg1MZKbLyjdQHKls2Y7TTPdTkVcZy+zeRopYb4TP0U5u17tnwn6bQT6pViUVvb3FJMi2HUB7VamImMobco6d2tI7Q=;25:wm4/WgY0CcMsrFqlf9MjmSvvNuw5iSt/Ab4S4LbtFrW8DE7az5wffyZTv5o1NFfkV7Hu0uw3wVFvOVQYeVrG2H69IaJY6Fp0Ya1Xe9NmFpa7u0acZcV+cROYhnW0246SJUwOGxGbuv465UuVIft+U24EOnxVXkwwg0l6+oVjlmtyD4cK2mR3kGRuaS13oMSZnLoyFga4xhwpO4UhRxo2I4Q2AsY49U3k/URmLdC33Tn2vas+RkjfC2cSHi8SKi9Icjzqs/nwTF1bHDT1fUY3STc7ckgQrdUeYSyDxfwsP93EEZ86iYeVHTJM8z9lprXeFrC2uRQ8ss9xH6mT6rn81g==
X-MS-TrafficTypeDiagnostic: BY2PR03MB476:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB476;31:2YiuehSTYpQhjAtfQnU+NfEAq+GI+ARrQjFcRSqe8uMYMAbTA0TEYJArlqVNf+wA+sk4EpS0Qu9Y5Z07Uxk9JNcLa4bFrCCJ8ijOKTFjny06OIbjT1b8Rx+qLdnCv9eIVFSiHhLi8I1qkRqdfJZF9xDoyu6o9U0+2alESb7Z/kkmQzMDIeW3tjctWYneh9kbgqiumnJ2NYH27+W7t2X/aUaeqA3AfIthr9cpyLNtfbE=;4:Sz7tNWhxCnU2G51cSM+ysEALN2aBYby8/Df5ARu0NwxZSpb2zZdDvm4KNiE+XWSZ5E93jkevnw19KC1z3lQFYMEmRadvrj5vJkekhPz6Ly4EJEfSs6tx2h8awk/MXgGEzbc1K/N81+mqSm8CVlyusKkpfo5veBV9M4gdA6rm2EmRkb7x4tbXd/WMN0AxF8EM6Pesh9MseNGL95HAnlwPWJjy5KMBulJZw1kQtS9PyAca9VhCNb7hf7HqFl8wY0SEMyz5WkqYt2hqUqjDg/mUEXQdcRitAkoBsdDqZQYOOIMgsCtimbXsNamVG/C79AqV
X-Microsoft-Antispam-PRVS: <BY2PR03MB476210A0012CD514C73CA0B9CCF0@BY2PR03MB476.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(93006095)(93001095)(10201501046)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(20161123563025)(20161123565025)(20161123561025)(201708071742011);SRVR:BY2PR03MB476;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR03MB476;
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB476;23:m1TbrEM895/bBGZ+KtO6SIzBhYsK3wKuM12tguzyho?=
 =?us-ascii?Q?hZFgXBca3DopLZjiTYtg3SoE8teEGP4cviJaRmJUx0QyBBzOsfXPrrRRQRgq?=
 =?us-ascii?Q?DwbyP2trM6DvwEG9Vg2iz9efqME/DxBeHctYXiPel/VvBFgvvGx39X2aY3wv?=
 =?us-ascii?Q?No2JMWxJgfrzuQJptuzv4zbkndYFwSsIm8HRfxh3MstP3Lr5oh3TX5x/cUIM?=
 =?us-ascii?Q?8n6Un6nWv8P3jmg2scZzvWWbttUYOQgWb99Mt5RJoTKY+YDEVikQoJW22kw0?=
 =?us-ascii?Q?oNQrIYG9Sw4cpHzdYHKbNnqFwDF1QQLbBejTTwi3dwsywlwQmp7kt9rnogyy?=
 =?us-ascii?Q?G/6nbD8WcjnxSQVm00sV820RG4QkoZtGiDpqOYAaGRhXxvEWs8ki+NPE6crc?=
 =?us-ascii?Q?+kHXwvYVkF98xu8ulPM2cmYq7VJHRBOVlobUf0vTHeQnzw/wLLJfoXhkOZvi?=
 =?us-ascii?Q?1XGuv1NYhzPaqVUsQUn1tOi5TAZc+U85uFzGUcVAkah7ivSfLIKWvtw8l5Ns?=
 =?us-ascii?Q?zf+ScUt/C2/6G9CsSjIZ7eXjbDVbEj2Gwuw8aBZJBTpEjr/cAPrWhY9UiFRF?=
 =?us-ascii?Q?EloBYr9asoxzrOvEeaA569iT+laaqbSXTZue0jLqk00MW+KpuQNqar1v6b/i?=
 =?us-ascii?Q?KBWhEaxpzLtYuB5djoSOb+gWjVhdNTOLjN8fGexucxtX5vclOIhDuORcA+lL?=
 =?us-ascii?Q?mkvQ4O+7SWBmE9EpnSV4Ss5FnH9TOiAD0fmTAZehrbuGwG1g6naXJv2O7d/X?=
 =?us-ascii?Q?HLwIsyA2EcyCGAZ3UuhymdEKwfVNxrJjG6ByEjAADXWuPe9bk0cyPHzqFVxR?=
 =?us-ascii?Q?H3vznjXfm7ACTBTHpkhrBhGrtvXC7QNm0J370uYb+2btzlvwXctIIQM+4nrs?=
 =?us-ascii?Q?ogPtmFvJjt3ziG6h4UWdoDttn/YXnUzoZph6wUbMtxYCUh5HSDYWr3OcVwTU?=
 =?us-ascii?Q?DU/2HAPCHMMJMU1N8xbixBg66bTrFeDev+V8jTmYJV/YxvFXULwvvRvKAXWA?=
 =?us-ascii?Q?b+yCTrnryKPn5B+KYI24G+avucj/beYXXehF6JybHJ6xKcdK8RFipaUvCBrl?=
 =?us-ascii?Q?A9lu4cpLL+ClCIqgoDzN3GBq1GE1p+wNpHf7cC17gRZQsF5kbmpU1pZ5mjgb?=
 =?us-ascii?Q?Va5UTpUJvnUr+gBwrhDSFubSQSJSbG?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB476;6:3amH6f5MTDvwxbeMyR0DvhD9Ula+dfewlVd2S/SbgZgADnl47S01l37ic90U7FXobl9bKAizE/YGZtK8yU5WBLOFvERhDc5X+ODCjkMjzII7CxVHmArY6zN9txGX44KGVRbDjW4HN6zI1ZzJaruyaDltKIxDf60j8hQpXb134lwYmVW5qkrsyo1wDwo1Yj7/I2NC7+9IU+yaHApUbmEcJUz7v/otryGHWWAK8e9X0+ObSFo7RdR7SCsA2/FOkwD0OUHA6+/BHbBTvWyexrJnQuSg4NvjJs2N16f1NM6XtJyuvLzFrL5OAgw1xidyB+oUm61DebH2pBlTj0HSVdPw0Ai3lgyjbpvPf0+jC0zIQ6k=;5:I8UColHLpzbqz5Pq+mM/ShUkPzNdJ23RvVtJYRliSUxcAz7vvThO3K1w8TEPAATDRICpODqA8BCxy72w5rpUHxazOdG1B/uAw762fsDlhhTOLI3D4OXfHgCUw/DQruWB64vo/s8PGeMRbtt06bOCAEkevJAXK1mlZv3PgUq9m9E=;24:Nch36+JD/nEp2jWkQq3uQnxQ9OEdXnxOiEBuqqTd7tESaWa1nnBLcJRHkNbX3xnO6Dsc37tvIcMQFx+rGxfmxpno7q88P1KqWh8KcwM3wws=;7:k0HCsZflcs/MJjRoBz6d7eb8K0FOU2V7wKgf3kuzc7RMS9q+UC0KATH9gaSK80xdHnB2YRrSDRDyqghkzOFeH63r/g9uHSbGWfVJoU5dnJhHvY66HP59UCUhVxC38fJMLqiKAHP2ge6KfIjhXiZlYMGUqGGS5HXBYCERxu5GA8DGZULtfAyHabt6nQdHDJQkh/bTqDTOyXEbdWj5f0eJWrI49QGjhH8UW4USDEElUW04tuGdt2wSENE+jHC/McaK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 11:55:43.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f104f5-684f-44f2-75a0-08d57858defa
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB476
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify SPDX comment style to match the rules. Since the original
code had a GPL-2.0 license and SPDX is compatible with GPL-2.0+,
we also modified the MODULE_LICENSE.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 sound/soc/codecs/ak4458.c | 13 ++++++-------
 sound/soc/codecs/ak4458.h |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index d2815ac..8a49dd2 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Audio driver for AK4458 DAC
- *
- * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
- * Copyright 2018 NXP
- */
+//
+// Audio driver for AK4458 DAC
+//
+// Copyright (C) 2016 Asahi Kasei Microdevices Corporation
+// Copyright 2018 NXP
 
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -655,4 +654,4 @@ module_i2c_driver(ak4458_i2c_driver);
 MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
 MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
 MODULE_DESCRIPTION("ASoC AK4458 DAC driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/ak4458.h b/sound/soc/codecs/ak4458.h
index 16d9d22..f906215 100644
--- a/sound/soc/codecs/ak4458.h
+++ b/sound/soc/codecs/ak4458.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Audio driver for AK4458
  *
-- 
2.7.4
