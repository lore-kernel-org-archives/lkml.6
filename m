Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBEGIl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:08:41 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43996 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeBEGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:29 -0500
X-Google-Smtp-Source: AH8x2249E11kAb720OvW+5c2jP68O48epTnrEZXzkr+U6TOgsVjcq2FV+w2CIfXbNjqQtPWyiF3TFg==
Date: Mon, 5 Feb 2018 00:08:27 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/4] soc: samsung: pmu: Populate children syscon nodes
Message-ID: <20180205060827.vhftmdpucrkv2n5f@rob-hp-laptop>
References: <20180130211819.17139-1-krzk@kernel.org>
 <20180130211819.17139-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130211819.17139-2-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:18:16PM +0100, Krzysztof Kozlowski wrote:
> The syscon poweroff and restart nodes logically belong to the Power
> Management Unit so populate possible children.
> 
> This also requires providing compatibles for Exynos5410 and Exynos7 so
> the PMU device and its children will be instantiated for them as well.
> Just like Exynos5433, these chipsets are not yet supported by the PMU
> driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 6 ++++++
>  drivers/soc/samsung/exynos-pmu.c                      | 7 +++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
