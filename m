Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965443AbeBMR4v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:56:51 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54893 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeBMR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:56:48 -0500
X-Google-Smtp-Source: AH8x224dqI3ipE23MX7Aadw0GtmEjV2JHSxAX1D07cGmwBMtwmwGJtMWbHVVol28fp2TGJMMJsJ6Rg==
Date: Tue, 13 Feb 2018 18:56:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
Message-ID: <20180213175643.4h5anubed4w4lclb@kozik-lap>
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
 <20180130211819.17139-1-krzk@kernel.org>
 <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:46:32PM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1:
> > 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
> >     following Rob's advice.
> > 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
> >     on this.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested following boards and reboot works fine:
> Exynos3250 (artik5-eval)
> Exynos4412 (trats2)
> Exynos5410 (odroid xu)
> Exynos5422 (odroid xu3/xu4)
> Exynos5433 (tm2)

Thanks for testing. I applied 1/4 and 2/4. The remaining DTS patches
depend on 1/4 so they will wait till next release.

Best regards,
Krzysztof
