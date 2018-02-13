Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934680AbeBMJUX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:20:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37718 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934449AbeBMJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:20:19 -0500
X-Google-Smtp-Source: AH8x227SLmCUJp7f7bISeF49H1wwa2IXs0hqyKVmHdf0hSkrgDXDNB+3uF0o+Hjj9VvNjFf+oKbT1fiH5Ib5brMJVjI=
MIME-Version: 1.0
In-Reply-To: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2018 10:20:18 +0100
Message-ID: <CACRpkdZzqbhRs+JTiezkNfD4ne-foGgoW+b51DLcFeJsXH2Edg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:55 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the device tree bindings for the Spreadtrum
> GPIO controller. The gpios will be supported by the GPIO
> generic library.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

I took this patch out again for now, as it turns out
that not all of the variants are really GPIO controllers,
but rather irqchips.

If they can't read nor write any GPIO lines, they should
not have the property gpio-controller at all. Then they are
just irqchips.

We need some extended discussion about this.

Yours,
Linus Walleij
