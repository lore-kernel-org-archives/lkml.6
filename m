Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6493EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D330A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lP2Bg7/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D330A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeGaSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:44 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:28281
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729691AbeGaSon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPzc7KZsGTUsShaX+LOdqfJN7Z6Qvpj2rJ7r825rngc=;
 b=lP2Bg7/mpgTFdYzUWKyR7R4+h7mhxKFZPKDr+tiG+b1Ea0bqLyjc/jYy2SQVXKD44jqn9ApAM/DtO2HVVr3kQ5OGDuvkG4PGPmRv69GZfMYAE1MEZs+HzNR5j/sBCzDwdZ3lmvTYPUlYcTpjZcOz/bxvAXXJ+3ihRYaRXCQTrGA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM4PR0401MB2354.eurprd04.prod.outlook.com (2603:10a6:200:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 17:03:22 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     ruxandra.radulescu@nxp.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/2] staging: fsl-dpaa2/eth: add SPDX license identifiers
Date:   Tue, 31 Jul 2018 12:02:47 -0500
Message-Id: <20180731170247.11784-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180731170247.11784-1-ioana.ciornei@nxp.com>
References: <20180731170247.11784-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0030.namprd15.prod.outlook.com
 (2603:10b6:805::43) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e87781e-60c2-4e82-77d3-08d5f70786c5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2354;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;3:ITBQJfQbeA4+sER2G2N1JNbUGhz05jmlar8wR+yCJRHD0q6gvRnxPTOCap+oiWEC43OBnynnWSpHYYGr7rLQh7E0YJA9aLQmptwas/dlDA1HkE5YGjKGNZ978vx88KpTlsCwfOin4EZEgde4Ympg/YDc9v6494cUjbfspnE7yIqNIVdz8FyUCn/jI8+85qHOZOViAFwqH2Q5p10oiGWYWwhDwHIO6un4lIdO/vA3JsTCSCAcOYU7s+/e+N7royTI;25:f+j0vrCKvdwvpKXsOwONL1rjwzuB+PLJdno7LMK/ioHgckpD6Dqx2XRsTL80LuNiiAGTyxAHlrdLhdd2/zmazgCwo9O4f+G8L2pHeodEnuxBsmIKz8Y7/GcOtC5LxKUyfCgxUlxf2soK9mQpJfox1DV0iJtIBRged9znBRCnYaekp2S89OIa0dVXE4JIzlpRXGjB9W+CDA0qQ1Z7DW2Gp2IuT6UfY4v3h6hmaiGv6k2VRdzFdw8hgIBKSCihuP/ozKWnQtNiFaFhvBjxlJZRkU4F75IkkPTG4fAejEKWz+6PCMF7QnUq93y3RJavc2IDHTgD6NBW+llJskPk+ezjOg==;31:AqAZJwYi4sk05H6XYqYZkIFR14zudUzBC3B/lgfqPBuqcRfmzWmiqs1mNVJ8fvAcdb7840ds+tWcQdWsmLiFqOCpNz1ccQgXFOEMqWgCe98Wc8uEhCGlBaR2IPjlP2h0952CCN6R/Xbbs9Z94ghUMB0QRk0NIg4NcymlTENJxsvgZf7D2qTTKn2ZyHJHc2aYrL0gDt09m/HgimEycAAqAOgMUCwya5/AW4SUgTbCxGw=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2354:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;20:1dN4YAegXNZyTmLbHJDNJ5RJWQdp99frozZ50H+ZvWXdz8la5jkN/sFhFSVEtBriKjJEN2HK22xziUn8DAZlGPy+WFdnl8o98T4wO81g0l7g1JWWn0u+Ddm09RpIVQ3jF5QCe3dukaxPMHcopChenIJ8/jw5rUx+1v0HXaNVuBgEw3cPSmRQsHzEJhrNa7KZfzbJ27DNzkP8BZ33/Oc9LPdN1ZUfv6bXtsxMYBlYxPj312nr37o9D9PBcnva4ArtM6VqpzB0Q2zOxjCH9G7zBQ47frK8fwjlN87PQvnwOEQq0eqeFn5iXo550Chw0cnsN67u0WAJ04pqlkePJe4JoMNSEv1CoI5/hzbKY00hWVpScyyJR3E5IEuBKdh79zXj7X196eS8iKYkO7HJL2s5vzrA3YuNmSHN6jKaCOXdEgplwRghC2lYPfUnydljahEU2RGk2bDbL0I8GWU3AYQTqfHAdWkchI1rtVz7SyKrI39rpfQAbCtt1kFCKHeUX15S;4:Q7JxhUj/tBidiwP6NNaafMOhUaOqDb8jE7J3gAww+cqgw/x/w6fws+4wJCDh9gNK+AyQ2+WP+65jQdlmMTyr6tl7ht4QNFq+Kq9+vroBxVEeSuEo7wvR0qj8qr56RAH/cZ0gag+O/SvYwnhedCtplwhS7/2EnJzhAINQfOlEe829A3CJrts1sudTKY47pz/G1azV69s7NkvdGBq0U+LWa2uG43U31z1IqfRmsmShNQXnuUqImr9iK3Y7Q43Yu8vMeHl3DWrG6eC4frXKJw20MTZgYzmUdH41ievpP03j1PnQlrvLbsZBAKoHTI0sUOpb
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2354CF1A85F95DE40852C795E02E0@AM4PR0401MB2354.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB2354;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2354;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(106356001)(386003)(36756003)(3846002)(6666003)(81166006)(6916009)(2361001)(6116002)(16586007)(8676002)(4326008)(316002)(50226002)(8936002)(81156014)(1076002)(5660300001)(2616005)(478600001)(44832011)(305945005)(47776003)(53936002)(7736002)(25786009)(186003)(26005)(52116002)(66066001)(68736007)(50466002)(6512007)(48376002)(97736004)(2906002)(11346002)(14444005)(956004)(51416003)(6506007)(86362001)(446003)(76176011)(486006)(2351001)(575784001)(6486002)(16526019)(105586002)(476003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2354;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2354;23:V9Uxou/KGMF3/gk5RotaB+4bmxciggTnH5WdLiK?=
 =?us-ascii?Q?/phUe0yE+XLS6sIL2J5gGVP3DKbCHFMK+eZkWPFfG9Nq2HU4q3At/rBO0fmG?=
 =?us-ascii?Q?ZWISuXDYHb2qWby6oZvDSwVB6LCW5DxAQedSXrh/d9+bkSx2bIlMguUCIWs2?=
 =?us-ascii?Q?dhKnzffHKtUnCaUXf0Z72TVchsrDMTZH0+nUt4kL86WX8AUkC8S6cshWvhUs?=
 =?us-ascii?Q?U1cz8WoDI2a23sn3U8SnzwepdQXF7R7KffbPlyppQ7E7SsmtxVQBZ5afKly9?=
 =?us-ascii?Q?yHKYQTsox2nKEaUltC33kb5PV8VV8ASEXZ+un2oAB6jnsAMlr1wRpCEVzYtY?=
 =?us-ascii?Q?OcccaGmxvHAW45jKFvPX2e1EotMHVCnrTXJHQq8f7tDyTXpMipXeVWNBZOgv?=
 =?us-ascii?Q?NgcHwm1WYo2UX/TNnDIlNK09RzWzpszn2v+N1H2+wDLpq7H/RRZGiRxlrfyt?=
 =?us-ascii?Q?04/PndDbK+XXj/Lo6JRQvNVBTd8MtMaoAeLKZkad6oOHMhbeiApdGzDMmViy?=
 =?us-ascii?Q?nnkMz+c+PQjzSV9TOt5zQaue1Bly3OExrMpzr23xSD4jfVBk+b1G4BGBnBGV?=
 =?us-ascii?Q?y7X1hS1BLRPwHy96l2RpWsODnnJOgMHY0W6unrSe0glKLaE6nfzUtCQ4UYir?=
 =?us-ascii?Q?OA5+C5er8btOLELEJgHEl6FGG+iRCIuDF3R3Zw1BjM2vSfRFjbNLhZrY/99Z?=
 =?us-ascii?Q?7AR0zj4eN4+ujj8nGsp1IzmboXhXUNZh9LZHqYnQ1AxcEPHjN+oWMgAD0Bwx?=
 =?us-ascii?Q?CtO6xOGvnruRmrecDbJtJfvQ6b4dAGTw/rHjA+NT/ZDlckN8VllbMJvZ7D/z?=
 =?us-ascii?Q?AwzNGAbCMmU/XeeX4H/gQcyq2bfCoccM1TkoOUjGGXWZJRQAufFAiuJKZWjW?=
 =?us-ascii?Q?pTI58/f7BTaIyW29o1nwHCKcTq5WZ/YyZorM+FFECMkfEB/UfGjDtBAGs0b1?=
 =?us-ascii?Q?bOz1gQhpYpkq0XWz2T6VBqEX/eRcgsNxKOJShp7niLybXy52/5rq+0tgCjlk?=
 =?us-ascii?Q?wc8rSwExMAWBUXN2Uf1PdKP0MXtJZsJ83qt5KPxzPude6+3oRAyald3YctPK?=
 =?us-ascii?Q?SbOfULsiil7rHZsvdJRrYT27o9lFlJYeeq/hTmWKEBdBMupR0JXwMFp+nwO8?=
 =?us-ascii?Q?IsreZqlAAuzdt+Z/AkoFHEaKEYJaJ/hwcTeAPNlBBJTCrOvV8hC3QEh8kI2m?=
 =?us-ascii?Q?ZRZTGOQm1pMu9hXGV06ROfBGtNyoBqY6Jf6QO4mo7RalSyZ6xX30okQZLYKz?=
 =?us-ascii?Q?fJejS+Xz0IBXAx4dScg8BLc4XeATzytYoVpqVaRF/KQbCOH3l5Dwhc00n5nq?=
 =?us-ascii?Q?TPU/qofvdG8TzKzAFxZ5uTrA=3D?=
X-Microsoft-Antispam-Message-Info: m9Tjy9QsfN+lyHsycHu6vcT0vgbfSKt5g5oru8tACAk1QtGMsuhzPOrl+BIdOIRl/Hn6IgZ0tAM07W+gIhChxbIAeHabYj1kp29OaVblDe6l4AZ1CRGfCm9HL6pzOXncaKFTymEOpRA3jcKgfCRHIttSR+CqabobgoCk/XyYejb5xdf1kUbyBNUy6ckYqRQFkjsTxfTZpp7aRfZlCnjHxcdyUiQwD6qWHHumPBCgcDC8op8QM3HeQgRDmZR9St/yxwYBFC1HJASB+/FmfF1RtFnw8TE6OKXTJBOePAJregqQ6dovNUjAUtvJuwH2FcYIvE9pUoLPRnax7sUb79IzSzSS2s5up1FpLXelyTGQ38k=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2354;6:eFj+JzvnVd6+tNgK0MK5IfhvkyPpK2liwBBCC7AONMOc0/xWNCA9j/ffv7J11IrFnusnPC0TMkc6zfr/uIuDO2BIaRqyxxvu/cY38A1bs1k6sNwXP0q6bwTT0wCSM8LZhnGtBGgHLoI7qdt6bF7vNNQ629c4gkQOrZXIpYr2uvsgt0FQgXhHaRVL/ukrmbRtMAo1lnsIT77MBG2I+v8oraKBDbwnKZAOK9kLDVFURrXuobZ2qtbWL2DzD+puBuG2b6rgNbDR3Bi4jc50hOj6T5P6LVyeiJuF/cgLrIrWNcszADU1dmfvovyV/Z6STs/X24tkL35mtZbVXrFYSNzaYcHMrBpfcAYS6DyMcBr3dnpNB+yoY+SbANJJIxdcYBG11D/3jxSCsu33lx/fhpTDd7+5Dv4hcT3u6x0KMn/dj76iDbWFdsEVSi1T1jcHgRhFL4XXAegoQAfTGk+e2TqMPQ==;5:aMUAp9LAKzIkdMHfvwUrc3Tt3wG1aqL/r/uY+4U12pOYzlDl5GSsbIGC/lQik9LZUnTcewwUM18Bf3SOjLPWk1iiq6zX/BC2q8nET0xytA9Jc24QfNn8f73f84tTrrLbB+gFHlpCgncsKS1ZUMD4gmIfCmTAmAwWK4wMnX9SDmA=;7:/CNvxxK9z3+7flpbzIQQTgbKuhkQb9AYf9JgbWshB//WVM8J0OUduE0D37CS3EZISmssRM97BUoB2pvRA1QwWqrcyDh3FMZdQA8Qb5pKG70QFud8rruTfufat8uZQ/LywqkSKQtTM4caJ0q0UESD83GdFAyNL0LKzjQv3/TvFeOdRB5/AhbDMhNQNcHnZOLUb6Y+mA6YYpxHlTjG5bFKcfaQLEp/4x1zmrWsw7qU4zuwXrd8zNpnaVvhPUiYwiG+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:03:22.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e87781e-60c2-4e82-77d3-08d5f70786c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPAA2 Ethernet driver files use a GPL-2.0+ OR BSD-3-Clause
license. Add SPDX tags and delete the full license text,
keeping the existing licenses for each file.
Add a GPL-2.0 tag for the Makefile.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/Makefile        |  1 +
 .../staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h   | 29 +--------------------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 29 +--------------------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 29 +--------------------
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 29 +--------------------
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h          | 30 +---------------------
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h      | 30 +---------------------
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          | 30 +---------------------
 drivers/staging/fsl-dpaa2/ethernet/dpni.h          | 30 +---------------------
 drivers/staging/fsl-dpaa2/ethernet/net.h           | 30 +---------------------
 10 files changed, 10 insertions(+), 257 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/Makefile b/drivers/staging/fsl-dpaa2/ethernet/Makefile
index 77b0b74..9315ecd 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethernet/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h
index 3b040e8..9801528 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h
@@ -1,32 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2014-2015 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #undef TRACE_SYSTEM
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 41dd6d88..e2dac44 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1,33 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 6cf8a4b..6b70c66 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -1,33 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef __DPAA2_ETH_H
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index 8a3c3da..8056a95 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -1,33 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <linux/net_tstamp.h>
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
index 8057a25..099ff02 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
@@ -1,33 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2015 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPKG_H_
 #define __FSL_DPKG_H_
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h b/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
index d6f96f302..83698ab 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
@@ -1,34 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef _FSL_DPNI_CMD_H
 #define _FSL_DPNI_CMD_H
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index 1a721c9..d6ac267 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -1,34 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.h b/drivers/staging/fsl-dpaa2/ethernet/dpni.h
index 8eef4ee..b378a00 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.h
@@ -1,34 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPNI_H
 #define __FSL_DPNI_H
diff --git a/drivers/staging/fsl-dpaa2/ethernet/net.h b/drivers/staging/fsl-dpaa2/ethernet/net.h
index 5020dee..75a2d3a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/net.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/net.h
@@ -1,33 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* Copyright 2013-2015 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_NET_H
 #define __FSL_NET_H
-- 
1.9.1

