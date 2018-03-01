Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161909AbeCAVFA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:05:00 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:41784 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161895AbeCAVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:04:57 -0500
X-Google-Smtp-Source: AG47ELu5ECaAGOS/WPsmEVQxX+2WV2dtIShDrUjTRB+ZXr2TLKE5p4deaERqg/xNF6p0MeDxbD5NMI8kJL5uK0dKmLk=
MIME-Version: 1.0
In-Reply-To: <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com> <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 22:04:56 +0100
Message-ID: <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
To: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
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

On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
<radoslaw.pietrzyk@gmail.com> wrote:

>         - removes unneeded irq_chip.irq_eoi callback
>         - adds irq_chip.irq_set_wake callback for possible
>         in the future GPIO wakeup
>
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>

Patch applied with Alexandre's ACK, stripping ARM from the
commit message, thanks!

Yours,
Linus Walleij
