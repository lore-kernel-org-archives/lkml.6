Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeCKRo1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:44:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34503 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeCKRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:44:24 -0400
X-Google-Smtp-Source: AG47ELt2lI/iQsYL4dWmsfwR0PnHdWLrpWKZ1huFbJuo1sbwI3zFxDmnrgNH8rAcHDuPn6BjTTmlUA==
Date: Sun, 11 Mar 2018 18:44:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 2/6] ARM: dts: exynos: Add audio clocks configuration
 for exynos5250-snow
Message-ID: <20180311174421.ooontplgqqo4xdxl@kozik-lap>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179@epcas1p4.samsung.com>
 <20180309172250.23019-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172250.23019-2-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:22:46PM +0100, Sylwester Nawrocki wrote:
> Currently the audio subsystem clocks are not configured properly on Snow
> and sound is not working. The MAX98095 CODEC is not getting its master clock
> on the MCLK pin connected to the SOC's CLKOUT GPIO. This patch adds CLKOUT
> and other clocks configuration so HDMI audio can also be supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
