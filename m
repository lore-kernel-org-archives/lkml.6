Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeC0MKw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:10:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42815 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeC0MKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:10:50 -0400
X-Google-Smtp-Source: AIpwx48TbJhKuGxanmdS0PxN0r82W1p4A2bDn37zc30Hv3l9MGkEvgeTWw10PJzilkpP9twPneXeVg==
Date: Tue, 27 Mar 2018 13:10:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mfd: rk808: Refactor shutdown functions
Message-ID: <20180327121046.23mmw3x66tlypshb@dell>
References: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521218891-26616-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Daniel Schultz wrote:

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
> 
>  drivers/mfd/rk808.c | 47 ++++++++++++++---------------------------------
>  1 file changed, 14 insertions(+), 33 deletions(-)

Both patches look okay to me.

It would be good to obtain an Ack or two from the Rockchip guys though.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
