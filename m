Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeEBPin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeEBPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:38:40 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
Message-ID: <152527551948.138124.11345269390915156871@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
Date: Wed, 02 May 2018 08:38:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42Fclld026144

Quoting Geert Uytterhoeven (2018-04-18 07:50:01)
> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> limited to clock providers.
> 
> Hence move these helpers into their own header file, so callers that are
> not clock providers no longer have to include <linux/clk-provider.h>.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next
