Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754285AbeD3No2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:44:28 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34217 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754160AbeD3NoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:44:25 -0400
X-Google-Smtp-Source: AB8JxZqP+juYHcev6kdA59XZWOFL8d8WCKp+ShCuZLELVldNi8o070VVv0rTJAaaaitQLi6MPR/6Lg==
Date: Mon, 30 Apr 2018 15:44:20 +0200
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
Subject: Re: [PATCH v3 4/5] soc/tegra: pmc: Use of_clk_get_parent_count()
 instead of open coding
Message-ID: <20180430134420.GE11457@mai>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 04:50:04PM +0200, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a very big number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> This depends on "[PATCH v3 1/5] clk: Extract OF clock helpers in
> <linux/of_clk.h>".
> 
> v3:
>   - Add Acked-by,
> 
> v2:
>   - of_clk_get_parent_count() was moved to <linux/of_clk.h>.
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>




 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
