Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeFEHWm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:22:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52947 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFEHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:22:40 -0400
X-Google-Smtp-Source: ADUXVKIqK5uZrxdJIyTzJkPWlmnGSOgP/u8oIPudD/VNjcCVPwZjjQttD0H7/GpTwhFupmhyHWLgFw==
Date: Tue, 5 Jun 2018 08:22:08 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 05/10] mfd: da9063: Add DA9063L type
Message-ID: <20180605072208.GK21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-5-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180602101155.26375-5-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Marek Vasut wrote:

> Add type for DA9063L, which is a reduced variant of the DA9063
> without RTC block and with less regulators.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: No change
> V3: No change
> ---
>  include/linux/mfd/da9063/core.h | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
