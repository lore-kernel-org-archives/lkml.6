Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965154AbeEXHmW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:42:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40856 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935725AbeEXHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:42:19 -0400
X-Google-Smtp-Source: AB8JxZqj9WTBr6SLNH7+NxYrOtTJIBaxA1UI2gh+OX8WJzc/sI52kXcqsZdhnJg9QyApZHSC8S0T16i+ddr0fQMQDfE=
MIME-Version: 1.0
In-Reply-To: <f896f79ebfa9a262c89fdeed89cf086220ca051d.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com> <f896f79ebfa9a262c89fdeed89cf086220ca051d.1526835466.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 09:42:17 +0200
Message-ID: <CACRpkdaaTYQvK-enM=voWhLVshjvrTi9hioTH7itWbg6ZEx9ew@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] arm64: dts: mt7622: add EINT support to pinctrl
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
> Add EINT support to pinctrl and set those GPIO keys as interrupt-driven
> keys.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
