Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeD3NlO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:41:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33938 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeD3NlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:41:09 -0400
X-Google-Smtp-Source: AB8JxZreg2TdxZ3w6UktjhUHmPS2pLi02tjwgmtmxQk0rzjJuXDXJyKP2jj3QlB9Y0oiheNw2syr3g==
Date: Mon, 30 Apr 2018 15:41:05 +0200
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
Subject: Re: [PATCH v3 3/5] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
Message-ID: <20180430134105.GD11457@mai>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 04:50:03PM +0200, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a negative number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
