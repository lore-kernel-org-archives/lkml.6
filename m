Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965487AbeBMSQn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:16:43 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38284 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965286AbeBMSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:16:40 -0500
X-Google-Smtp-Source: AH8x227yFKXneA11rA5rzsMmt5IjS7cPd0s7FzpbKCEOfzWxIonFvni823i7Svhin6NRZoW/qqpnUw==
Date: Tue, 13 Feb 2018 19:16:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: dts: exynos: Remove "cooling-{min|max}-level"
 for CPU nodes
Message-ID: <20180213181636.dwjyfqcunynonwrf@kozik-lap>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <f808613a9c7a4f23d3a0c64b6f3d4df1b905b16b.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f808613a9c7a4f23d3a0c64b6f3d4df1b905b16b.1518166039.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:01PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi      |  2 --
>  arch/arm/boot/dts/exynos4412.dtsi      |  2 --
>  arch/arm/boot/dts/exynos5250.dtsi      |  2 --
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 16 ----------------
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 16 ----------------
>  5 files changed, 38 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
