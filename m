Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBHUSY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:18:24 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46348 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBHUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:18:22 -0500
X-Google-Smtp-Source: AH8x225TNWfVI2+JB+FwMnvaY1L1HJCIaxq3nZ1iQtWLjnmleQpZah7BvMN49y581wOsrjjYseb60w==
Date: Thu, 8 Feb 2018 14:18:19 -0600
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/6] clk: sunxi-ng: add support for the Allwinner H6
 CCU
Message-ID: <20180208201819.dxc4e3utyybocbyj@rob-hp-laptop>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203154942.63566-5-icenowy@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 11:49:40PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has a CCU which has been largely rearranged.
> 
> Add support for it in the sunxi-ng CCU framework.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Exported APB1 bus clock for PIO.
> - Switch to SPDX license identifier.
> 
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi-ng/Kconfig                       |    5 +
>  drivers/clk/sunxi-ng/Makefile                      |    1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c               | 1199 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |   57 +
>  include/dt-bindings/clock/sun50i-h6-ccu.h          |  125 ++
>  include/dt-bindings/reset/sun50i-h6-ccu.h          |   74 ++
>  7 files changed, 1462 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
>  create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h
