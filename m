Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeC0JV4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:21:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40926 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbeC0JVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:21:52 -0400
X-Google-Smtp-Source: AG47ELuKIV8eAIfsCBlP+VycVvvYDdJWaYtKCbLfYcRUpoHWve5wUeqlZJJ8uCyLOKfiT/D/sU4oOQ==
Message-ID: <1522142509.2632.42.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: drop unnecessary AO clock flags
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Tue, 27 Mar 2018 11:21:49 +0200
In-Reply-To: <20180326081809.49493-1-yixun.lan@amlogic.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 16:18 +0800, Yixun Lan wrote:
>   This first two patches will drop unnecessary flags for
> the AO clock driver.
>   The third DTS patch is a follow-up fix for the second patch,
> and I've tested them on P200, P212, Q200, S400 boards.
> 
>  Note: this patch series was made on top of patch [0]
> 
> [0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
> 
> Yixun Lan (3):
>   clk: meson: drop CLK_SET_RATE_PARENT flag
>   clk: meson: drop CLK_IGNORE_UNUSED flag
>   ARM64: dts: meson: fix clock source of the pclk for UART_AO

Please add patch 1 and 2 to the next version of your clkc_ao series

Patch 3 should sent independently to Kevin, with note warning about the
different dependencies (see comment in patch 3)

> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
>  drivers/clk/meson/axg-aoclk.c               | 1 -
>  drivers/clk/meson/gxbb-aoclk.c              | 1 -
>  5 files changed, 6 insertions(+), 8 deletions(-)
> 
