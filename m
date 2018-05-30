Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968584AbeE3HAn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:00:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34609 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937191AbeE3HAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:00:10 -0400
X-Google-Smtp-Source: ADUXVKK6x6eRz3PvZTt6zYDp43j/mARlG8F4yvhy/zk1LFZNcW06nbd+Xm17YRSEj2IS8eId2VFidtv/KmF+tNro4Ig=
MIME-Version: 1.0
In-Reply-To: <20180524175024.19874-6-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org> <20180524175024.19874-6-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 09:00:08 +0200
Message-ID: <CACRpkdZ_xrHkrprb=7BiOCrnJrAsXNZVnYDf2Jcp4gF99W+pCA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] pinctrl: optionally stop deferring probe at end of initcalls
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        boot-architecture@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 7:50 PM, Rob Herring <robh@kernel.org> wrote:

> If the pinctrl node in DT indicates that pin setup is optional and the
> defaults can be used with the 'pinctrl-use-default', then only defer probe
> until initcalls are done. This gives platforms the option to work without
> their pinctrl driver being enabled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

I trust that you know what you're doing so I guess
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
