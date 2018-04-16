Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeDPJg0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:36:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41803 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeDPJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:36:22 -0400
X-Google-Smtp-Source: AIpwx4++SKaOKJFoT9haaOLqmBJwWZCR67EVXgTYdtBeiRDP+Bvw6MNYtu19LWxQbktkQ8OuFaSvwQ==
Date: Mon, 16 Apr 2018 10:36:18 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] mfd: axp20x: Const-ify struct mfd_cell and struct
 resource
Message-ID: <20180416093618.2ajissetbjfpjck5@dell>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180329043115.7132-2-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> The axp20x driver has lots of mfd_cell and resource structs.
> These can all be const-ified.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c       | 44 ++++++++++++++++++++++----------------------
>  include/linux/mfd/axp20x.h |  2 +-
>  2 files changed, 23 insertions(+), 23 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
