Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034300AbeCBHow (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:44:52 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34251 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936126AbeCBHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:44:49 -0500
X-Google-Smtp-Source: AG47ELuDYluwhQTDUcg+T+vzqAMwfRTS+Cz2ipeZa5g/nq8cVjjKvveMoZn4IsTfxxpJy66io/c5A3SZddVLP61X1+0=
MIME-Version: 1.0
In-Reply-To: <607af13d88f733057df2ea057228e1cdbf77262a.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com> <607af13d88f733057df2ea057228e1cdbf77262a.1519378871.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 08:44:48 +0100
Message-ID: <CACRpkdYZmx-jxbjJDPpJ_wn0xszdKBPQiEa=tnCr2KVn1QBz6g@mail.gmail.com>
Subject: Re: [PATCH v1 03/19] dt-bindings: pinctrl: mediatek: add bindings for
 I2C2 and SPI2 on MT7623
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:16 AM,  <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Add missing pinctrl binding about I2C2 and SPI2 which would be used in
> devicetree related files.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
