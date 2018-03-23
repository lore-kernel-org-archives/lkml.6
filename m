Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCWDDP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:03:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53170 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCWDDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:03:13 -0400
X-Google-Smtp-Source: AG47ELtHj4WMQc8qAaVu6hPYw8LUlINX/F8rcqHTrLasLsM5RuhNpI4zNVzmyTDeVFnLmBxOVYW8jvzRnVtQm3In/qQ=
MIME-Version: 1.0
In-Reply-To: <20180305234906.GA32058@embeddedgus>
References: <20180305234906.GA32058@embeddedgus>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Mar 2018 04:03:12 +0100
Message-ID: <CACRpkdZdzgVmyMmzOWHr2=oS3XYejmF+sqs4pjf4PDxDkqGd4g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: mtk-common: use true and false for
 boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 12:49 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> Assign true or false to boolean variables instead of an integer value.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
