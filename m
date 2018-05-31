Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeEaFVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:21:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39667 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeEaFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:21:13 -0400
X-Google-Smtp-Source: ADUXVKIKxoYVzJm1/6F+gIRRTXhOMnYR/hdo8GIzfVY0KS0+LzrVkvETD6fNi68vzxka9qbcwBh1+Q==
Date: Thu, 31 May 2018 10:51:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary
 CPUs on Exynos542x
Message-ID: <20180531052109.f43trnba7ux6tno2@vireshk-i7>
References: <20180530164922.31851-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530164922.31851-1-krzk@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-18, 18:49, Krzysztof Kozlowski wrote:
> Secondary CPUs should have the same information in DeviceTree as booting
> CPU from both correctness point of view and for possible hotplug
> scenarios.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Nice.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
