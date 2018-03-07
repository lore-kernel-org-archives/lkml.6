Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934013AbeCGQMc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:12:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40337 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933963AbeCGQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:12:17 -0500
X-Google-Smtp-Source: AG47ELsw7l430CYTO1p3rqiXwgMpZ/grnOSfc+6Yl05n3HwDEoJtr8KYTO9M3lIQiLsuOmRcMSFEkw==
Date: Wed, 7 Mar 2018 16:12:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, maxime.ripard@bootlin.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 2/6] mfd: axp20x: probe axp20x_adc driver for AXP813
Message-ID: <20180307161213.xs4v7y6rdpmwxhmp@dell>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <4795b70e4298aa0d1fc01cafe17f5b0a416e90f8.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4795b70e4298aa0d1fc01cafe17f5b0a416e90f8.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Quentin Schulz wrote:

> This makes the axp20x_adc driver probe with platform device id
> "axp813-adc".
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
