Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeEPOXm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:23:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39486 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeEPOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:23:41 -0400
X-Google-Smtp-Source: AB8JxZr/e4Ou9+TZl4FnE4DuTfY6yh6A5Ffk0JtnNhUrjrXVJ6jP6dw1iMnTbegf1a9nHo9rn0D8dhNcwRbgQSyI+3s=
MIME-Version: 1.0
In-Reply-To: <20180509220827.22286-2-yixun.lan@amlogic.com>
References: <20180509220827.22286-1-yixun.lan@amlogic.com> <20180509220827.22286-2-yixun.lan@amlogic.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 16:23:39 +0200
Message-ID: <CACRpkdZeUxNOxHSC1AYoR6TG0DUsXt3p9m-SWDaQDyAooNYUyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: nand: meson-gxbb: fix missing data pins
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 12:08 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> The data pin 0-7 of the NAND controller are actually missing from
> the nand pinctrl group, so we fix it here.
>
> Fixes: cd1e3b01c7d3 ("pinctrl: amlogic: gxbb: add nand pins")
> Reported-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied.

Yours,
Linus Walleij
