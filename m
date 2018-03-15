Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeCOIQ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:16:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33187 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeCOIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:16:52 -0400
X-Google-Smtp-Source: AG47ELtqypb7UonMr0r5UEn8aS+Fl+wIahvLpmXni/JD1wkuQgyGYg0OvwOn9yhK65Ggh2UamBylyQ==
Date: Thu, 15 Mar 2018 08:16:47 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: pcf50633: Fix some memory leaks in the error
 handling path of 'pcf50633_probe()'
Message-ID: <20180315081647.nmchuykgsgma2kyp@dell>
References: <20180314214755.25853-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180314214755.25853-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Christophe JAILLET wrote:

> If a 'platform_device_alloc()' call fails, we still need to release the
> resources that have already been allocated before returning.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/pcf50633-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
