Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeDJNSU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:18:20 -0400
Received: from gloria.sntech.de ([95.129.55.99]:55562 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752943AbeDJNSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:18:17 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] soc: rockchip: power-domain: Use of_clk_get_parent_count() instead of open coding
Date: Tue, 10 Apr 2018 15:17:56 +0200
Message-ID: <7442109.yKeQIlf4qX@phil>
In-Reply-To: <1523364701-15383-4-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be> <1523364701-15383-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. April 2018, 14:51:39 CEST schrieb Geert Uytterhoeven:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a negative number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Depending on how we plan on merging this series, I could either pick
this patch for 4.19, after patch1 makes it into 4.18 or otherwise
someone could pick the whole series together with my

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

for this patch.


Heiko
