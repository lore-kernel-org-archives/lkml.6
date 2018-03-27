Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeC0MLE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:11:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36460 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeC0MLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:11:03 -0400
X-Google-Smtp-Source: AG47ELt9xOwfrt3Axn7AvfG3b8KDdSrxIN0YDIVr1uqGnr94hs3sLS+EtdCpvWkzkt2CaLJKbpcwvA==
Date: Tue, 27 Mar 2018 13:10:59 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mfd: rk808: Add restart functionality
Message-ID: <20180327121059.icdxo4rroifvaujf@dell>
References: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
 <1521218891-26616-2-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521218891-26616-2-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Daniel Schultz wrote:

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
> 
>  drivers/mfd/rk808.c       | 58 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 53 insertions(+), 6 deletions(-)

Both patches look okay to me.

It would be good to obtain an Ack or two from the Rockchip guys though.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
