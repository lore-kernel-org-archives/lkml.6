Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeDPSOb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:14:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41678 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753185AbeDPSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:14:27 -0400
X-Google-Smtp-Source: AIpwx49ymZxigzIQ2PEJeno7w0XigaFEaf7Q5tlwDDsuXRoCL37Svyt7yNzCDaxBxd24+5+4hVctIg==
Date: Mon, 16 Apr 2018 20:14:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: exynos: Move syscon poweroff and
 restart nodes under the PMU
Message-ID: <20180416181424.chmge5fxd6mecvww@kozik-lap>
References: <20180416181126.15629-1-krzk@kernel.org>
 <20180416181126.15629-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416181126.15629-2-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 08:11:26PM +0200, Krzysztof Kozlowski wrote:
> The PMU node is the actual block responsible for power management,
> including typical Exynos on/off/restart procedures.  Therefore the
> syscon poweroff and restart nodes logically belong to it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Previously was "Fix missing missing reg warning for syscon restart
> nodes" to fix DTC warnings like:
> 
>     arch/arm64/boot/dts/exynos/exynos7-espresso.dtb: Warning (simple_bus_reg):
>         Node /soc/syscon-reboot missing or empty reg/ranges property
> 
> but this warnings are gone in v4.17-rc1 since 9130ba884640
> ("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
>  arch/arm64/boot/dts/exynos/exynos7.dtsi    | 12 ++++++------
>  2 files changed, 13 insertions(+), 13 deletions(-)

I forgot to include Marek's tested-by tag (given previously):
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards,
Krzysztof
