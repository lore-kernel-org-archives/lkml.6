Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeCGQME (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:12:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37981 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:12:00 -0500
X-Google-Smtp-Source: AG47ELtUpI/3W0gQgeHkczQrgFxRemy/k/5ftlBcfdGwNS6s2OW6HV6pcjogHh4W5a8iQUEvepWx1g==
Date: Wed, 7 Mar 2018 16:11:56 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, maxime.ripard@bootlin.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 1/6] mfd: axp20x: make AXP209/22x cells probe their
 ADC via DT
Message-ID: <20180307161156.2ahecezje5u2qlp3@dell>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <6652613fb10bcc8f21880af114c3b49ca267c108.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6652613fb10bcc8f21880af114c3b49ca267c108.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Quentin Schulz wrote:

> This makes AXP209 and AXP22x ADCs probe first via DT and then by
> fallback via platform.
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
