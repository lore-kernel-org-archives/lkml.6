Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933011AbeBVPZ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:25:57 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38038 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932744AbeBVPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:25:55 -0500
X-Google-Smtp-Source: AH8x224PpL5VSBtdXzfw0KEV5I/uvHJCHNbMAJBMeFZCVCqOAIpuI8Qna5NPkJRcsPuPXOCLF0fRaA==
Date: Thu, 22 Feb 2018 15:25:51 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: linux-kernel@vger.kernel.org, W.Egorov@phytec.de
Subject: Re: [PATCH] mfd: rk808: Fix RK818 ID template
Message-ID: <20180222152551.fqyujg5giivts2pf@dell>
References: <1519293292-46451-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519293292-46451-1-git-send-email-d.schultz@phytec.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018, Daniel Schultz wrote:

> The Rockchip PMIC driver can automatically detect connected component
> versions by reading the ID_MSB and ID_LSB registers. The probe function
> will always fail with RK818 PMICs because the ID_MSK is 0xFFF0 and the
> RK818 template ID is 0x8181.
> 
> This patch changes this value to 0x8180.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  include/linux/mfd/rk808.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
