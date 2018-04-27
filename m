Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758414AbeD0Nde (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:33:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36381 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757614AbeD0Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:33:33 -0400
X-Google-Smtp-Source: AB8JxZosSbcNL7wCBgFYveZlqXI1af9o4cl+RJFqrn70GzaAI11HT6WeuOpZfxK+w7Q48FPMnqU2AoP2MWxjUsk8HIE=
MIME-Version: 1.0
In-Reply-To: <20180417170824.18670-1-yixun.lan@amlogic.com>
References: <20180417170824.18670-1-yixun.lan@amlogic.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 15:33:32 +0200
Message-ID: <CACRpkdaRvKs=ekpxxW_NuxP=d5ijUafOHbpSk8igMUckbDWwyw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson-axg: fix the range of aobus bank
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 7:08 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> The GPIOAO bank is range from GPIOAO_0 to GPIOAO_13.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Reported-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied with Kevin's ACK.

Yours,
Linus Walleij
