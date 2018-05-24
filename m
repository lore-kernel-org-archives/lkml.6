Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeEXHkf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:40:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35549 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965135AbeEXHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:40:33 -0400
X-Google-Smtp-Source: AB8JxZpu3CjJsx3Eu90YOSTPiql9rF3GTtb1/zUdNKSoQ5STrYuJHfLx7EZAYhjMfj5SfBELeNngPpOTotRDl8V4mCQ=
MIME-Version: 1.0
In-Reply-To: <72462fb7aab16463a42066998ac3b4bf35ada416.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com> <72462fb7aab16463a42066998ac3b4bf35ada416.1526835466.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 09:40:31 +0200
Message-ID: <CACRpkdYD-N7uLOZmYSKaTJpsa+8N3KStVRpKfR45j2OFveNveQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] pinctrl: mediatek: remove unused fields in struct mtk_eint_hw
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
> The .name field has been not being used in existent code logic, so
> it's better that we remove them all.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
