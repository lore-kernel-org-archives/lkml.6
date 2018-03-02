Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426063AbeCBJ7I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:59:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:37140 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424593AbeCBJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:58:55 -0500
X-Google-Smtp-Source: AG47ELv3DhKC0Cvp9yGpMp/xQE/We86nYRJVvUjnpYPEdrDwzVdk6v4zKqYgMq7UUaqf0UzP9gbYtdtcZR7h1aXXRkk=
MIME-Version: 1.0
In-Reply-To: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519437750.git.baolin.wang@linaro.org>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519437750.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 10:58:54 +0100
Message-ID: <CACRpkdZ_EJ6Vw5XsXsC4UY94oCQZwrVZ=UTrUEYmvurXZV5A4A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 3:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the device tree bindings for the Spreadtrum
> GPIO controller. The gpios will be supported by the GPIO
> generic library.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v4:
>  - No updates.

Patch applied. So you don't need to keep resending it :)

Yours,
Linus Walleij
