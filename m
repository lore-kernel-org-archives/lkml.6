Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCKRoE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:44:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33283 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeCKRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:44:02 -0400
X-Google-Smtp-Source: AG47ELur15luGhWFkvHsdIYmq6ereWMJj0SuWgecOgVzHsuFpm6hpK5MO5YbWqsYPkrLpBNSm7O59g==
Date: Sun, 11 Mar 2018 18:43:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 4/6] ARM: dts: exynos: Enable HDMI audio on Snow
 Chromebook
Message-ID: <20180311174358.2kfafhdzigw2eve3@kozik-lap>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368@epcas2p2.samsung.com>
 <20180309172250.23019-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172250.23019-4-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:22:48PM +0100, Sylwester Nawrocki wrote:
> This patch adds new cpu, codec subnodes according to the updated
> "google,snow-audio-max98095" DT bindings and the I2S clock tree
> configuration so sound on the HDMI interface can also be supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - i2s0/#clock-cells property moved to exynos5250.dtsi
>  - edited commit summary line.
> 
> Changes since v1:
>  - changed order of codec in codec/cpu-dai property
>    to match the DT bindings documentation.
> ---
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +++
>  arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
>  arch/arm/boot/dts/exynos5250.dtsi             | 1 +
>  3 files changed, 12 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
