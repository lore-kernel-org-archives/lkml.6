Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeDURFU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 13:05:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35043 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeDURFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 13:05:18 -0400
X-Google-Smtp-Source: AIpwx48XFKuyT6/8gAvwDpudhAjpMvQEl87L9jSrkxKVWv+Ye+Z1jxQ5sVZqoTtxMYMkMnT5xMMe9g==
Date: Sat, 21 Apr 2018 19:05:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 01/61] ARM: plat-samsung: simplify getting .drvdata
Message-ID: <20180421170514.qmklysbjrnkatns5@kozik-lap>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-2-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:05:31PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  arch/arm/plat-samsung/adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
