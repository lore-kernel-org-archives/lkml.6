Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeEMNUr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 09:20:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53316 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbeEMNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 09:20:46 -0400
X-Google-Smtp-Source: AB8JxZq/fQCm31UG5KVk4wUniRYV1B9kvoJsYGRWE4ebJmNgM8+JP8v1RchSx3MvXbjPRvNSri9lag==
Date: Sun, 13 May 2018 15:20:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH v2] ARM: dts: exynos: Update x and y properties for
 mms114 touchscreen
Message-ID: <20180513132042.go3xqkcyox76qocs@kozik-lap>
References: <20180510212533.27163-1-andi.shyti@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510212533.27163-1-andi.shyti@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 06:25:33AM +0900, Andi Shyti wrote:
> The mms114 binding [1] specifies that the 'x' and 'y' should be
> called respectively 'touchscreen-size-x' and 'touchscreen-size-y'
> in coherence with the touchscreen [2] binding.
> 
> Update the mms114 node for trats2 and trats dts according to the
> binding.
> 
> [1] Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> [2] Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-trats.dts      | 4 ++--
>  arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
