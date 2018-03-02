Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423020AbeCBIh1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:37:27 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:40661 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422939AbeCBIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:37:24 -0500
X-Google-Smtp-Source: AG47ELt1fvALTbTz8FhMni3PSjt4DnpepeJn48etTPG0FFDsLsQujQ4ksKTLIlWmma9ueD8FyY0zZt7xtK6SJFTzONs=
MIME-Version: 1.0
In-Reply-To: <3526aa4e-a7cb-4108-5449-d77ae5e355ba@st.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
 <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
 <CAFvLkMRRWZKqChFu+7yEDURtM_ZmmB1RMjj8yUwTZndiwySckA@mail.gmail.com> <3526aa4e-a7cb-4108-5449-d77ae5e355ba@st.com>
From: =?UTF-8?Q?Rados=C5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Date: Fri, 2 Mar 2018 09:37:21 +0100
Message-ID: <CAFvLkMTN1NrdrT9aQjVmDtUNkwXbB0hEaPzE8Es1Axsch=BYzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w228bXss015828

Linus responded in v2 mail thread that he's gonna take it instead of v1.

2018-03-02 9:14 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Hi Radoslaw and Linus,
>
>
> On 03/01/2018 10:24 PM, Radosław Pietrzyk wrote:
>>
>> I don't know if Alexandre agrees but It might be better to take v2
>> where irq_ack is added.
>
>
>
> Sorry Linus, I agree with Rodoslaw, you need to take V2 as stm32-exti patch
> is linked to pinctrl v2 patch. I gonna add my acked-by.
>
> Regards
> Alex
>
>
>>
>> 2018-03-01 22:04 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>>>
>>> On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
>>> <radoslaw.pietrzyk@gmail.com> wrote:
>>>
>>>>          - removes unneeded irq_chip.irq_eoi callback
>>>>          - adds irq_chip.irq_set_wake callback for possible
>>>>          in the future GPIO wakeup
>>>>
>>>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>>>
>>>
>>> Patch applied with Alexandre's ACK, stripping ARM from the
>>> commit message, thanks!
>>>
>>> Yours,
>>> Linus Walleij
