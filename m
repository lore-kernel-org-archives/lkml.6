Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeDPJi0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:38:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44733 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDPJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:38:24 -0400
X-Google-Smtp-Source: AIpwx49hBU3tRlbjQZbKcFhE9q16QMTwhNvZgLWLEMqEMNa/mTvRsu++3OPxHu7rAWzFYgFK/EEyqQ==
Date: Mon, 16 Apr 2018 10:38:21 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rk808: Refactor shutdown functions
Message-ID: <20180416093821.sqrcc6mmnc23njul@dell>
References: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Daniel Schultz wrote:

> Since all three shutdown functions have almost the same code, all logic
> from the shutdown functions can be refactored to a new function
> "rk808_update_bits", which can update a register by a given address and
> bitmask.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2: Re-submit with recipients from Rockchip.
> 	v3: - Added devicetree property to enable the PMIC reset seperate from 
> 	      "rockchip,system-power-controller".
> 	    - Dropped the first patch of this serie.
> 	v4: Splitted refactoring and the new reset feature.
> 	v5: Removed null pointer from rk808_update_bits.
> 
>  drivers/mfd/rk808.c | 46 +++++++++++++---------------------------------
>  1 file changed, 13 insertions(+), 33 deletions(-)

I'd still like an Ack/Review from the Rockchip guys please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
