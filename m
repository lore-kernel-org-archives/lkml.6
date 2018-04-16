Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDPJhB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:37:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45245 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeDPJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:36:59 -0400
X-Google-Smtp-Source: AIpwx4+WMS8csvaNKPxDlz8pxVaQkyhBH3CxmV7/4jvClGtrxRE6hxpHZhr/4/yzNJekyEZ6qReRgA==
Date: Mon, 16 Apr 2018 10:36:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] mfd: axp20x: Correct AXP806 POK interrupt prefix
Message-ID: <20180416093655.d2ni7iypccl72xxu@dell>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-4-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180329043115.7132-4-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> When AXP806 support was added, POK was incorrectly expanded to PWROK.
> However, the datasheet lists them as POK[LSNP], which is the same as
> on the AXP288. Furthermore, the registers associated with POK functions
> are the same as the PEK on the other AXP PMICs. This suggests that
> "POK" means "Power On Key", much like "PEK" means "Power Enable Key",
> instead of "Power OK".
> 
> This patch changes the "PWROK" prefix to "POK" for these interrupts.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c       | 8 ++++----
>  include/linux/mfd/axp20x.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
