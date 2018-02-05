Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeBEOXd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:23:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22943 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeBEOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:23:17 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205142315epoutp0476dc69d72b05cd811aa56d3f1deaf011~Qc-rnfNLD1852018520epoutp04b
X-AuditID: b6c32a35-879ff70000001031-97-5a7868d2b5b2
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 3/3] clk: exynos5433: Add CLK_IGNORE_UNUSED flag to
 sclk_ioclk_i2s1_bclk
Date: Mon, 05 Feb 2018 15:22:30 +0100
Message-id: <20180205142230.9755-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205142230.9755-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmru6ljIoog0sbVC02zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CV8eHEJbaCaxwV33bOZGlg3MPexcjJISFg
        ItFwYxITiC0ksINRYt8WQwj7O6PEp7tOXYwcYDW9xwS7GLmAwhsYJa7NmcwE4fxilPi15AkL
        SAObgKFE79E+RhBbREBW4taxn2wgRcwCM5gkrnRuYQNJCAtESXw98R5sG4uAqkTbhaVgzbwC
        VhINN7czQlwkL/F+wX0wm1PAWmJ3yyN2kEESAkvYJP79XwFV5CLxZO51JghbWOLV8S3sEKdK
        S1w6agtR388ocWJNMyOEM4NR4k77BKgGa4nDxy+ygtjMAnwS7772sEI080p0tAlBlHhIXJx4
        EhpEjhIbdm1mhni5j1Fi4bszjBMYpRYwMqxiFEstKM5NTy02LDDUK07MLS7NS9dLzs/dxAiO
        Vy3THYxTzvkcYhTgYFTi4Z2QWB4lxJpYVlyZe4hRgoNZSYTX6TpQiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG9AgEuUkEB6YklqdmpqQWoRTJaJg1OqgTE4/OJHiY9zw1h8sxo8F3nZ1U2XTBPy
        i9zyyfTXNCWGbQyskTubum2mVWcu2nxd1n3fIVFj75aco3Vm7vlPgu/Ede+a4Pa5cYeGwRST
        0MzNF61s118qOjjrgePBs5/01xTd2fAsq2N5WzGzvm1P24NbEcc6tUPbO6utM4NrrQ1OfGGW
        k7/bpMRSnJFoqMVcVJwIAI5jlqLTAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd2LGRVRBjsWWlhsnLGe1eL6l+es
        FpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhaH37SzWvw4083iwOXx/kYru8flvl4m
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr48OJS2wF1zgqvu2cydLAuIe9i5GDQ0LA
        RKL3mGAXIxeHkMA6Rond87pZIJxfjBLvvs9l6mLk5GATMJToPdrHCGKLCMhK3Dr2kw2kiFlg
        BpPEs6PPWEESwgJREl9PvAdrYBFQlWi7sJQFxOYVsJJouLkdrFlCQF7i/YL7YDangLXE7pZH
        7CC2EFDNlEmTWCYw8ixgZFjFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYYNsOa/Xt
        YLy/JP4QowAHoxIP74TE8igh1sSy4srcQ4wSHMxKIrxO14FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1ME7jjvu3Y6//maU3dhqEqkrPCnt1W/34lXaz
        xYqRE6/2Rf1ofz196e6yI48n7zg11zvr6lWu7cYHFVeayG/x6DlZklS/uu1e1f3Kuus3Zquu
        4HNIaF+611/UZWXs4ndP7vnYHe4wOKj3ryfmF8PbS/LLHM0/mS50XWLauM4wu7Pr/c3ZH+v/
        ZvAqsRRnJBpqMRcVJwIAE5VdaywCAAA=
X-CMS-MailID: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
X-RootMTR: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sclk_ioclk_i2s1_bclk clock is not currently handled by any driver
and disabling this clock by the clk core prevents proper operation
of the I2S1 block. CLK_IGNORE_UNUSED flag is added as a temporary fix.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index d74361736e64..15177f74e125 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1680,7 +1680,7 @@ static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
 			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
 			"ioclk_i2s1_bclk_in", ENABLE_SCLK_PERIC, 10,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "sclk_spdif_peric",
 			ENABLE_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "sclk_pcm1_peric",
-- 
2.14.2
