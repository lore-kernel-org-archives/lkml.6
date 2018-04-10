Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeDJN4J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:56:09 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36448 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeDJNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:55:59 -0400
X-Google-Smtp-Source: AIpwx49nEHup1ZkbT++4VeCEjsSin7YkmFBMK36rC/lxmMth/jdAqDJcXy6Ys12JMtZm8FtP+fwIdQ==
Date: Tue, 10 Apr 2018 08:55:57 -0500
From: Rob Herring <robh@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 4/5] DTS: Bindings: pca953x driver provides an
 optional vcc-supply property
Message-ID: <20180410135557.umt5sgxrx23dirpo@rob-hp-laptop>
References: <cover.1522868422.git.hns@goldelico.com>
 <e8e6fae4436e5390c7c4e831c9eb127d3f8cc65b.1522868423.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e6fae4436e5390c7c4e831c9eb127d3f8cc65b.1522868423.git.hns@goldelico.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:00:23PM +0200, H. Nikolaus Schaller wrote:
> So let's describe this property in the bindings.

It's not what the driver for some OS has. The h/w has a Vcc supply, so 
let's add a property for it...

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>  1 file changed, 1 insertion(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> index d2a937682836..6a7cddb187c1 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> @@ -35,6 +35,7 @@ Required properties:
>  Optional properties:
>   - reset-gpios: GPIO specification for the RESET input. This is an
>  		active low signal to the PCA953x.
> + - vcc-supply:	power supply regulator.
>  
>  Example:
>  
> -- 
> 2.12.2
> 
