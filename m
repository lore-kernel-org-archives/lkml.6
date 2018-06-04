Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeFDHis (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:38:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41658 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeFDHir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:38:47 -0400
X-Google-Smtp-Source: ADUXVKIKjTGg/ooZdvY3YB4MFah6C7tB19VGifbV9zAQMxHyQFp0+l8eWXbqX3fgR3rhaDExkwPCPg==
Date: Mon, 4 Jun 2018 08:38:44 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Fix the broken MMC card detection
Message-ID: <20180604073844.GH25455@dell>
References: <20180526093150.20989-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180526093150.20989-1-robert.jarzmik@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2018, Robert Jarzmik wrote:

> The MMC framework requires the ocr_mask to be provided. Without it, the
> SD card is not detected, especially on the hx4700 platform.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/mfd/asic3.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
