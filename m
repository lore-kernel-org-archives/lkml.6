Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBTLzu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:55:50 -0500
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:27376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751435AbeBTLzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:55:45 -0500
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
Subject: [PATCH 2/2] ASoC: ak4458: Sort headers alphabetically
Date: Tue, 20 Feb 2018 10:56:08 +0200
Message-ID: <1519116968-31759-3-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
References: <1519116968-31759-1-git-send-email-cosmin.samoila@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131636013430144854;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(8676002)(104016004)(26826003)(498600001)(51416003)(26005)(81156014)(106466001)(5660300001)(956003)(81166006)(76176011)(8936002)(50466002)(47776003)(48376002)(336011)(36756003)(86362001)(356003)(575784001)(54906003)(316002)(16586007)(105606002)(450100002)(110136005)(6666003)(2201001)(4326008)(305945005)(2950100002)(53936002)(97736004)(50226002)(2906002)(85426001)(68736007)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1414;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD029;1:QDsBxpa329RCklPrf15fhWBLRqf2JDkjbGE9UvBIGIxhrhrWG3fH1T148DhMfflUyY5+chAD+1geNQus9FItb8Z2SAWFvYSzzuF755kxDmMDyD25GHj8BYpl/EvOdiTq
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbae52f2-e485-4bed-ff56-08d57858de9d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR03MB1414;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;3:99u2ps/UnTWfB1w8TWYKYQktd0sP0Y/6VVQq2tONwa6GqmpH/sqJKt4M344wrznon+9IT4Nx31RI9chU56E7r29eyqsbRvPtCHudPZkx5K98265F9AoLKTG6/qaBfj5pikFqf6aGmoWXmic6AKD2UXAvj5h24vMNWkCnSkLEZ5HvHfzSuoawKrhkvDTLjU5vMtCG6vcDAP/Q5OfXjAPTkjPFE1bHHXGddHEgqyvQ/EUrG2ZFXv2YdYTt1rUqmxV387NImErxXIyI8f7ZoonVFwFCteNBqhJM0gtdA9Ok7ZT2/D5VIL1ghIKBNnHTOJyJoClUZSkLn2OPcbfuM6gSQjcz2HRkd9a3OefvXwGH9Hs=;25:VrRntmMkiAwl9duOcu/AMiIhkKgkTy7ginhSY3NlRCPbD2k9bNOGQT3xCTgc6gj/O+wfeXy474GSp5M+5B6SsaMXfANH5BK+yOrGigIL3cj2Dj/O1BwmimnhiiJinlHGrWk9yqU+Q8lC1y1lDQbDDRNzdNYIZyCymvfgMw5jTch6COTFn1pE2K6km7MMmoaEqo8hC3tYDANNR7dUeKBe6LGvD2ZIUBY2liKaeGPzCQR5YGtNOIRKHWb0f0AJ3MAXvV2MsslCG0/kEsPBG609p5vpDMIuB7YfNQoqT7WAJMWoCihq2MUa+C9tWM4svzwEnp3GMqWbMLmfLaTKm/uIfUTPjCP+U3Rz/5Wkhval+j8=
X-MS-TrafficTypeDiagnostic: BN3PR03MB1414:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;31:TqtU61WI5bDLbfsc3blwTZXQ44zkSccJ+lLEt7zgmGVb9Zmsbltm/M8igY7ZVVKVkaDXBVoZc3GmLlEyFeRtoffiuhNPl4B212X11RPRfZARt8/Eem4Yh/f4hqPCxplRZqoZlI38Pp/svb2JCaF/q2mFewaoF9B1IgMdOvPfHb4HvP3abkk0XfOxYblx87KOCQDcBhSMVhJxuskJTRF4x8JPYc6ShKi2rg2O+pRjq4g=;4:X+VVeP5CMhXdFVIa58G4MykmOk06m5HwZzK9jnL16dEIEGYyAL0et9iP6UQIljKHHydjl4o9icb+eYnreloqTyzv0BzTpgv3lMxJ1T2OUiLw1UMlU4KQeYCdzYniB8Zwe/04Nkyoqh77niN64KF6k+knlyRcSkEwdL8xZb5ipyodcpp/vb74wLkHGJqJUiVuX9IUUT/KlDHsDat+59nzSHBx8NSzVceVuqB16VDxaF1nRSO7BD1NFJMOniXB0AEEG6QidQiHY2AvrZYSfSemDe1shMGRds9Ve0omU3Uhl3QGjskgnad4Nn52OPjBzsnn
X-Microsoft-Antispam-PRVS: <BN3PR03MB141482E3BE914E1E303AAE3B9CCF0@BN3PR03MB1414.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123565025)(20161123561025)(201708071742011);SRVR:BN3PR03MB1414;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB1414;
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1414;23:t3iffju6S5daQm+kkvcNwt8zs3M/DMPGleuRwzkAd?=
 =?us-ascii?Q?4FGSACGWfIIRT07MiE+s7lo00T1m0Ea95tTSaaeh5Wom7oflCyHl8br1LDi/?=
 =?us-ascii?Q?phBVUhqLXcEHse4Djs1bwQm6egP2NKQKvzNR9ZdAagrclE3ONcc3LVHtvD2d?=
 =?us-ascii?Q?osijg7asHkUs0/IDp5uQzJ90woEb1CjScGqy7utYD4zb5aR03EwJLNUP25Iq?=
 =?us-ascii?Q?60wb8Ys0RsCD0lPT02nZdmlrUq5KFIsgzuLWEm/sLSh+EaLvqyj0RJ9FdOji?=
 =?us-ascii?Q?MxhmMoQFz+nOYF7f2maV4fHSdnh37aLMJ3YoQSYAypG4P1abLe1nWkkdTKrd?=
 =?us-ascii?Q?1S2HUmwfGkUWgmvrlKPO0kX9x9JsvYiAZpnE2Zgl+o5c4G1xQMu0+fS6hwrm?=
 =?us-ascii?Q?1atPPXI8f4qlh2saI76WJHpZbWbK81TKq+Bmc3YUSfPwEVhBtq6EpHxBazs3?=
 =?us-ascii?Q?bwwOrBDop4qCwhDWZOy/lpvb1DvhBdxr9g1Kop8G/QCisAAiNspOJ6CLsbzp?=
 =?us-ascii?Q?xRI2L+v20iFuRLE6fK3akgAgqwKCFfPNEW0m/iamm1nxoxtrd6GLAsXCFXUH?=
 =?us-ascii?Q?Tn5/aKOy8rB0rla+akNtUpr7kPCAU3PrDMM9rTerSG+AR3Pi+lpCtbdjFAO7?=
 =?us-ascii?Q?OiEgiMIIqlVBtqkoCtfGNYdYkZ6+4fAzzm8F1oB51zpWHuwExABAfyyWrqB1?=
 =?us-ascii?Q?OvXSZnpsQ5CXQVBpJnhCYWyIL4k/ZpaMwq3b9R6CHpmKXeRmAIL8N5p5rb2m?=
 =?us-ascii?Q?2bfdvmjIB2oYQRbYZUzmAFiP391OPvtTakehD+oY3r4zGtksqQXFfaR6850Y?=
 =?us-ascii?Q?OaEj3aWq0ItuW9POlmMWY8ewqcp1yxeO5gkrtu7zKOGNSSBj7pXmRhNhv2sR?=
 =?us-ascii?Q?rpj6fN0003IVz3FV6UEO4joLBew85Aj7l3POB2bFS2HL7w0P4cOZfStbKAM4?=
 =?us-ascii?Q?1MxL3RPzqTtSFZ30w9f3QkpZT2QESVorEVLyprJXJ3MGr/fRgP6Ro6UfV/gN?=
 =?us-ascii?Q?l5l88HKWTNv4gR38cEqtJpdaGqA/AjtF5C6/OyxD3pPOYRPiFV7o+28z4QsU?=
 =?us-ascii?Q?1Rdm3e6OcrPkDmSf+Q0a9eMNTPtGIND9HWU0yoH7CfzvZTu1a8Gw1FMSZpmm?=
 =?us-ascii?Q?DKYS7ZT0X5wmqmo4u7BGM37NZglHuf965FqCPy5Ou5irJyVQW5rsw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1414;6:5pDXipmJf434Z26UBAkttIRqbSic3MkM3t6LDAbTX68g6P3WFS87NM4f+271HlIdCTZJpZ5HsRA+sV6iBpZC3+ceGxk4nTyO9SpSZBd94z5zuu3iotWWiaeQ2ccpUlmXOVZLASPdFe035f4fCVuYQhDwYCy4aN50kSk1q+nUBVqxaawNe3BDqRr1ZMxJPsFgMv1g+Tpy9EQ1Xw2PkE1p2PlppJkQi7mn9nGVbutdd/Cy5a/GE+OsxCV4GY6wihAHlKoTs/2n8AJjsbpmQDXxcwgrNKaJjIrwdiReEEkFLO/aESlOVTkjY6kysd8QXEBz2b4u/72lI3txXPQKbHwuN+y6/2wmU6fIFXXJmtTNZO4=;5:E1LQAhMsmSFNOFxsXsTYwi8qiyEm3UNNzt5kC58S9gcLZ4RfhqObP1RqUn5Rrl4RBBHv1IHJKVjmDKV5A1hN+JrIqObZOb0iGyBTdjVr+1ijap+vemNtu0iJ+9HcdKC2r2fYrhOHcWPzHP4tf0NfnGb6x+8Fene5fWroJH8sApE=;24:licX6b+/kStKhFO6OYFxr9nDMijsDXetlhnmtvgpJ7mcC27FncVzgJ8xgdPfrivKShwA9fKowNLBrNqBaMGQJOnC4y5Y6BCMFUwPC6bXoCI=;7:HAuof1mTayHls2ka80P1cBPCjrs6Ie+KHqrFbYBLvonW9kMbJ9aq0x/z2Zg/NXKnSCAYRVl8KFV1rfg//WzB8a0Q7wV1Fs8nb/F0hpFOjKzjnHsN89qZ1FMi+Y7NrrF1O0IsYQGoqg4uJig94ovhLXQ0ijcpdUi45SbVk6yZuY05ny9V4/WhzmJY7aydtADMv4llerImbBJjuqvSTpZVQYbJ3WRjpELK2SSvI1MX2hnS4/hfK9RsCQb7wHxBE8hC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 11:55:42.8428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae52f2-e485-4bed-ff56-08d57858de9d
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1414
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep headers sorted alphabetically.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 sound/soc/codecs/ak4458.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 8a49dd2..31ec0ba 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -5,19 +5,19 @@
 // Copyright (C) 2016 Asahi Kasei Microdevices Corporation
 // Copyright 2018 NXP
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
-#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
-#include <sound/pcm_params.h>
 
 #include "ak4458.h"
 
-- 
2.7.4
