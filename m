Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965138AbeEXHjw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:39:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39441 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965135AbeEXHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:39:48 -0400
X-Google-Smtp-Source: AB8JxZoYexhLk0A8cPukXjErASLmwm1cz326J2rErOcKbvqLmnUf0zBUiUKybKS/cRw6n/V8KB/b4G4Zt2GN9baU7M8=
MIME-Version: 1.0
In-Reply-To: <39738efefe94e3a4fb7668a27dd73ae49695dc3b.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com> <39738efefe94e3a4fb7668a27dd73ae49695dc3b.1526835466.git.sean.wang@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 09:39:47 +0200
Message-ID: <CACRpkdYFZLCMJCZ0csV2cU3zGq4c7R2O0PSLk7XiZsj=cyAK7A@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] pinctrl: mediatek: use generic EINT register maps
 for each SoC
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
> So far, EINT on each SoC all used exactly identical register map and thus
> it's better that we apply generic register map already supported in EINT
> library and stop copy-n-pasting the same data block and filling into its
> platform data.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
