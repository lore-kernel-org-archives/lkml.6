Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeCPHWj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:22:39 -0400
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com ([104.47.33.63]:38240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753127AbeCPHRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:36 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 11/28] misc: Remove Blackfin DSP echo support
Date: Fri, 16 Mar 2018 15:08:09 +0800
Message-ID: <1521184106-24475-9-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(6916009)(2950100002)(6666003)(305945005)(106002)(7636002)(16586007)(4326008)(2906002)(575784001)(86362001)(47776003)(8676002)(8936002)(107886003)(50226002)(356003)(59450400001)(478600001)(246002)(186003)(72206003)(26005)(48376002)(77096007)(2351001)(36756003)(426003)(316002)(5660300001)(336012)(51416003)(7696005)(76176011)(50466002)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2623;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:Svn7g2+SCRliWk4jVNEFyd1/a0TzT2luFl0BGa3HQHO5k+ykzI5YknnIS/6g2HZ3KT83SRQJoHQOU3WkXk+CgtbcvMVPR5g9z3H9Y5IU1b9ov2T5RP4V9KaNN0CuYVkV
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b812ad3-a8b5-49ce-a12a-08d58b0dfd8d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR03MB2623;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;3:KvQGrZoT7nO/GQShVMSvZhoaYBlHhVR2DJKKZf67lu8iZC0TPDgvMumVkeyc+9loapznKX0SqFsPZlvxwh80QcKlyyG+Tdqta9O80umPIcXamUv+vY/sozx6iejI//79L42A/GonPfSQFl4fC/RNBmQQXAytcpuU0MTZqe4eSXAyqFDQDyw4xTfipsMlfOFFUEQEVPpscl75QbOjFp+rKUNqlNKj7V8ss1IqFGDJamhwhTULPVBSapGS+OTrqUK9UypTnN33MMldv/maC9rWm9rWiUzzwWCYkFfTfcN29g5MX9r7J505XN236UMptiK2nGVQsVQ/xdGS/Xoz0hJtBg==;25:pY3jMH8H7J3V6uCeo1HfoPeqCgdYaS+8lNSXfQplhCXu5XBnXmsJM8ee1PsOubLHy5dZpYV0WcTxf+4bmLet19u/qeoCySUe3Y9+jZnokiGuzkpCOLYjE1/1YE/GLaueUM3OulmR8UpnyeWCoU3XJjHQnogDPGstP+Xu+mOmOxAgY70dxsVe6u5pWpcvrRKlXR+Q9mVYKEJBvs4Berb67pPB/FCbiDzH5jkTYuB7DKpg8jwPCfzQYvBCmd9n4pFw3TbXBI/CAY+0U1T8z6+H88CwPkCPQarUnFXcuWx1TdqcgjQNv+126q+LL+bKLyku1Tes9ZErMJXiLZXO4dTmug==;31:lopjyorYxorj1aCvQm2JKHcLRE9xNshIaK2HaTu3ujuAzjR/k6atCHN9+CAaDcy9jSKYt3CdmQJO8tIEDuoyKdFnJpV88+LzEK7z+pZTezNvw8E3DTe93bNma7w970nuU0/WUGfsS+rBqDul8rUPoUwD8Qcwvs9fzYo3FlYqZqWQBEC+of4pAKx69LG1P3Ef0L4keG0OqfVj0pG4SiEjbl9LQej8Qxaz6mKOTyCHsLw=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2623:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;20:UR8ISA07Q+pPeF7wcK2kcs+RH/gw55P50JtkJijp9czU8qohwwAhqctCMp7Zmo3mDUvoIKTBaQLPf1SRwSfKo0UeF2FC6jq6gZQnJiVxTaDkCIomMoqMqo1OVVMw8Ka0m5gxcAnlvzRvBlkjBWQ+IoDkBOaxasyhdgTHD+IkyBfwthuNvxEzoWsLGs//Ka6hhbHpffQ4URu+Y90Dw/Z8MAAl8+mFxYncK3a8OkasAV6RbyafCoJOMaHyy1Gn4AsUTJbyxXfRrPihV4cC+xlrfpOiA20P5qJukyuNf2bAUqMkUYNhkOnMGWdmaWNbbij1H8+4PTjroaBuqq791i+1ZQsloN6/pK7FHrrBSIL9YWFbDUlBDOhyXBL7ZV4PF5kVkGAi5W9vh7rrr3XV3Rjp6CkZRq2/afbs1T3dTKIg3L2ySZL5XLHwW8FZVrnyineKtFeP9am58DMZkcc5smQhwb+vtaj6UomzEzvFxKSzwf1mgg1bOEHLuxM/ixiUmRuR;4:lSCC1JQ2LXy/nj6SNtfyrYtBNdqVPs2rib41eD18uXRuL0XdtJkxDZ4MVMlAOHUXsdJMvq/pz/bAsF78sX6c6QgUvQskCBj2KGhuENocH3t6y/oKiX8Taa3ZTsKawx92BV0emoamzPlUyKl+16n5BMwyuGe8GQzaBfl4o8nRNwOFlEwAeTw/1xG16yEEh6/q0SNOXT5ip78jA+SCVtl2qQRrcQhQZIHzeRkqRhu87jXPT7E6O0Tt3eHMbtAF+9R0tg10unlYAOBMzaY9pzlTEk4ut2lB5KW3nxZIeaYHrV5aNtOR1q8pHYHJUbFp83x7
X-Microsoft-Antispam-PRVS: <MWHPR03MB2623F2C0D725F968C425C397E0D70@MWHPR03MB2623.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR03MB2623;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2623;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2623;23:kY/ZVP8ohfXAc2SGAohCq/idIUzWEfl//ozlntq5F?=
 =?us-ascii?Q?Nk7kRyU4HwvOct79ORRqR32lRQ3BZerfKSpVSLb+HZbOGjtzeFhzlQMrMPVz?=
 =?us-ascii?Q?Qv0O4igsY4RyXI8eYATz3hVHoUlWLKfTgSS0ear45Wa+F18HP1kO1x6tH/Ig?=
 =?us-ascii?Q?kqP1YLYFad4GeW0qJdHHLvFFl2JAeVDxllu2lwmNpW5+qgHpZv7vplYVdZhJ?=
 =?us-ascii?Q?X9XsVzxxzxp4ez7/GGHb68BSLxUf7IdzryE37nK453C1KkRd9ces0C8PH7Xi?=
 =?us-ascii?Q?TxObQn7YcY2Vf6SKZcFcXgM7WX4E4dVnb99E3mo6TDq3BYwO2MD8TshAEqPK?=
 =?us-ascii?Q?FgfdutvVp0r5XeAIDxYd48fIBm8tpAXAOxzx+VJ3M+ubpcNPjlI7gccqrV1J?=
 =?us-ascii?Q?g9NBxQaz5jFHaYWaTGGSE4SrZ+BtJniQR3IpALZVN5679liggh1evHr1CgVy?=
 =?us-ascii?Q?+C6Kb9Zzpgcfyae81HENSJrN5/bFcOrB85qo/GtYZkJcj87ZE22mB8SgC9EJ?=
 =?us-ascii?Q?UpbYd2jW2mceYsx/555ou+41tCIlPfPthRSR2YVCITHZWhXR5vJoKoIIFnAE?=
 =?us-ascii?Q?vV1yy2e63eQAsVIM48/47505gdQFM/41oBAaHMqba76meehbFlSotUUu99R/?=
 =?us-ascii?Q?YSU2LByiXKYZ3tbAIygW629OBHU8DoaSjWmGkW1wpX/evMDbdzOiPd7YzPZj?=
 =?us-ascii?Q?dgNESaczXnqvK3mvYou/XzTNYiBQzrtURdZeDx1bNcecDFzusC7QR5GsdvC/?=
 =?us-ascii?Q?+BGSwqZ+iZ2WU6/zu8oL8UQ+4zRg65bHYkz3GxOrVU3pCrUVYO6yb1+hJTeL?=
 =?us-ascii?Q?AscKhwCo7jaFfnJyLffeZbiWcebiKDcw7AYetNL/G7is8dRJrkBJQjmreQGF?=
 =?us-ascii?Q?bswwO4qISHLmKPDyOMG7P2AgdKSG6bBx3odxUdu48iax3i4a1HqvkUo00OPz?=
 =?us-ascii?Q?MhT5T+iRCtii+85LugJILPLZ4FZ9vrypu5fmLJ+du6IpBdxxqLTczlsl0QqR?=
 =?us-ascii?Q?TgxEQz5DaPkIEcDHdQn4Wm+zIJlti4/7uF8+ttEdBBnzA=3D=3D?=
X-Microsoft-Antispam-Message-Info: v+zv0eTxfwIx0zusPvpu75ZG+dZPuXltqpCbdrXTPXCEUaThdxB84vNz5ro7Ie8CmYEswD3C/RNBC/r9fUt52oyvb1PM1NRC/t4W555vPuwyGlJLBaMuMEm72UAQ5sgNITZz0M8alzm8vXDVhAM7MoGFjDw4D6QkjREZK4ZWSZfXjNLvQAZuM1iC2FsLDJQg
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2623;6:79hMkf3qjI1Ch97gxSeUPhavD7GJw/W0Jf6vT5oNI5dSOv1iemwp41RVDdtxkXnxqt1ydafUSw4Yk7C+78QOG0SFpIR6bfklkU0JxYxR7//c8W+aeBiGvvL2ZjylUBdEsgQ4OGLgsQn5HGPPL0YGB/OKw8w0IhW0mwlIujQwZzlBmAN7tzwc+fBQFKQLugqhuLSoDq+/woDCiSb6dycjHLzwI98k20pHUa7wBbLtfiWkzcPIH6tVk9qFys9sX3is9nB01VPndwGUVZ1wrH/MNaZNgu5MfAfQIlsGP0Vn6PZ8JXRN2Ep9VyrIT7dK9TDBwaI1D3M6uYxwQyywQbFwmKNTXSGUVmLvB0h8pyHG6jc=;5:1P4bxjnp5wpx++ndOhGJ84ZxPQLQTtCIabIL86SogErWI5FjQwJ040SG9QIyd2LloGtIn1edezFdMxCyI9tnNrlLFF9kbTXhpwov15wPItDGYacRN0jpKF/QSiA0L9XFgvS2G8zmeGs9sox1ciuOurlr+HZuFBxQsV1r01NAKHE=;24:OuzT61krrmM+1sE+0k4+gU2DUQZwamL50C6Bkt9RO1eWEdpbV3Puk4E2U5Oil7+SShlcEqmhgWRiXDDjmeLoojkevGr1LzoeZqBF5V4d8r4=;7:dABK4u3cx+xJtwPY4dm9aQe2VPWyIjUbOBmDlwu6nozLZIkJsW0xiorO867YR3Bg9YUt4X4a4pXChbutSEKfRzD/pCV2f0CAW/O4AiGmHStXikG3U/mkslmObu6RqmszS8ypUsaDrYo7vxhZG49QS8uAc61CVBIoOCuyfamL0L5eQtM4FGkYtC2cCz0VmrknOssH6pg42FV7nomrwPNd8Sxuj8C3xy5mIEI3uDEuigsmCqR55L1TKinP2C7QxA2a
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:34.4738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b812ad3-a8b5-49ce-a12a-08d58b0dfd8d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2623
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin DSP echo support
---
 drivers/misc/echo/echo.c | 73 ------------------------------------------------
 drivers/misc/echo/fir.h  | 50 ---------------------------------
 2 files changed, 123 deletions(-)

diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
index 9597e95..8a5adc0 100644
--- a/drivers/misc/echo/echo.c
+++ b/drivers/misc/echo/echo.c
@@ -115,78 +115,6 @@
 
 /* adapting coeffs using the traditional stochastic descent (N)LMS algorithm */
 
-#ifdef __bfin__
-static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift)
-{
-	int i;
-	int offset1;
-	int offset2;
-	int factor;
-	int exp;
-	int16_t *phist;
-	int n;
-
-	if (shift > 0)
-		factor = clean << shift;
-	else
-		factor = clean >> -shift;
-
-	/* Update the FIR taps */
-
-	offset2 = ec->curr_pos;
-	offset1 = ec->taps - offset2;
-	phist = &ec->fir_state_bg.history[offset2];
-
-	/* st: and en: help us locate the assembler in echo.s */
-
-	/* asm("st:"); */
-	n = ec->taps;
-	for (i = 0; i < n; i++) {
-		exp = *phist++ * factor;
-		ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
-	}
-	/* asm("en:"); */
-
-	/* Note the asm for the inner loop above generated by Blackfin gcc
-	   4.1.1 is pretty good (note even parallel instructions used):
-
-	   R0 = W [P0++] (X);
-	   R0 *= R2;
-	   R0 = R0 + R3 (NS) ||
-	   R1 = W [P1] (X) ||
-	   nop;
-	   R0 >>>= 15;
-	   R0 = R0 + R1;
-	   W [P1++] = R0;
-
-	   A block based update algorithm would be much faster but the
-	   above can't be improved on much.  Every instruction saved in
-	   the loop above is 2 MIPs/ch!  The for loop above is where the
-	   Blackfin spends most of it's time - about 17 MIPs/ch measured
-	   with speedtest.c with 256 taps (32ms).  Write-back and
-	   Write-through cache gave about the same performance.
-	 */
-}
-
-/*
-   IDEAS for further optimisation of lms_adapt_bg():
-
-   1/ The rounding is quite costly.  Could we keep as 32 bit coeffs
-   then make filter pluck the MS 16-bits of the coeffs when filtering?
-   However this would lower potential optimisation of filter, as I
-   think the dual-MAC architecture requires packed 16 bit coeffs.
-
-   2/ Block based update would be more efficient, as per comments above,
-   could use dual MAC architecture.
-
-   3/ Look for same sample Blackfin LMS code, see if we can get dual-MAC
-   packing.
-
-   4/ Execute the whole e/c in a block of say 20ms rather than sample
-   by sample.  Processing a few samples every ms is inefficient.
-*/
-
-#else
 static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift)
 {
 	int i;
@@ -215,7 +143,6 @@ static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift)
 		ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
 	}
 }
-#endif
 
 static inline int top_bit(unsigned int bits)
 {
diff --git a/drivers/misc/echo/fir.h b/drivers/misc/echo/fir.h
index 7b9fabf..4e0f365 100644
--- a/drivers/misc/echo/fir.h
+++ b/drivers/misc/echo/fir.h
@@ -27,14 +27,6 @@
 #define _FIR_H_
 
 /*
-   Blackfin NOTES & IDEAS:
-
-   A simple dot product function is used to implement the filter.  This performs
-   just one MAC/cycle which is inefficient but was easy to implement as a first
-   pass.  The current Blackfin code also uses an unrolled form of the filter
-   history to avoid 0 length hardware loop issues.  This is wasteful of
-   memory.
-
    Ideas for improvement:
 
    1/ Rewrite filter for dual MAC inner loop.  The issue here is handling
@@ -94,21 +86,13 @@ static inline const int16_t *fir16_create(struct fir16_state_t *fir,
 	fir->taps = taps;
 	fir->curr_pos = taps - 1;
 	fir->coeffs = coeffs;
-#if defined(__bfin__)
-	fir->history = kcalloc(2 * taps, sizeof(int16_t), GFP_KERNEL);
-#else
 	fir->history = kcalloc(taps, sizeof(int16_t), GFP_KERNEL);
-#endif
 	return fir->history;
 }
 
 static inline void fir16_flush(struct fir16_state_t *fir)
 {
-#if defined(__bfin__)
-	memset(fir->history, 0, 2 * fir->taps * sizeof(int16_t));
-#else
 	memset(fir->history, 0, fir->taps * sizeof(int16_t));
-#endif
 }
 
 static inline void fir16_free(struct fir16_state_t *fir)
@@ -116,42 +100,9 @@ static inline void fir16_free(struct fir16_state_t *fir)
 	kfree(fir->history);
 }
 
-#ifdef __bfin__
-static inline int32_t dot_asm(short *x, short *y, int len)
-{
-	int dot;
-
-	len--;
-
-	__asm__("I0 = %1;\n\t"
-		"I1 = %2;\n\t"
-		"A0 = 0;\n\t"
-		"R0.L = W[I0++] || R1.L = W[I1++];\n\t"
-		"LOOP dot%= LC0 = %3;\n\t"
-		"LOOP_BEGIN dot%=;\n\t"
-		"A0 += R0.L * R1.L (IS) || R0.L = W[I0++] || R1.L = W[I1++];\n\t"
-		"LOOP_END dot%=;\n\t"
-		"A0 += R0.L*R1.L (IS);\n\t"
-		"R0 = A0;\n\t"
-		"%0 = R0;\n\t"
-		: "=&d"(dot)
-		: "a"(x), "a"(y), "a"(len)
-		: "I0", "I1", "A1", "A0", "R0", "R1"
-	);
-
-	return dot;
-}
-#endif
-
 static inline int16_t fir16(struct fir16_state_t *fir, int16_t sample)
 {
 	int32_t y;
-#if defined(__bfin__)
-	fir->history[fir->curr_pos] = sample;
-	fir->history[fir->curr_pos + fir->taps] = sample;
-	y = dot_asm((int16_t *) fir->coeffs, &fir->history[fir->curr_pos],
-		    fir->taps);
-#else
 	int i;
 	int offset1;
 	int offset2;
@@ -165,7 +116,6 @@ static inline int16_t fir16(struct fir16_state_t *fir, int16_t sample)
 		y += fir->coeffs[i] * fir->history[i - offset1];
 	for (; i >= 0; i--)
 		y += fir->coeffs[i] * fir->history[i + offset2];
-#endif
 	if (fir->curr_pos <= 0)
 		fir->curr_pos = fir->taps;
 	fir->curr_pos--;
-- 
2.7.4
