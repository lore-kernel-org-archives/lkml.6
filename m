Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeC0NFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:05:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34757 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeC0NFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:05:19 -0400
X-Google-Smtp-Source: AIpwx49iqPx7v1mZw63VR9qgt4lqnH/bjjFmIJrjujOsdXmhn4LcBctBkToTbfTg/+268VUEY/7wllb8UoUme8nnZwU=
MIME-Version: 1.0
In-Reply-To: <20180316140215.28663-2-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io> <20180316140215.28663-2-icenowy@aosc.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:05:18 +0200
Message-ID: <CACRpkdbO0KQEG_OXbswJkmWm=Ceiutx7vux6GJp8XVun+NiRbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] pinctrl: sunxi: refactor irq related register
 function to have desc
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

> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Adjusted parameter sequence.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
