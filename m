Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeFDJAB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:00:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34093 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFDJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:00:00 -0400
X-Google-Smtp-Source: ADUXVKIfqHlQwz7i+Uenw4dWk9Mg4BYX2JGv4RGtSIfbgHLh2p8erVpYG04DazhBnepJjs0Ke+Duzw==
Date: Mon, 4 Jun 2018 09:59:57 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wm97xx-core: platform data can be NULL
Message-ID: <20180604085957.GO25455@dell>
References: <20180603201617.15805-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180603201617.15805-1-robert.jarzmik@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jun 2018, Robert Jarzmik wrote:

> It is not mandatory that platform data is passed along the ac97
> codec. Actually there are configuration without a battery connected to
> the ADC of the codec.
> 
> This is for example the case for the PXA zylonite platform, so fix the
> NULL dereferencing by adding a test.
> 
> Fixes: a5c6951c49fb ("mfd: wm97xx-core: core support for wm97xx Codec")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/mfd/wm97xx-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
