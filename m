Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162059AbeCAVYe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:24:34 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:42746 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162040AbeCAVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:24:23 -0500
X-Google-Smtp-Source: AG47ELtL9uek+iRG2YWMybV+F7SKz/ag8XqDOjYxKozV0YZW/H90nOI1DbFrC8V0BFkSjQzWd/w6EdTnnKDcsP+W5GQ=
MIME-Version: 1.0
In-Reply-To: <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com> <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
From: =?UTF-8?Q?Rados=C5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Date: Thu, 1 Mar 2018 22:24:21 +0100
Message-ID: <CAFvLkMRRWZKqChFu+7yEDURtM_ZmmB1RMjj8yUwTZndiwySckA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if Alexandre agrees but It might be better to take v2
where irq_ack is added.

2018-03-01 22:04 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
> <radoslaw.pietrzyk@gmail.com> wrote:
>
>>         - removes unneeded irq_chip.irq_eoi callback
>>         - adds irq_chip.irq_set_wake callback for possible
>>         in the future GPIO wakeup
>>
>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>
> Patch applied with Alexandre's ACK, stripping ARM from the
> commit message, thanks!
>
> Yours,
> Linus Walleij
