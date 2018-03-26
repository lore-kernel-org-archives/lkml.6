Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeCZI7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:59:32 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:40537 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:59:30 -0400
X-Google-Smtp-Source: AG47ELva9eo8sTrwZ3uWP9ZkUBYgFcr6NE9keDnL25I7bwdinHXHrSFrjB2AhvHoNEyHoCSVK8xG3FIDvBXOBUmd8p8=
MIME-Version: 1.0
In-Reply-To: <1521687523-1604-6-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com> <1521687523-1604-6-git-send-email-zhiyong.tao@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:59:29 +0200
Message-ID: <CACRpkdYcD4LA7KU_54tgM9fmBioGsKb+9gkBupvgaL9phRpPgA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] pinctrl: fix check warnings.
To: Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com,
        Liguo Zhang <liguo.zhang@mediatek.com>,
        "Joe.C" <yingjoe.chen@mediatek.com>, hongkun.cao@mediatek.com,
        Biao Huang <biao.huang@mediatek.com>, YT Shen <yt.shen@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 3:58 AM, Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This patch fixes check warnings.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Patch applied. Seems uncontroversial.

I hope there is no typo in there ...

Yours,
Linus Walleij
