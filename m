Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeFDGP7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:15:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41406 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeFDGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:15:58 -0400
X-Google-Smtp-Source: ADUXVKJPXX1IqpdghZAu0+8EelbQjBFr9PCWpjJuPzEMHfynU0MCw919u32XdTS1Wh/5eYDqnol5AQ==
Date: Mon, 4 Jun 2018 07:15:54 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 02/33] mfd: omap-usb-host: use match_string() helper
Message-ID: <20180604061554.GE25455@dell>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018, Yisheng Xie wrote:

> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/mfd/omap-usb-host.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
