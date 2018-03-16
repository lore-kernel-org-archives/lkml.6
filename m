Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeCPHSL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:18:11 -0400
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com ([104.47.41.84]:10511
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753158AbeCPHRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:48 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 18/28] crypto: Remove Blackfin crypto support
Date: Fri, 16 Mar 2018 15:08:16 +0800
Message-ID: <1521184106-24475-16-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(39380400002)(2980300002)(438002)(189003)(199004)(5890100001)(5660300001)(106002)(50466002)(107886003)(6666003)(36756003)(72206003)(7636002)(47776003)(16586007)(8936002)(6916009)(426003)(478600001)(305945005)(2351001)(356003)(106466001)(246002)(2950100002)(4326008)(50226002)(86362001)(76176011)(77096007)(2906002)(51416003)(26005)(575784001)(186003)(53946003)(59450400001)(336012)(8676002)(7696005)(48376002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1485;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD004;1:XAfzWMIkTd67FKR5ayiMj85mInzj4lAxa2vbVK5EUYiAmguEjcBHiE/KDG4tSnhlBhbG6jgrVirPk2pOnTAsUsIXN+mbMBxXYkg3+CloQ7n+SdBhWyXJXp1q/Ornb1jg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da888d1-0359-4344-392a-08d58b0e03e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR03MB1485;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1485;3:PeeI8jaor9r8HlcFO5ucbPIByCDvE2P+7pKXPG08Qh+cn8D8V6KN4nMJI41BGzHO72c4RbDJHbs6hTaG0GQf8ZbVvaSQ1BIuaCRmycRVkMce4jBb3wJ7kn0U2Cl/8Apkd5qJceCWbzEpLZL0ONMTsU/c8/zt+jWY8kXKLeGGV2fARdo1Sp1cQsQg34SDIutR3cr6fJOwSJc7s90pMvEEeK3Ype9kMb+Cux84jxmsinNQOAvalRk3SKZyGsJLvcynoyHwKqBPM0gWpcBQd8OkTYHIghcSQ3J4KNkutHtynCvx0wk+hyZXINbTPoTHIdtxdbYV0g6BarVyYLTQaMRA4g==;25:PGS+8XWqevwa8QltYJflr9is22ruf+zmVMSpJNvEu+sF9AE8juoMb3yNKSoqEYHQXPDV12QOzbYfGTlK5qO+37YMjn4xoyWg3fHrrSg4tdHS8WDm72FOA+/7DouKj0IN2R9BhSWxSjWgSTs5vKqrnUPDA2d5hmVyjiJcPE7Ro8LAc3FiMgCMPQEWHe+c0lyXPVutf+s7RXPzn5GAzEvjRTPM3E/xNH8FQog/B6QopnMHMmSv4t8//BiqUBbZLYrgAatRynILRcRAD/iQgofGoOlv0Q6UGVO0/ZO6fw0jJyTHIBZHnIvtLj1tj2+WkX8rZ+UmTyMVekLQREnWn2otJg==;31:dmp21Co1uwiJTfhLcSknpM4dOVc7F+BeNRxZAoxUJiSkKUxc7zQKxcav16tH4Oy2hqbviEilXnE/Dp1ttdQZis6kfaYlmncqmTZ533GMTGKm1iTssdouWxlPTES4+vlCgBsdV/HiobtXp9OwYE5Zm0xA65LnOlsSZEy1VT486DTqBMMLSm4m5IEOCTmM/a1w0RhUrANtmuEi8yOLsENr5xdiD/q+tOdZyptABBmSZjU=
X-MS-TrafficTypeDiagnostic: CY1PR03MB1485:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1485;20:W9JdtAhKKwBM4AUUtgJRcKcG23SqopR98gRxgL005WrwKCskZc9Wp0teP8LHxZSM2SyiflVD/5YBEcJC/O8O4i2Tz+BlMq1cSLxVar8OIC+acJIR95kOtiM8AJH8uEMDFk9yFjLy8/ZKbXj0IlLYBedNIxVZrkP/cxB50RWAeAgXv4zKxHHlq3dhTsyxqEZYPkzbX0nBjUJhEMDnd7ZrJoBYJEBebtTnnqjldc/9y/RtbSUPxGUy7ihG98HkfFwSEjr6benkt2ENNE0g4Ci+2XXoMVAhq7YTtzSZNbBC9h76ILe+aj61rTh+GW/8y1i2QQDKE9D/sFg606SsSDEUOwl1UJMU4NoPM413idhb9X4VltQlPNoH3cCkooDtkdwYCdCGD+XbH1avSoie9XBph72IlPCJ7a6vu5oYF3ePUpnruFaEnzoL1+wwLwrZHFtxU2SymWojQ5Tu1B3CVoIUkiYFVz4bjgeOj62hy4vwQmwjVC3mg6PPXXFGQp2vpQRq;4:3lHDVyibPOVsAiEhzYvuFZXPsBCium04wWWEaG8R/yK4p4PVl0q/qnHm8bA6WIIcKjIs22OvJMooarl5CJW4LVPJnXjEzQlAPKNFsIsJmVRn6PRV+7Sxn9BJzN0AcwgRwttNmkCeFYL6EamDXC0WrtbIjAZOPkCWxvoxObNJjO9Tf7SfYztaa7LfodRWAPXTwWlv8YACqfCofm4EBmL6G3vGOIGNLecUbayRRHzi+4DnNsRwdtBh6ZMb1Bc68x35SpdEnBmgtEfKXCj8YZFVU5T9J/YqpSoolqDB/ZyGuD9TSj7aP1ZTD079cWjfdsoe
X-Microsoft-Antispam-PRVS: <CY1PR03MB148576AA4A6DE3E57FA39A96E0D70@CY1PR03MB1485.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231221)(944501281)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR03MB1485;BCL:0;PCL:0;RULEID:;SRVR:CY1PR03MB1485;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB1485;23:bbAcIag/TcCUkA+ZAq1Vd2xy4Oc/B8h9z1Dorw49G?=
 =?us-ascii?Q?esOJy8G3lTZvQ9nZhAAYcF9hMUkbob5l0He3JWL9XtI8B722CVSSSCneHT33?=
 =?us-ascii?Q?S1p4/wkGp5p9bMtCg+uPzLQLob+EWpOAOMxC2+WJivfh6AIFy38BnoRWiZYk?=
 =?us-ascii?Q?QoaP4599frz34hvz2OSI5sxrtFtDU1as4oUeVnzFb1wZIXC/bflo5ltTx1/7?=
 =?us-ascii?Q?uZOeO7eb4erVYitsSkdn7tNZt+DYxJ6E4DDDy/9cNPIk4pwgh7SygYT4GyAa?=
 =?us-ascii?Q?MA9DSQZwbkchMmzuvDOBd19tk0ACx5EsVW7lkGhevehdPgM7ag/VDyeyk+lD?=
 =?us-ascii?Q?hDfjVgxwUDmccnqWSWJu7TSz9iVswGLgDaeBZmWm4goU9sXggNrCYJUE/Gw3?=
 =?us-ascii?Q?SB8sP4hG+DlW907i9XRHrWOXkSovF5JMQXkwVPcxh4TUcnY6YY/JaGyV28u7?=
 =?us-ascii?Q?CmWRLv2MFCw2w4zfc6xXRKTkAytuILYj190cDlKJN95oka5sg/kp2yci2ssc?=
 =?us-ascii?Q?cy6ICeD2HpGh/lCpxzy+P4OjDIjM8YKjn0gcLSdcdaf4GGIZwBYdtfZB7P6F?=
 =?us-ascii?Q?HeB/axabIXffmXcrOGTZWkjnQkhTFRMDf8O9ffCJ8y2KiJTNZlt2luMWK7Ak?=
 =?us-ascii?Q?pgg3rUwBWX1piTVrV71POEdmTAGngFtiURhqP3vQZZWAm/j3V+o+4cwHRbFT?=
 =?us-ascii?Q?Wk4zER2+gHO/t4fVDNBqLOeejVx+L5suglPw4d3ceNoWoqWMlbIkmkzRjL87?=
 =?us-ascii?Q?gac2lXpz2+eyjICLSB0F8khuBSWmSkhifXEejoxSuZ4apIbCOBkvlTilhayk?=
 =?us-ascii?Q?6uSa8vD3+eVyxKflR5AVLVq/mf3nz6Lvi7ByFQwtFZvWgHVTJWzuDpM3fQEo?=
 =?us-ascii?Q?bgaxI3nf92+TUEc3Xwf+zOtkYqIiL9YyfDKUKilvdMbsiodDk4i9vmlq7rEU?=
 =?us-ascii?Q?q+SPtHOSWW85dp++G3NKMKP69K5oXpHV/dbgTauQ70C6qmyPTehHtJMoMM8r?=
 =?us-ascii?Q?5fDf0zaMfOJvnxTfJBHFc21VjB/Zs6QBXBV7b3Go/YI7XXah3Gls/sDmFbeO?=
 =?us-ascii?Q?b91/yueXlLVnq6bhO5e5pgs66k+?=
X-Microsoft-Antispam-Message-Info: V8HqRWhmKtWWnP9RqyaTg1d/2ZOnxrGLzYAzOFK6WM/WmjZlDSvCEU+BLiWOD+YFaQ1RdsfMfWyJnRr94fsiO1tjafZ+TIYl5BmbeMC+12yVvHWymCWgwxu3X4Lzk6WlX/BN+dFO76gx8EL6BpEiG5tknXkzSV3oTx2cF8VmjrpKNHnpuJkZTOPCjkjIbncN
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1485;6:7Gjg/LNUGn8IG7TyHdMYOpLS5NVHjtZopvpyvQDBFFDXveRKs7CvQjeHk7fBrjhrQ3fR4bRza73dXpWUX2vd4eS2anwok/SutM1Clkjp7yfISKs1qsHB9rdkIJnZAw7+13Ig48x855NwIShSib4yhbsedChywPvYAqhqxIYgwEaVrg2gkBB7Ua7qjxAKNMOLYmqVBGNbXUHXfutBlMek2c3Pdm8DQD84QlM1pRL1/ht2lg627i3sZLZMK9yhec+lEwMZ0Bnmy6bZ3SpiAeO8xkOWugkF59rrLF2pcgRlWWeh70uwXLaW8Bkh6T8qh6plbY0YjRjoq5PfTes4Oei7JwDmBrlb4+t+avsPF/O3cAA=;5:u8jNFHj2pibyXpt5ZCCedhcPtrLbsTqDlZofxaYEWbQRGcRfd9XFfniO+xXh7jz46SBjbF6sqtjizsF84lkK8rV8+5eS61fN5dj/oOLp09AZUZqrnxdveflGk5Jp8aGOf861VyKK64S1v9pEEf5kdvNa4XKIP0gaOewFsvmehys=;24:HYjPQNw9PPuPUFHhE2lkigpPGmWxc4aVGMn06ducPUz32S7R/fjRBolwyWhinbKuSv+KIGWqds3407Eu3iaMZOOyN36FjgO7II404t5FrjY=;7:2RcukDIXWA+SEhKgN14ocNXIw/OIb2+Hj45uQ+O2ps0Sc+GezygcPJewAB0001Fus11ERZfSvItM2GB+PE+xluuv7v0IqunHH/E6dsnBeuaU/5StTlr0HlzVCyaqhJeasGirKNJA52ucpQx5wTIFNNMnJOaVfHnhst1MtRYOeioU86V3z5OpaS6Bbv1ZelvM2lx/4I17r6cV8ALdxjO1aqoE9jSJANNO9/O1Inv5+1yfvQLGE4sj/YhSwHuKZaVJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:45.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da888d1-0359-4344-392a-08d58b0e03e5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1485
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin crypto support
---
 crypto/testmgr.c          |   6 -
 crypto/testmgr.h          |  88 ------
 drivers/crypto/Kconfig    |   7 -
 drivers/crypto/Makefile   |   1 -
 drivers/crypto/bfin_crc.c | 743 ----------------------------------------------
 drivers/crypto/bfin_crc.h | 124 --------
 6 files changed, 969 deletions(-)
 delete mode 100644 drivers/crypto/bfin_crc.c
 delete mode 100644 drivers/crypto/bfin_crc.h

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index d5e23a1..8dacd69 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -3070,12 +3070,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.hash = __VECS(ghash_tv_template)
 		}
 	}, {
-		.alg = "hmac(crc32)",
-		.test = alg_test_hash,
-		.suite = {
-			.hash = __VECS(bfin_crc_tv_template)
-		}
-	}, {
 		.alg = "hmac(md5)",
 		.test = alg_test_hash,
 		.suite = {
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 6044f69..021e953 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -35045,94 +35045,6 @@ static const struct hash_testvec crc32c_tv_template[] = {
 	}
 };
 
-/*
- * Blakcifn CRC test vectors
- */
-static const struct hash_testvec bfin_crc_tv_template[] = {
-	{
-		.psize = 0,
-		.digest = "\x00\x00\x00\x00",
-	},
-	{
-		.key = "\x87\xa9\xcb\xed",
-		.ksize = 4,
-		.psize = 0,
-		.digest = "\x87\xa9\xcb\xed",
-	},
-	{
-		.key = "\xff\xff\xff\xff",
-		.ksize = 4,
-		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
-			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
-			     "\x11\x12\x13\x14\x15\x16\x17\x18"
-			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
-			     "\x21\x22\x23\x24\x25\x26\x27\x28",
-		.psize = 40,
-		.digest = "\x84\x0c\x8d\xa2",
-	},
-	{
-		.key = "\xff\xff\xff\xff",
-		.ksize = 4,
-		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
-			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
-			     "\x11\x12\x13\x14\x15\x16\x17\x18"
-			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
-			     "\x21\x22\x23\x24\x25\x26",
-		.psize = 38,
-		.digest = "\x8c\x58\xec\xb7",
-	},
-	{
-		.key = "\xff\xff\xff\xff",
-		.ksize = 4,
-		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
-			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
-			     "\x11\x12\x13\x14\x15\x16\x17\x18"
-			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
-			     "\x21\x22\x23\x24\x25\x26\x27",
-		.psize = 39,
-		.digest = "\xdc\x50\x28\x7b",
-	},
-	{
-		.key = "\xff\xff\xff\xff",
-		.ksize = 4,
-		.plaintext = "\x01\x02\x03\x04\x05\x06\x07\x08"
-			     "\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10"
-			     "\x11\x12\x13\x14\x15\x16\x17\x18"
-			     "\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20"
-			     "\x21\x22\x23\x24\x25\x26\x27\x28"
-			     "\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30"
-			     "\x31\x32\x33\x34\x35\x36\x37\x38"
-			     "\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
-			     "\x41\x42\x43\x44\x45\x46\x47\x48"
-			     "\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50"
-			     "\x51\x52\x53\x54\x55\x56\x57\x58"
-			     "\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60"
-			     "\x61\x62\x63\x64\x65\x66\x67\x68"
-			     "\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70"
-			     "\x71\x72\x73\x74\x75\x76\x77\x78"
-			     "\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80"
-			     "\x81\x82\x83\x84\x85\x86\x87\x88"
-			     "\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90"
-			     "\x91\x92\x93\x94\x95\x96\x97\x98"
-			     "\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0"
-			     "\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8"
-			     "\xa9\xaa\xab\xac\xad\xae\xaf\xb0"
-			     "\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8"
-			     "\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0"
-			     "\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8"
-			     "\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0"
-			     "\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8"
-			     "\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0"
-			     "\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8"
-			     "\xe9\xea\xeb\xec\xed\xee\xef\xf0",
-		.psize = 240,
-		.digest = "\x10\x19\x4a\x5c",
-		.np = 2,
-		.tap = { 31, 209 }
-	},
-
-};
-
 static const struct comp_testvec lz4_comp_tv_template[] = {
 	{
 		.inlen	= 255,
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 4b741b8..c17368c 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -464,13 +464,6 @@ if CRYPTO_DEV_UX500
 	source "drivers/crypto/ux500/Kconfig"
 endif # if CRYPTO_DEV_UX500
 
-config CRYPTO_DEV_BFIN_CRC
-	tristate "Support for Blackfin CRC hardware"
-	depends on BF60x
-	help
-	  Newer Blackfin processors have CRC hardware. Select this if you
-	  want to use the Blackfin CRC module.
-
 config CRYPTO_DEV_ATMEL_AUTHENC
 	tristate "Support for Atmel IPSEC/SSL hw accelerator"
 	depends on HAS_DMA
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 2513d13..c08622b 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_ECC) += atmel-ecc.o
-obj-$(CONFIG_CRYPTO_DEV_BFIN_CRC) += bfin_crc.o
 obj-$(CONFIG_CRYPTO_DEV_CAVIUM_ZIP) += cavium/
 obj-$(CONFIG_CRYPTO_DEV_CCP) += ccp/
 obj-$(CONFIG_CRYPTO_DEV_CHELSIO) += chelsio/
diff --git a/drivers/crypto/bfin_crc.c b/drivers/crypto/bfin_crc.c
deleted file mode 100644
index bfbf8bf..0000000
--- a/drivers/crypto/bfin_crc.c
+++ /dev/null
@@ -1,743 +0,0 @@
-/*
- * Cryptographic API.
- *
- * Support Blackfin CRC HW acceleration.
- *
- * Copyright 2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-mapping.h>
-#include <linux/delay.h>
-#include <linux/crypto.h>
-#include <linux/cryptohash.h>
-#include <crypto/scatterwalk.h>
-#include <crypto/algapi.h>
-#include <crypto/hash.h>
-#include <crypto/internal/hash.h>
-#include <asm/unaligned.h>
-
-#include <asm/dma.h>
-#include <asm/portmux.h>
-#include <asm/io.h>
-
-#include "bfin_crc.h"
-
-#define CRC_CCRYPTO_QUEUE_LENGTH	5
-
-#define DRIVER_NAME "bfin-hmac-crc"
-#define CHKSUM_DIGEST_SIZE      4
-#define CHKSUM_BLOCK_SIZE       1
-
-#define CRC_MAX_DMA_DESC	100
-
-#define CRC_CRYPTO_STATE_UPDATE		1
-#define CRC_CRYPTO_STATE_FINALUPDATE	2
-#define CRC_CRYPTO_STATE_FINISH		3
-
-struct bfin_crypto_crc {
-	struct list_head	list;
-	struct device		*dev;
-	spinlock_t		lock;
-
-	int			irq;
-	int			dma_ch;
-	u32			poly;
-	struct crc_register	*regs;
-
-	struct ahash_request	*req; /* current request in operation */
-	struct dma_desc_array	*sg_cpu; /* virt addr of sg dma descriptors */
-	dma_addr_t		sg_dma; /* phy addr of sg dma descriptors */
-	u8			*sg_mid_buf;
-	dma_addr_t		sg_mid_dma; /* phy addr of sg mid buffer */
-
-	struct tasklet_struct	done_task;
-	struct crypto_queue	queue; /* waiting requests */
-
-	u8			busy:1; /* crc device in operation flag */
-};
-
-static struct bfin_crypto_crc_list {
-	struct list_head	dev_list;
-	spinlock_t		lock;
-} crc_list;
-
-struct bfin_crypto_crc_reqctx {
-	struct bfin_crypto_crc	*crc;
-
-	unsigned int		total;	/* total request bytes */
-	size_t			sg_buflen; /* bytes for this update */
-	unsigned int		sg_nents;
-	struct scatterlist	*sg; /* sg list head for this update*/
-	struct scatterlist	bufsl[2]; /* chained sg list */
-
-	size_t			bufnext_len;
-	size_t			buflast_len;
-	u8			bufnext[CHKSUM_DIGEST_SIZE]; /* extra bytes for next udpate */
-	u8			buflast[CHKSUM_DIGEST_SIZE]; /* extra bytes from last udpate */
-
-	u8			flag;
-};
-
-struct bfin_crypto_crc_ctx {
-	struct bfin_crypto_crc	*crc;
-	u32			key;
-};
-
-/*
- * get element in scatter list by given index
- */
-static struct scatterlist *sg_get(struct scatterlist *sg_list, unsigned int nents,
-				unsigned int index)
-{
-	struct scatterlist *sg = NULL;
-	int i;
-
-	for_each_sg(sg_list, sg, nents, i)
-		if (i == index)
-			break;
-
-	return sg;
-}
-
-static int bfin_crypto_crc_init_hw(struct bfin_crypto_crc *crc, u32 key)
-{
-	writel(0, &crc->regs->datacntrld);
-	writel(MODE_CALC_CRC << OPMODE_OFFSET, &crc->regs->control);
-	writel(key, &crc->regs->curresult);
-
-	/* setup CRC interrupts */
-	writel(CMPERRI | DCNTEXPI, &crc->regs->status);
-	writel(CMPERRI | DCNTEXPI, &crc->regs->intrenset);
-
-	return 0;
-}
-
-static int bfin_crypto_crc_init(struct ahash_request *req)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct bfin_crypto_crc_ctx *crc_ctx = crypto_ahash_ctx(tfm);
-	struct bfin_crypto_crc_reqctx *ctx = ahash_request_ctx(req);
-	struct bfin_crypto_crc *crc;
-
-	dev_dbg(ctx->crc->dev, "crc_init\n");
-	spin_lock_bh(&crc_list.lock);
-	list_for_each_entry(crc, &crc_list.dev_list, list) {
-		crc_ctx->crc = crc;
-		break;
-	}
-	spin_unlock_bh(&crc_list.lock);
-
-	if (sg_nents(req->src) > CRC_MAX_DMA_DESC) {
-		dev_dbg(ctx->crc->dev, "init: requested sg list is too big > %d\n",
-			CRC_MAX_DMA_DESC);
-		return -EINVAL;
-	}
-
-	ctx->crc = crc;
-	ctx->bufnext_len = 0;
-	ctx->buflast_len = 0;
-	ctx->sg_buflen = 0;
-	ctx->total = 0;
-	ctx->flag = 0;
-
-	/* init crc results */
-	put_unaligned_le32(crc_ctx->key, req->result);
-
-	dev_dbg(ctx->crc->dev, "init: digest size: %d\n",
-		crypto_ahash_digestsize(tfm));
-
-	return bfin_crypto_crc_init_hw(crc, crc_ctx->key);
-}
-
-static void bfin_crypto_crc_config_dma(struct bfin_crypto_crc *crc)
-{
-	struct scatterlist *sg;
-	struct bfin_crypto_crc_reqctx *ctx = ahash_request_ctx(crc->req);
-	int i = 0, j = 0;
-	unsigned long dma_config;
-	unsigned int dma_count;
-	unsigned int dma_addr;
-	unsigned int mid_dma_count = 0;
-	int dma_mod;
-
-	dma_map_sg(crc->dev, ctx->sg, ctx->sg_nents, DMA_TO_DEVICE);
-
-	for_each_sg(ctx->sg, sg, ctx->sg_nents, j) {
-		dma_addr = sg_dma_address(sg);
-		/* deduce extra bytes in last sg */
-		if (sg_is_last(sg))
-			dma_count = sg_dma_len(sg) - ctx->bufnext_len;
-		else
-			dma_count = sg_dma_len(sg);
-
-		if (mid_dma_count) {
-			/* Append last middle dma buffer to 4 bytes with first
-			   bytes in current sg buffer. Move addr of current
-			   sg and deduce the length of current sg.
-			 */
-			memcpy(crc->sg_mid_buf +(i << 2) + mid_dma_count,
-				sg_virt(sg),
-				CHKSUM_DIGEST_SIZE - mid_dma_count);
-			dma_addr += CHKSUM_DIGEST_SIZE - mid_dma_count;
-			dma_count -= CHKSUM_DIGEST_SIZE - mid_dma_count;
-
-			dma_config = DMAFLOW_ARRAY | RESTART | NDSIZE_3 |
-				DMAEN | PSIZE_32 | WDSIZE_32;
-
-			/* setup new dma descriptor for next middle dma */
-			crc->sg_cpu[i].start_addr = crc->sg_mid_dma + (i << 2);
-			crc->sg_cpu[i].cfg = dma_config;
-			crc->sg_cpu[i].x_count = 1;
-			crc->sg_cpu[i].x_modify = CHKSUM_DIGEST_SIZE;
-			dev_dbg(crc->dev, "%d: crc_dma: start_addr:0x%lx, "
-				"cfg:0x%x, x_count:0x%x, x_modify:0x%x\n",
-				i, crc->sg_cpu[i].start_addr,
-				crc->sg_cpu[i].cfg, crc->sg_cpu[i].x_count,
-				crc->sg_cpu[i].x_modify);
-			i++;
-		}
-
-		dma_config = DMAFLOW_ARRAY | RESTART | NDSIZE_3 | DMAEN | PSIZE_32;
-		/* chop current sg dma len to multiple of 32 bits */
-		mid_dma_count = dma_count % 4;
-		dma_count &= ~0x3;
-
-		if (dma_addr % 4 == 0) {
-			dma_config |= WDSIZE_32;
-			dma_count >>= 2;
-			dma_mod = 4;
-		} else if (dma_addr % 2 == 0) {
-			dma_config |= WDSIZE_16;
-			dma_count >>= 1;
-			dma_mod = 2;
-		} else {
-			dma_config |= WDSIZE_8;
-			dma_mod = 1;
-		}
-
-		crc->sg_cpu[i].start_addr = dma_addr;
-		crc->sg_cpu[i].cfg = dma_config;
-		crc->sg_cpu[i].x_count = dma_count;
-		crc->sg_cpu[i].x_modify = dma_mod;
-		dev_dbg(crc->dev, "%d: crc_dma: start_addr:0x%lx, "
-			"cfg:0x%x, x_count:0x%x, x_modify:0x%x\n",
-			i, crc->sg_cpu[i].start_addr,
-			crc->sg_cpu[i].cfg, crc->sg_cpu[i].x_count,
-			crc->sg_cpu[i].x_modify);
-		i++;
-
-		if (mid_dma_count) {
-			/* copy extra bytes to next middle dma buffer */
-			memcpy(crc->sg_mid_buf + (i << 2),
-				(u8*)sg_virt(sg) + (dma_count << 2),
-				mid_dma_count);
-		}
-	}
-
-	dma_config = DMAFLOW_ARRAY | RESTART | NDSIZE_3 | DMAEN | PSIZE_32 | WDSIZE_32;
-	/* For final update req, append the buffer for next update as well*/
-	if (ctx->bufnext_len && (ctx->flag == CRC_CRYPTO_STATE_FINALUPDATE ||
-		ctx->flag == CRC_CRYPTO_STATE_FINISH)) {
-		crc->sg_cpu[i].start_addr = dma_map_single(crc->dev, ctx->bufnext,
-						CHKSUM_DIGEST_SIZE, DMA_TO_DEVICE);
-		crc->sg_cpu[i].cfg = dma_config;
-		crc->sg_cpu[i].x_count = 1;
-		crc->sg_cpu[i].x_modify = CHKSUM_DIGEST_SIZE;
-		dev_dbg(crc->dev, "%d: crc_dma: start_addr:0x%lx, "
-			"cfg:0x%x, x_count:0x%x, x_modify:0x%x\n",
-			i, crc->sg_cpu[i].start_addr,
-			crc->sg_cpu[i].cfg, crc->sg_cpu[i].x_count,
-			crc->sg_cpu[i].x_modify);
-		i++;
-	}
-
-	if (i == 0)
-		return;
-
-	/* Set the last descriptor to stop mode */
-	crc->sg_cpu[i - 1].cfg &= ~(DMAFLOW | NDSIZE);
-	crc->sg_cpu[i - 1].cfg |= DI_EN;
-	set_dma_curr_desc_addr(crc->dma_ch, (unsigned long *)crc->sg_dma);
-	set_dma_x_count(crc->dma_ch, 0);
-	set_dma_x_modify(crc->dma_ch, 0);
-	set_dma_config(crc->dma_ch, dma_config);
-}
-
-static int bfin_crypto_crc_handle_queue(struct bfin_crypto_crc *crc,
-				  struct ahash_request *req)
-{
-	struct crypto_async_request *async_req, *backlog;
-	struct bfin_crypto_crc_reqctx *ctx;
-	struct scatterlist *sg;
-	int ret = 0;
-	int nsg, i, j;
-	unsigned int nextlen;
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&crc->lock, flags);
-	if (req)
-		ret = ahash_enqueue_request(&crc->queue, req);
-	if (crc->busy) {
-		spin_unlock_irqrestore(&crc->lock, flags);
-		return ret;
-	}
-	backlog = crypto_get_backlog(&crc->queue);
-	async_req = crypto_dequeue_request(&crc->queue);
-	if (async_req)
-		crc->busy = 1;
-	spin_unlock_irqrestore(&crc->lock, flags);
-
-	if (!async_req)
-		return ret;
-
-	if (backlog)
-		backlog->complete(backlog, -EINPROGRESS);
-
-	req = ahash_request_cast(async_req);
-	crc->req = req;
-	ctx = ahash_request_ctx(req);
-	ctx->sg = NULL;
-	ctx->sg_buflen = 0;
-	ctx->sg_nents = 0;
-
-	dev_dbg(crc->dev, "handling new req, flag=%u, nbytes: %d\n",
-						ctx->flag, req->nbytes);
-
-	if (ctx->flag == CRC_CRYPTO_STATE_FINISH) {
-		if (ctx->bufnext_len == 0) {
-			crc->busy = 0;
-			return 0;
-		}
-
-		/* Pack last crc update buffer to 32bit */
-		memset(ctx->bufnext + ctx->bufnext_len, 0,
-				CHKSUM_DIGEST_SIZE - ctx->bufnext_len);
-	} else {
-		/* Pack small data which is less than 32bit to buffer for next update. */
-		if (ctx->bufnext_len + req->nbytes < CHKSUM_DIGEST_SIZE) {
-			memcpy(ctx->bufnext + ctx->bufnext_len,
-				sg_virt(req->src), req->nbytes);
-			ctx->bufnext_len += req->nbytes;
-			if (ctx->flag == CRC_CRYPTO_STATE_FINALUPDATE &&
-				ctx->bufnext_len) {
-				goto finish_update;
-			} else {
-				crc->busy = 0;
-				return 0;
-			}
-		}
-
-		if (ctx->bufnext_len) {
-			/* Chain in extra bytes of last update */
-			ctx->buflast_len = ctx->bufnext_len;
-			memcpy(ctx->buflast, ctx->bufnext, ctx->buflast_len);
-
-			nsg = ctx->sg_buflen ? 2 : 1;
-			sg_init_table(ctx->bufsl, nsg);
-			sg_set_buf(ctx->bufsl, ctx->buflast, ctx->buflast_len);
-			if (nsg > 1)
-				sg_chain(ctx->bufsl, nsg, req->src);
-			ctx->sg = ctx->bufsl;
-		} else
-			ctx->sg = req->src;
-
-		/* Chop crc buffer size to multiple of 32 bit */
-		nsg = sg_nents(ctx->sg);
-		ctx->sg_nents = nsg;
-		ctx->sg_buflen = ctx->buflast_len + req->nbytes;
-		ctx->bufnext_len = ctx->sg_buflen % 4;
-		ctx->sg_buflen &= ~0x3;
-
-		if (ctx->bufnext_len) {
-			/* copy extra bytes to buffer for next update */
-			memset(ctx->bufnext, 0, CHKSUM_DIGEST_SIZE);
-			nextlen = ctx->bufnext_len;
-			for (i = nsg - 1; i >= 0; i--) {
-				sg = sg_get(ctx->sg, nsg, i);
-				j = min(nextlen, sg_dma_len(sg));
-				memcpy(ctx->bufnext + nextlen - j,
-					sg_virt(sg) + sg_dma_len(sg) - j, j);
-				if (j == sg_dma_len(sg))
-					ctx->sg_nents--;
-				nextlen -= j;
-				if (nextlen == 0)
-					break;
-			}
-		}
-	}
-
-finish_update:
-	if (ctx->bufnext_len && (ctx->flag == CRC_CRYPTO_STATE_FINALUPDATE ||
-		ctx->flag == CRC_CRYPTO_STATE_FINISH))
-		ctx->sg_buflen += CHKSUM_DIGEST_SIZE;
-
-	/* set CRC data count before start DMA */
-	writel(ctx->sg_buflen >> 2, &crc->regs->datacnt);
-
-	/* setup and enable CRC DMA */
-	bfin_crypto_crc_config_dma(crc);
-
-	/* finally kick off CRC operation */
-	reg = readl(&crc->regs->control);
-	writel(reg | BLKEN, &crc->regs->control);
-
-	return -EINPROGRESS;
-}
-
-static int bfin_crypto_crc_update(struct ahash_request *req)
-{
-	struct bfin_crypto_crc_reqctx *ctx = ahash_request_ctx(req);
-
-	if (!req->nbytes)
-		return 0;
-
-	dev_dbg(ctx->crc->dev, "crc_update\n");
-	ctx->total += req->nbytes;
-	ctx->flag = CRC_CRYPTO_STATE_UPDATE;
-
-	return bfin_crypto_crc_handle_queue(ctx->crc, req);
-}
-
-static int bfin_crypto_crc_final(struct ahash_request *req)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct bfin_crypto_crc_ctx *crc_ctx = crypto_ahash_ctx(tfm);
-	struct bfin_crypto_crc_reqctx *ctx = ahash_request_ctx(req);
-
-	dev_dbg(ctx->crc->dev, "crc_final\n");
-	ctx->flag = CRC_CRYPTO_STATE_FINISH;
-	crc_ctx->key = 0;
-
-	return bfin_crypto_crc_handle_queue(ctx->crc, req);
-}
-
-static int bfin_crypto_crc_finup(struct ahash_request *req)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct bfin_crypto_crc_ctx *crc_ctx = crypto_ahash_ctx(tfm);
-	struct bfin_crypto_crc_reqctx *ctx = ahash_request_ctx(req);
-
-	dev_dbg(ctx->crc->dev, "crc_finishupdate\n");
-	ctx->total += req->nbytes;
-	ctx->flag = CRC_CRYPTO_STATE_FINALUPDATE;
-	crc_ctx->key = 0;
-
-	return bfin_crypto_crc_handle_queue(ctx->crc, req);
-}
-
-static int bfin_crypto_crc_digest(struct ahash_request *req)
-{
-	int ret;
-
-	ret = bfin_crypto_crc_init(req);
-	if (ret)
-		return ret;
-
-	return bfin_crypto_crc_finup(req);
-}
-
-static int bfin_crypto_crc_setkey(struct crypto_ahash *tfm, const u8 *key,
-			unsigned int keylen)
-{
-	struct bfin_crypto_crc_ctx *crc_ctx = crypto_ahash_ctx(tfm);
-
-	dev_dbg(crc_ctx->crc->dev, "crc_setkey\n");
-	if (keylen != CHKSUM_DIGEST_SIZE) {
-		crypto_ahash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
-		return -EINVAL;
-	}
-
-	crc_ctx->key = get_unaligned_le32(key);
-
-	return 0;
-}
-
-static int bfin_crypto_crc_cra_init(struct crypto_tfm *tfm)
-{
-	struct bfin_crypto_crc_ctx *crc_ctx = crypto_tfm_ctx(tfm);
-
-	crc_ctx->key = 0;
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct bfin_crypto_crc_reqctx));
-
-	return 0;
-}
-
-static void bfin_crypto_crc_cra_exit(struct crypto_tfm *tfm)
-{
-}
-
-static struct ahash_alg algs = {
-	.init		= bfin_crypto_crc_init,
-	.update		= bfin_crypto_crc_update,
-	.final		= bfin_crypto_crc_final,
-	.finup		= bfin_crypto_crc_finup,
-	.digest		= bfin_crypto_crc_digest,
-	.setkey		= bfin_crypto_crc_setkey,
-	.halg.digestsize	= CHKSUM_DIGEST_SIZE,
-	.halg.base	= {
-		.cra_name		= "hmac(crc32)",
-		.cra_driver_name	= DRIVER_NAME,
-		.cra_priority		= 100,
-		.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
-						CRYPTO_ALG_ASYNC |
-						CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		= sizeof(struct bfin_crypto_crc_ctx),
-		.cra_alignmask		= 3,
-		.cra_module		= THIS_MODULE,
-		.cra_init		= bfin_crypto_crc_cra_init,
-		.cra_exit		= bfin_crypto_crc_cra_exit,
-	}
-};
-
-static void bfin_crypto_crc_done_task(unsigned long data)
-{
-	struct bfin_crypto_crc *crc = (struct bfin_crypto_crc *)data;
-
-	bfin_crypto_crc_handle_queue(crc, NULL);
-}
-
-static irqreturn_t bfin_crypto_crc_handler(int irq, void *dev_id)
-{
-	struct bfin_crypto_crc *crc = dev_id;
-	u32 reg;
-
-	if (readl(&crc->regs->status) & DCNTEXP) {
-		writel(DCNTEXP, &crc->regs->status);
-
-		/* prepare results */
-		put_unaligned_le32(readl(&crc->regs->result),
-			crc->req->result);
-
-		reg = readl(&crc->regs->control);
-		writel(reg & ~BLKEN, &crc->regs->control);
-		crc->busy = 0;
-
-		if (crc->req->base.complete)
-			crc->req->base.complete(&crc->req->base, 0);
-
-		tasklet_schedule(&crc->done_task);
-
-		return IRQ_HANDLED;
-	} else
-		return IRQ_NONE;
-}
-
-#ifdef CONFIG_PM
-/**
- *	bfin_crypto_crc_suspend - suspend crc device
- *	@pdev: device being suspended
- *	@state: requested suspend state
- */
-static int bfin_crypto_crc_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct bfin_crypto_crc *crc = platform_get_drvdata(pdev);
-	int i = 100000;
-
-	while ((readl(&crc->regs->control) & BLKEN) && --i)
-		cpu_relax();
-
-	if (i == 0)
-		return -EBUSY;
-
-	return 0;
-}
-#else
-# define bfin_crypto_crc_suspend NULL
-#endif
-
-#define bfin_crypto_crc_resume NULL
-
-/**
- *	bfin_crypto_crc_probe - Initialize module
- *
- */
-static int bfin_crypto_crc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	struct bfin_crypto_crc *crc;
-	unsigned int timeout = 100000;
-	int ret;
-
-	crc = devm_kzalloc(dev, sizeof(*crc), GFP_KERNEL);
-	if (!crc) {
-		dev_err(&pdev->dev, "fail to malloc bfin_crypto_crc\n");
-		return -ENOMEM;
-	}
-
-	crc->dev = dev;
-
-	INIT_LIST_HEAD(&crc->list);
-	spin_lock_init(&crc->lock);
-	tasklet_init(&crc->done_task, bfin_crypto_crc_done_task, (unsigned long)crc);
-	crypto_init_queue(&crc->queue, CRC_CCRYPTO_QUEUE_LENGTH);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	crc->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR((void *)crc->regs)) {
-		dev_err(&pdev->dev, "Cannot map CRC IO\n");
-		return PTR_ERR((void *)crc->regs);
-	}
-
-	crc->irq = platform_get_irq(pdev, 0);
-	if (crc->irq < 0) {
-		dev_err(&pdev->dev, "No CRC DCNTEXP IRQ specified\n");
-		return -ENOENT;
-	}
-
-	ret = devm_request_irq(dev, crc->irq, bfin_crypto_crc_handler,
-			IRQF_SHARED, dev_name(dev), crc);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to request blackfin crc irq\n");
-		return ret;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "No CRC DMA channel specified\n");
-		return -ENOENT;
-	}
-	crc->dma_ch = res->start;
-
-	ret = request_dma(crc->dma_ch, dev_name(dev));
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to attach Blackfin CRC DMA channel\n");
-		return ret;
-	}
-
-	crc->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &crc->sg_dma, GFP_KERNEL);
-	if (crc->sg_cpu == NULL) {
-		ret = -ENOMEM;
-		goto out_error_dma;
-	}
-	/*
-	 * need at most CRC_MAX_DMA_DESC sg + CRC_MAX_DMA_DESC middle  +
-	 * 1 last + 1 next dma descriptors
-	 */
-	crc->sg_mid_buf = (u8 *)(crc->sg_cpu + ((CRC_MAX_DMA_DESC + 1) << 1));
-	crc->sg_mid_dma = crc->sg_dma + sizeof(struct dma_desc_array)
-			* ((CRC_MAX_DMA_DESC + 1) << 1);
-
-	writel(0, &crc->regs->control);
-	crc->poly = (u32)pdev->dev.platform_data;
-	writel(crc->poly, &crc->regs->poly);
-
-	while (!(readl(&crc->regs->status) & LUTDONE) && (--timeout) > 0)
-		cpu_relax();
-
-	if (timeout == 0)
-		dev_info(&pdev->dev, "init crc poly timeout\n");
-
-	platform_set_drvdata(pdev, crc);
-
-	spin_lock(&crc_list.lock);
-	list_add(&crc->list, &crc_list.dev_list);
-	spin_unlock(&crc_list.lock);
-
-	if (list_is_singular(&crc_list.dev_list)) {
-		ret = crypto_register_ahash(&algs);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Can't register crypto ahash device\n");
-			goto out_error_dma;
-		}
-	}
-
-	dev_info(&pdev->dev, "initialized\n");
-
-	return 0;
-
-out_error_dma:
-	if (crc->sg_cpu)
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, crc->sg_cpu, crc->sg_dma);
-	free_dma(crc->dma_ch);
-
-	return ret;
-}
-
-/**
- *	bfin_crypto_crc_remove - Initialize module
- *
- */
-static int bfin_crypto_crc_remove(struct platform_device *pdev)
-{
-	struct bfin_crypto_crc *crc = platform_get_drvdata(pdev);
-
-	if (!crc)
-		return -ENODEV;
-
-	spin_lock(&crc_list.lock);
-	list_del(&crc->list);
-	spin_unlock(&crc_list.lock);
-
-	crypto_unregister_ahash(&algs);
-	tasklet_kill(&crc->done_task);
-	free_dma(crc->dma_ch);
-
-	return 0;
-}
-
-static struct platform_driver bfin_crypto_crc_driver = {
-	.probe     = bfin_crypto_crc_probe,
-	.remove    = bfin_crypto_crc_remove,
-	.suspend   = bfin_crypto_crc_suspend,
-	.resume    = bfin_crypto_crc_resume,
-	.driver    = {
-		.name  = DRIVER_NAME,
-	},
-};
-
-/**
- *	bfin_crypto_crc_mod_init - Initialize module
- *
- *	Checks the module params and registers the platform driver.
- *	Real work is in the platform probe function.
- */
-static int __init bfin_crypto_crc_mod_init(void)
-{
-	int ret;
-
-	pr_info("Blackfin hardware CRC crypto driver\n");
-
-	INIT_LIST_HEAD(&crc_list.dev_list);
-	spin_lock_init(&crc_list.lock);
-
-	ret = platform_driver_register(&bfin_crypto_crc_driver);
-	if (ret) {
-		pr_err("unable to register driver\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/**
- *	bfin_crypto_crc_mod_exit - Deinitialize module
- */
-static void __exit bfin_crypto_crc_mod_exit(void)
-{
-	platform_driver_unregister(&bfin_crypto_crc_driver);
-}
-
-module_init(bfin_crypto_crc_mod_init);
-module_exit(bfin_crypto_crc_mod_exit);
-
-MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Blackfin CRC hardware crypto driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/bfin_crc.h b/drivers/crypto/bfin_crc.h
deleted file mode 100644
index 786ef74..0000000
--- a/drivers/crypto/bfin_crc.h
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * bfin_crc.h - interface to Blackfin CRC controllers
- *
- * Copyright 2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#ifndef __BFIN_CRC_H__
-#define __BFIN_CRC_H__
-
-/* Function driver which use hardware crc must initialize the structure */
-struct crc_info {
-	/* Input data address */
-	unsigned char *in_addr;
-	/* Output data address */
-	unsigned char *out_addr;
-	/* Input or output bytes */
-	unsigned long datasize;
-	union {
-	/* CRC to compare with that of input buffer */
-	unsigned long crc_compare;
-	/* Value to compare with input data */
-	unsigned long val_verify;
-	/* Value to fill */
-	unsigned long val_fill;
-	};
-	/* Value to program the 32b CRC Polynomial */
-	unsigned long crc_poly;
-	union {
-	/* CRC calculated from the input data */
-	unsigned long crc_result;
-	/* First failed position to verify input data */
-	unsigned long pos_verify;
-	};
-	/* CRC mirror flags */
-	unsigned int bitmirr:1;
-	unsigned int bytmirr:1;
-	unsigned int w16swp:1;
-	unsigned int fdsel:1;
-	unsigned int rsltmirr:1;
-	unsigned int polymirr:1;
-	unsigned int cmpmirr:1;
-};
-
-/* Userspace interface */
-#define CRC_IOC_MAGIC		'C'
-#define CRC_IOC_CALC_CRC	_IOWR('C', 0x01, unsigned int)
-#define CRC_IOC_MEMCPY_CRC	_IOWR('C', 0x02, unsigned int)
-#define CRC_IOC_VERIFY_VAL	_IOWR('C', 0x03, unsigned int)
-#define CRC_IOC_FILL_VAL	_IOWR('C', 0x04, unsigned int)
-
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/spinlock.h>
-
-struct crc_register {
-	u32 control;
-	u32 datacnt;
-	u32 datacntrld;
-	u32 __pad_1[2];
-	u32 compare;
-	u32 fillval;
-	u32 datafifo;
-	u32 intren;
-	u32 intrenset;
-	u32 intrenclr;
-	u32 poly;
-	u32 __pad_2[4];
-	u32 status;
-	u32 datacntcap;
-	u32 __pad_3;
-	u32 result;
-	u32 curresult;
-	u32 __pad_4[3];
-	u32 revid;
-};
-
-/* CRC_STATUS Masks */
-#define CMPERR			0x00000002	/* Compare error */
-#define DCNTEXP			0x00000010	/* datacnt register expired */
-#define IBR			0x00010000	/* Input buffer ready */
-#define OBR			0x00020000	/* Output buffer ready */
-#define IRR			0x00040000	/* Immediate result readt */
-#define LUTDONE			0x00080000	/* Look-up table generation done */
-#define FSTAT			0x00700000	/* FIFO status */
-#define MAX_FIFO		4		/* Max fifo size */
-
-/* CRC_CONTROL Masks */
-#define BLKEN			0x00000001	/* Block enable */
-#define OPMODE			0x000000F0	/* Operation mode */
-#define OPMODE_OFFSET		4		/* Operation mode mask offset*/
-#define MODE_DMACPY_CRC		1		/* MTM CRC compute and compare */
-#define MODE_DATA_FILL		2		/* MTM data fill */
-#define MODE_CALC_CRC		3		/* MSM CRC compute and compare */
-#define MODE_DATA_VERIFY	4		/* MSM data verify */
-#define AUTOCLRZ		0x00000100	/* Auto clear to zero */
-#define AUTOCLRF		0x00000200	/* Auto clear to one */
-#define OBRSTALL		0x00001000	/* Stall on output buffer ready */
-#define IRRSTALL		0x00002000	/* Stall on immediate result ready */
-#define BITMIRR			0x00010000	/* Mirror bits within each byte of 32-bit input data */
-#define BITMIRR_OFFSET		16		/* Mirror bits offset */
-#define BYTMIRR			0x00020000	/* Mirror bytes of 32-bit input data */
-#define BYTMIRR_OFFSET		17		/* Mirror bytes offset */
-#define W16SWP			0x00040000	/* Mirror uppper and lower 16-bit word of 32-bit input data */
-#define W16SWP_OFFSET		18		/* Mirror 16-bit word offset */
-#define FDSEL			0x00080000	/* FIFO is written after input data is mirrored */
-#define FDSEL_OFFSET		19		/* Mirror FIFO offset */
-#define RSLTMIRR		0x00100000	/* CRC result registers are mirrored. */
-#define RSLTMIRR_OFFSET		20		/* Mirror CRC result offset. */
-#define POLYMIRR		0x00200000	/* CRC poly register is mirrored. */
-#define POLYMIRR_OFFSET		21		/* Mirror CRC poly offset. */
-#define CMPMIRR			0x00400000	/* CRC compare register is mirrored. */
-#define CMPMIRR_OFFSET		22		/* Mirror CRC compare offset. */
-
-/* CRC_INTREN Masks */
-#define CMPERRI 		0x02		/* CRC_ERROR_INTR */
-#define DCNTEXPI 		0x10		/* CRC_STATUS_INTR */
-
-#endif
-
-#endif
-- 
2.7.4
