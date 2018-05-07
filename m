Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeEGVFe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:05:34 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43577 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeEGVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:05:32 -0400
X-Google-Smtp-Source: AB8JxZqualI9c8aIL4+/TuEDI64cVs9JpIE05/ZpM7Mw3Bnz4KLFo2seInxBhCFZKh+Bx1TKDvpi3g==
Date: Mon, 7 May 2018 16:05:30 -0500
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/7] pinctrl: sunxi: add support for H6 R_PIO pin
 controller
Message-ID: <20180507210530.GA8285@rob-hp-laptop>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-4-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:38:43AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller like other Allwinner SoCs,
> which controls the PL and PM pin banks.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

In the future, please split bindings to separate patches.

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        | 128 +++++++++++++++++++++
>  4 files changed, 134 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
