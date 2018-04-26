Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbeDZWq0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:46:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34457 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeDZWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:46:24 -0400
X-Google-Smtp-Source: AB8JxZq3US/aFBjvHfo7Tup3PeWedjspgf7K6uPWOYn5CTwRofebIrJprRLTOQu3m7XOTLZQb8L9ivnfA7QoU/ew5os=
MIME-Version: 1.0
In-Reply-To: <1523904956-18239-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523904956-18239-1-git-send-email-jacopo+renesas@jmondi.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 00:46:23 +0200
Message-ID: <CACRpkdYy9kabXXmA7RwqDCMv-z0QSSMfQa7agp4aaBfoxO=QOA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpio: Add support for r8a77965
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 8:55 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:

> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.
>
> v1 -> v2:
> - Add Simon and Rob Reviewed-by tags

Patch applied.

Yours,
Linus Walleij
