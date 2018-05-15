Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeEORjb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:39:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38384 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeEORj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:39:28 -0400
X-Google-Smtp-Source: AB8JxZrMTZfcFYveTejd8UXsJLPg3BhNLkfuROHf6nL2klF8w4lvAiic1hAqRm6C3b3y5dHF4SP7aQ==
Date: Tue, 15 May 2018 19:39:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2] ARM: dts: exynos: Add support for audio over HDMI for
 Odroid X/X2/U3
Message-ID: <20180515173924.goxxl4wic7tlhzyw@kozik-lap>
References: <CGME20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b@epcas2p1.samsung.com>
 <20180514080148.10150-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514080148.10150-1-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:01:48AM +0200, Sylwester Nawrocki wrote:
> This patch switches Odroid X/X2/U3 to use dedicated Odroid audio subsystem
> DT bindings instead of the simple-card in order to add support for audio
> over HDMI.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 +++++++++++++++----------
>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  6 ++---
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |  6 ++---
>  3 files changed, 26 insertions(+), 19 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
