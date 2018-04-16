Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeDPM6z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:58:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36129 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeDPM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:58:53 -0400
X-Google-Smtp-Source: AIpwx48u229h+jPTP7PPasERehD4Em5JF/tbZ/I1N7Cp68y/Tyyiu+Df0i1TenjZiid0hGy314+anw==
Date: Mon, 16 Apr 2018 13:58:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 2/2] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180416125849.sfiphqylcyea7wjg@dell>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
 <20180330125824.21418-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330125824.21418-3-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> From: Sebastian Reichel <sre@kernel.org>
> 
> Add support for the audio-codec node by converting from
> devm_of_platform_populate() to devm_mfd_add_devices().
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/motorola-cpcap.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
