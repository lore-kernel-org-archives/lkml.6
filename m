Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbeCGQMq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:12:46 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36276 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934017AbeCGQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:12:35 -0500
X-Google-Smtp-Source: AG47ELujLgPFyVmkmfNjLEXgE5fFusKrKUrlfKRQmHoIszTO5teT8vw95F8jW8DQpvpH+fgCP218Wg==
Date: Wed, 7 Mar 2018 16:12:31 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, maxime.ripard@bootlin.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 6/6] mfd: axp20x: add battery power supply cell for
 AXP813
Message-ID: <20180307161231.zqwnjb6utadp4lxb@dell>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <dc220101006c4df198b2d410121334a2ae98ad22.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc220101006c4df198b2d410121334a2ae98ad22.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Quentin Schulz wrote:

> As axp20x-battery-power-supply now supports AXP813, add a cell for it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
