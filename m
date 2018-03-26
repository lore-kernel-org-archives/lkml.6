Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCZJF2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:05:28 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52007 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeCZJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:05:26 -0400
X-Google-Smtp-Source: AIpwx48BLuo9UodtjM6UErlUaHsZRWGYCnfTwKpVGGz4h85cN2D7vamtfyRqhypfKmhtkR80p5G2z/mYLodBatgb2xA=
MIME-Version: 1.0
In-Reply-To: <20180322123500.2379-1-alexandre.belloni@bootlin.com>
References: <20180322123500.2379-1-alexandre.belloni@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 11:05:25 +0200
Message-ID: <CACRpkdbEWdo6UNL2HSzvvszQZjYnyYTOuWQzkmqSw=CvpGYhOw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: fix gpio direction
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 1:35 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Bits have to be cleared in DEVCPU_GCB:GPIO:GPIO_OE for input and set for
> output. ocelot_gpio_set_direction() got it wrong and this went unnoticed
> when the driver was reworked.
>
> Reported-by: Gregory Clement <gregory.clement@bootlin.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
