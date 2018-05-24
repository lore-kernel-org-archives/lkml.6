Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935759AbeEXHgN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:36:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43443 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935498AbeEXHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:36:10 -0400
X-Google-Smtp-Source: AB8JxZoBXtVz+QsCyYJW/6fWs81TINOU8yeCkZz0/7FtKe0xInzCpmVpmM0wmlvpJOTWgHYqTvbFSHGFiB1BoLh9Y7c=
MIME-Version: 1.0
In-Reply-To: <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com> <3898620ef606004aaddc332591ca467f56773029.1526835466.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 09:36:08 +0200
Message-ID: <CACRpkdbKwck2E3v+vr3freG1L5kSnfRc8Gti7jYtkqcuemK-fQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: pinctrl: add external interrupt
 support to MT7622 pinctrl
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
> Extend the capability of MT7622 pinctrl with adding EINT so that each
> GPIO can be used to notify CPU when a signal state is changing on the
> line as an external interrupt.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied with Rob's review tag.

Yours,
Linus Walleij
