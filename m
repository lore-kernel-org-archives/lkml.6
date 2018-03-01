Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162750AbeCAWmB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:42:01 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:39935 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162650AbeCAWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:41:55 -0500
X-Google-Smtp-Source: AG47ELtKw3RzFLOQX9fs6cSi8u0CkOisHKBoKHF3DajwTwoGJKB0T19HujVEYsqmo/yYT1er4QKZrULDCmX/PTSKPaY=
MIME-Version: 1.0
In-Reply-To: <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <cover.1519374248.git.radoslaw.pietrzyk@gmail.com> <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 23:41:54 +0100
Message-ID: <CACRpkdYfbgdr9QsTudYdr8EnXgMzwqm_iP2m1ya3hQkyTBjgqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 9:31 AM, Radoslaw Pietrzyk
<radoslaw.pietrzyk@gmail.com> wrote:

> - removes unneeded irq_chip.irq_eoi callback
> - adds irq_chip.irq_set_wake callback for possible
> in the future GPIO wakeup
> - adds irq_chip.irq_ack callback
>
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>

This v2 patch applied with Ludovic's tags.

Yours,
Linus Walleij
