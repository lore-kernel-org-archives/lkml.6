Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965095AbeEXHiB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:38:01 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:47045 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965041AbeEXHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:37:49 -0400
X-Google-Smtp-Source: AB8JxZojRxYyHXf4G0VtohvtSD67G6Hxwm3oY8K3sW7rRpuX4toa2mUpZ3mwSzcc9jyCcMFNOiMHhn+uc8d8+OA7RH8=
MIME-Version: 1.0
In-Reply-To: <7265772c758d4c56cabb95fda708550bc4d2fcb5.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com> <7265772c758d4c56cabb95fda708550bc4d2fcb5.1526835466.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 09:37:48 +0200
Message-ID: <CACRpkdatfPK8r-wttDJ=ty--2T7AiW8YiAu6kqKN6FQTf9R23w@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] pinctrl: mediatek: refactor EINT related code for
 all MediaTek pinctrl can fit
To: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 7:01 PM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> This patch is in preparation for adding EINT support to MT7622 pinctrl,
> and the refactoring doesn't alter any existent logic.
>
> A reason we have to refactor EINT code pieces into a generic way is that
> currently, they're tightly coupled with a certain type of MediaTek pinctrl
> would cause a grown in a very bad way as there is different types of
> pinctrl devices getting to join.
>
> Therefore, it is an essential or urgent thing that EINT code pieces are
> refactored to eliminate any dependencies across GPIO and EINT as possible.
>
> Additional structure mtk_eint_[xt, hw, regs] are being introduced for
> indicating how maps being designed between GPIO and EINT hw number, how to
> set and get GPIO state for a certain EINT pin, what characteristic on a
> EINT device is present on various SoCs.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
