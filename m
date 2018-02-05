Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeBEOXD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:23:03 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:18823 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBEOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:22:56 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180205142254epoutp011fcda3a7b5437e7a0a5c5bcf1b0bbf0e~Qc-Xc0bF81349313493epoutp01f
X-AuditID: b6c32a36-ca9ff70000001028-96-5a7868bd4caa
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
Date: Mon, 05 Feb 2018 15:22:28 +0100
Message-id: <20180205142230.9755-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCmnu7ejIoog5fvWS02zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVMfHhecaCHZwVnyYcZ2xgfMLexcjJISFg
        ItHe8Zali5GLQ0hgB6PEkoYGVgjnO6PEu4kf2GCqLl3YAJXYwChxeWsjM4Tzi1Fi3o8lLCBV
        bAKGEr1H+xhBbBEBWYlbx36ygRQxC8xgkrjSuQVslLBAtMSfT/OZQWwWAVWJC1v/M3UxcnDw
        ClhJvPqYC7FNXuL9gvuMIL0SAj1sEj1fFjJDJFwkbm2bCnWSsMSr41vYQXolBKQlLh21hajv
        Z5Q4saYZqnkGo8Sd9glMEA3WEoePX2QFsZkF+CTefe1hhWjmlehoE4Io8ZD4cm46K4TtKPH+
        3wKwx4QEYiWufbrNMoFRcgEjwypGsdSC4tz01GLDAiO94sTc4tK8dL3k/NxNjODI1DLbwbjo
        nM8hRgEORiUe3gmJ5VFCrIllxZW5hxglOJiVRHidrgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8wYEuEQJCaQnlqRmp6YWpBbBZJk4OKUaGL0PNs45z89uuV7S/u5SmdnmQhvEejrvLBLr8Dhl
        7sjiZJXFIxsu4/DTK6Awvy/+pNmmo4y/rh37FDFdLO5PyWf+Z/9FHvL8/p7yS/fMPauOVUaO
        84zfbdo2//KJ0h3rPgsfNnzhnndNMd1yvRFT2OH5qgEqfRsyL12YkZa513L/07epgreXZSqx
        FGckGmoxFxUnAgA3R8KgyAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xoO6ejIoog73bpSw2zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVMfHhecaCHZwVnyYcZ2xgfMLexcjJISFg
        InHpwgbWLkYuDiGBdYwSP6bsZIFwfjFK/O+YxAZSxSZgKNF7tI8RxBYRkJW4dewnG0gRs8AM
        JolnR5+xgiSEBaIlTjycywRiswioSlzY+h/I5uDgFbCSePUxF2KbvMT7BfcZJzByLWBkWMUo
        mVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERgw2w5r9e1gvL8k/hCjAAejEg/vhMTyKCHW
        xLLiytxDjBIczEoivE7XgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1I
        LYLJMnFwSjUw5rNUfFp2W/qJxo/dNjJr1p5gdT4gdv6f6FJ2T7sd1oeucnOd/HRg1ly/r8yT
        a+ZM6WA7nSK++E/ErEvNFstPVH8L7v494eOsBy+f7Dp+roVFTfX+zPdnTbcf3Xr7UL7Ca32B
        Kz8bMoWehn1bePTrxVMBHuxnqqwvKK1XzTwn/tXTIantZ93OA25KLMUZiYZazEXFiQDkeDzm
        FAIAAA==
X-CMS-MailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more definitions to the exynos5433_aud_pll_rates table so the
AUD_PLL can be used as a root clock source for the I2S1 and the HDMI
interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index db270908037a..74b70ddab4d6 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -765,6 +765,14 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
 	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
 	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
 	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
+	PLL_36XX_RATE(200000000U, 200, 3, 3,      0),
+	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
+	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
+	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
+	PLL_36XX_RATE(100000000U, 200, 3, 4,      0),
+	PLL_36XX_RATE(65536003U,  131, 3, 4,   4719),
+	PLL_36XX_RATE(49152000U,  197, 3, 5, -25690),
+	PLL_36XX_RATE(32768001U,  131, 3, 5,   4719),
 	{ /* sentinel */ }
 };

--
2.14.2
