Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeDYNFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:05:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38059 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeDYNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:05:19 -0400
X-Google-Smtp-Source: AIpwx4/nwWJhEaytd4IeC4z4gUu7taSE6mkMdNlbg7UFTcywst7ke+RwQTKnaFCHbsXZnfdMrNm+YQ==
Message-ID: <1524661512.4026.67.camel@baylibre.com>
Subject: Re: [PATCH v6 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Wed, 25 Apr 2018 15:05:12 +0200
In-Reply-To: <20180419135426.155794-1-yixun.lan@amlogic.com>
References: <20180419135426.155794-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-19 at 21:54 +0800, Yixun Lan wrote:
>   This patch try to add AO clock and Reset driver for Amlogic's
> Meson-AXG SoC.
>   Please note that patch 7 need to wait for the DTS changes[3] merged
> into mainline first, otherwise it will break the serial console.
> 
>  patch 2: factor the common code into a dedicated file
>  patch 3-5: add the aoclk driver for AXG SoC
>  patch 6-7: drop unnecessary clock flags
> 
> changes since v5 at [6]: 
>  - drop unnecessary header files
>  - add 'axg_aoclk' prefix to clk driver, make them more consistent
>  - add missing end new line..
> 
> changes since v4 at [5]: 
>  - fix return err
>  - introduce CONFIG_COMMON_CLK_MESON_AO
>  - format/style minor fix
> 
> changes since v3 at [4]: 
>  - add 'const' contraint to the read-only data
>  - switch to devm_of_clk_add_hw_provider API
>  - check return value of devm_reset_controller_register
> 
> changes since v2 at [2]: 
>  - rework meson_aoclkc_probe() which leverage the of_match_data
>  - merge patch 5-6 into this series
>  - seperate DTS patch, will send to Kevin Hilman independently
>  
> changes since v1 at [0]: 
>  - rebase to clk-meson's branch 'next/drivers' [1]
>  - fix license, update to BSD-3-Clause
>  - drop un-used include header file
> 
> [0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
> [1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
> [2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
> [3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com
> [4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan@amlogic.com
> [5] https://lkml.kernel.org/r/20180408031938.153474-1-yixun.lan@amlogic.com
> [6] https://lkml.kernel.org/r/20180409143749.71197-1-yixun.lan@amlogic.com

Yixun

Please :
 - Fix checkpatch error in patch 5 
 - Collect Philip's Ack on patch 4
 - Remove the extra new lines at EOF in patch 2 (maybe others, I did not check
them all) - 1 new line at the end of each file, not 2.

Regards
Jerome
