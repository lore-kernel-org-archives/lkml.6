Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeDQIu3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:50:29 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:43713 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeDQIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:50:25 -0400
X-Google-Smtp-Source: AIpwx4+oWpUfrVqXLWIPsg+hf8PV/vbxPwuazUstAB7i5elJCtj3bPdUi3cvWZ9MreBd57WpYTsS0w==
Date: Tue, 17 Apr 2018 10:50:20 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ARM: timer-sp: Use of_clk_get_parent_count()
 instead of open coding
Message-ID: <20180417085020.GA7214@mai>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523364701-15383-3-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:51:38PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH v2 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>,
>   - Dropped RFC, as a dummy is now available in the !CONFIG_COMMON_CLK
>     case.
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
