Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756823AbeDZWsk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:48:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40766 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754684AbeDZWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:48:37 -0400
X-Google-Smtp-Source: AB8JxZp7jRQSvejJ/OZr31PjMYl9sMgv/mNdDBt0WANCES6F1E0ER1+L18T1hJnl8+ZGlMbiFQ6J6gG+UMWFaiz5jMs=
MIME-Version: 1.0
In-Reply-To: <20180411214257.14902-1-rjpdasilva@gmail.com>
References: <20180411214257.14902-1-rjpdasilva@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 00:48:36 +0200
Message-ID: <CACRpkdYsiDhNcOwRnza1UjQ_wSfewS05nTHO0fiyuAnEMAM4Pw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mcp23s08: Clarify gpiospec flags
 cell usage
To: Ricardo Silva <rjpdasilva@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:42 PM, Ricardo Silva <rjpdasilva@gmail.com> wrote:

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

Patch applied with Rob's review tag.

Yours,
Linus Walleij
