Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeBLPwp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:52:45 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:15767 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbeBLPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:52:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180212155240epoutp027734bfaa39831f7ace37acc6f818d1ad~Snuv8ETM53216032160epoutp02D
X-AuditID: b6c32a46-3c1ff70000001029-e0-5a81b84823b4
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2] clk: exynos5433: Extend list of available AUD_PLL output
 frequencies
Date: Mon, 12 Feb 2018 16:52:27 +0100
Message-id: <20180212155227.20605-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7bCmua7HjsYog22bpS02zljPanH9y3NW
        i/PnN7BbfOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbHp4EX2gi72iqX7PjM3MH5m7WLk5JAQ
        MJE4e/oISxcjF4eQwA5GiW2/HkE53xklVl9awwRT1fh6BVRiA6PEycmHmCCcX4wS36eeZgGp
        YhMwlOg92scIYosIyErcOvaTDcRmFmhkkvj2wR7EFhaIkth/5BNYnEVAVeLTh3/sIDavgLXE
        6ZYJ7BDb5CXeL7jPCLJAQqCRTWLllmlQCReJd3N2M0LYwhKvjm+BiktLPFu1Eaqhn1Hi4/H9
        LBDOakaJ1992Qb1qLXH4+EVWiJP4JDoO/wXq5gCK80p0tAlBlHhIfFlzng3CdpT41vqNGaRE
        SCBW4urz4AmMkgsYGVYxiqUWFOempxYbFRjpFSfmFpfmpesl5+duYgTHppbbDsYl53wOMQpw
        MCrx8HbMbowSYk0sK67MPcQowcGsJML7pxkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnLc1wCVK
        SCA9sSQ1OzW1ILUIJsvEwSnVwLgtm+/w4snyzYUd90rfqzL9sal5xcuo2jRbd8aNGdvk468F
        HOwwPbZ8z9MUx/fOXZbXFsr4rHx7YJFBMfPLQ+fc0u6xrjl977Fp97+XiQ8rNvgL5SxZNFEm
        TqT6ns5Zg37fj+EeXJt572WuU9YTN30771hUNadnOPeNLV0HX715qx24c+eBd1eVWIozEg21
        mIuKEwEF4OUCyQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoK77jsYog+37eSw2zljPanH9y3NW
        i/PnN7BbfOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4vDb9pZLX6c6WZx4PJ4f6OV3eNyXy+T
        x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbHp4EX2gi72iqX7PjM3MH5m7WLk5JAQ
        MJFofL2CpYuRi0NIYB2jxNwlu6CcX4wSx5ofMoFUsQkYSvQe7WMEsUUEZCVuHfvJBlLELNDI
        JPHlUycbSEJYIEpi/5FPYDaLgKrEpw//2EFsXgFridMtE9gh1slLvF9wn3ECI9cCRoZVjJKp
        BcW56bnFRgVGeanlesWJucWleel6yfm5mxiBQbPtsFb/DsbHS+IPMQpwMCrx8HbMbowSYk0s
        K67MPcQowcGsJML7pxkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoR
        TJaJg1OqgVGK57Zigsoljnr5BANLcTWJOU9f38241rb5z4wMx6ozbyIrxfdFPupcFKxYw7ji
        5FRf7b1vJrJpm9mcypb+N8WvMuuw9sLrYosYXlzZ8StG0HjxZGWFaov26XvK93hphr5fXR3M
        lRHE8MEw/lmyuX/W+vVvIyYtyForKuReeC2yPJ7/2sOKI0osxRmJhlrMRcWJAOjjE4sWAgAA
X-CMS-MailID: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
X-RootMTR: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
References: <CGME20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one more entry to the exynos5433_aud_pll_rates table, this allows
to support audio sample rates: 48000, 96000, 192000 Hz with minimum
error. The M, P, S, K values re confirmed by the HW team.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index ebd18586e325..b08a9028653f 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -765,6 +765,7 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
 	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
 	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
 	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
+	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
 	{ /* sentinel */ }
 };

--
2.14.2
