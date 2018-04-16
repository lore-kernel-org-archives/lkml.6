Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDPSuY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:50:24 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42669 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbeDPSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:50:22 -0400
X-Google-Smtp-Source: AIpwx48irvWWP6jCPOLmI9gI+rl+CNo82EYWYghkLfKCsYT/eq8jKNE/YCP9uiUw7sjyguZuoAW95Q==
Date: Mon, 16 Apr 2018 13:50:21 -0500
From: Rob Herring <robh@kernel.org>
To: Ricardo Silva <rjpdasilva@gmail.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mcp23s08: Clarify gpiospec flags
 cell usage
Message-ID: <20180416185021.thnxtpvgvsdqvh6q@rob-hp-laptop>
References: <20180411214257.14902-1-rjpdasilva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411214257.14902-1-rjpdasilva@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 10:42:57PM +0100, Ricardo Silva wrote:
> The pinctrl-mcp23s08 driver doesn't provide a specific gpiospec
> of_xlate() function, causing the gpiolib-of's of_gpio_simple_xlate()
> function to be used instead, which takes the gpiospec's second cell as
> the flags specifier according to 'include/dt-bindings/gpio/gpio.h'.
> 
> The pinctrl-mcp23s08 bindings document was mentioning that the flags
> were unused, which is not accurate because values in that second cell
> are indeed used by the gpiolib-of's of_gpio_simple_xlate() for
> configuring the gpio (e.g. its polarity).
> 
> This way, replace the "flags currently unused" reference in the
> dt-bindings document with references to the appropriate files specifying
> the possible flag values and gpiospec description.
> 
> CC: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Silva <rjpdasilva@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
