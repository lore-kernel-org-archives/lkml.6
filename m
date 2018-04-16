Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeDPJih (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:38:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37880 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeDPJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:38:36 -0400
X-Google-Smtp-Source: AIpwx4/pEcRhanQV2TK3Lmrwt6mfuAdA6tDCXC7A0czrdkBWde3lykHUcbhvgnF91zQIEpAGjvY11A==
Date: Mon, 16 Apr 2018 10:38:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mfd: rk808: Add restart functionality
Message-ID: <20180416093833.kpwggnnivcnyyge5@dell>
References: <1522335000-23057-1-git-send-email-d.schultz@phytec.de>
 <1522335000-23057-2-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522335000-23057-2-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Daniel Schultz wrote:

> When using Rockchip SoCs with rk805/808/818 PMICs, restarts are realized by
> setting the reset registers in the "Clock and Reset Unit".
> 
> Now, the driver can trigger a restart in the PMIC. Like the
> shutdown function, the restart is bound to an independent
> "rockchip,system-reset-controller" devicetree property can easily
> enabled by adding this.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2: Re-submit with recipients from Rockchip.
> 	v3: - Added devicetree property to enable the PMIC reset seperate from 
> 	      "rockchip,system-power-controller".
> 	    - Dropped the first patch of this serie.
> 	v4: Splitted refactoring and the new reset feature.
> 	v5: -
> 
>  drivers/mfd/rk808.c       | 58 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 53 insertions(+), 6 deletions(-)

I'd still like an Ack/Review from the Rockchip guys please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
