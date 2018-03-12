Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeCLOLF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:11:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45335 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbeCLOLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:11:03 -0400
X-Google-Smtp-Source: AG47ELtJ5zH2g0VNad7gUUec9pq2DieQpf6KOkYZNRskJXTj5tBrVea1PcpTH583mt5xbt1BVN0orQ==
Date: Mon, 12 Mar 2018 14:11:00 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500-debugfs: Use kasprintf
Message-ID: <20180312141100.brfyw3kn5meamfcv@dell>
References: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018, Himanshu Jha wrote:

> Use kasprintf instead of combination of kmalloc and sprintf.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
