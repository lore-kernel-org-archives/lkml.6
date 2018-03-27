Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeC0NHY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:07:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33046 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeC0NHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:07:18 -0400
X-Google-Smtp-Source: AG47ELuv5Rc4Io1Y2EInCPXliU/PfA/bnP70F+wg2OO5pMSpxT4ru7OLX+TGfR4AzeHj8Fr1ui70yHanPz2OImIbI6M=
MIME-Version: 1.0
In-Reply-To: <20180316140215.28663-3-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io> <20180316140215.28663-3-icenowy@aosc.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:07:17 +0200
Message-ID: <CACRpkdYZQZTGm3R_Jq28mVf5krSBVyHO5WwtqO6rgAYBFHHTZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] pinctrl: sunxi: introduce IRQ bank conversion function
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. Some
> refactors in the sunxi pinctrl framework are needed.
>
> This commit introduces a IRQ bank conversion function, which replaces
> the "(bank_base + bank)" code in IRQ register access.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
