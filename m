Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeBMHg6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:36:58 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:54710 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeBMHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:36:55 -0500
X-Google-Smtp-Source: AH8x225db9JsbJPnxFXPJ2TWv9ESV40panQ2l+LLnYe1mghdyokfhramIQlwUn9PhosjnbudAQuYZEU22vADi16gLeg=
MIME-Version: 1.0
In-Reply-To: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2018 08:36:54 +0100
Message-ID: <CACRpkdbq-D8ZU5jMVLZq56j7L5-vHSmbgYd24g8VkD8bLrc2mQ@mail.gmail.com>
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

Patch applied with Rob's ACK from v2.

Yours,
Linus Walleij
