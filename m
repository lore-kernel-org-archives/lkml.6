Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeDPJgg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:36:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34183 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeDPJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:36:34 -0400
X-Google-Smtp-Source: AIpwx497G01i7e+K/v1MvqMb7CVckP+YKueKCXPykJScjn5DGSZeDwRJ3Bn2bQt3gZNdkYCe2k3Zmw==
Date: Mon, 16 Apr 2018 10:36:30 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] mfd: axp20x: Use DEFINE_RES_IRQ to declare resources
 for mfd_cells
Message-ID: <20180416093630.ytjtspxsrlppxa5z@dell>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180329043115.7132-3-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> Previously we were open coding the interrupts for the various mfd
> cells. This made the code somewhat long due to pretty-formatting.
> 
> This patch convert those into one-line declarations with DEFINE_RES_IRQ,
> making the code shorter and easier to read.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 187 +++++++++------------------------------------------
>  1 file changed, 30 insertions(+), 157 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
