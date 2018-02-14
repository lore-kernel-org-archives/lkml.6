Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966598AbeBNCvy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:51:54 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34803 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966552AbeBNCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:51:51 -0500
X-Google-Smtp-Source: AH8x227ePAgC7fDVSvuYINevSgFwMMar03ClZ0kGYN8xuNccvz1sfhyX+eAbe6RQbOg6cGUpfuKSDp4iCIqgrsdIh5k=
MIME-Version: 1.0
In-Reply-To: <CACRpkdZzqbhRs+JTiezkNfD4ne-foGgoW+b51DLcFeJsXH2Edg@mail.gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
 <CACRpkdZzqbhRs+JTiezkNfD4ne-foGgoW+b51DLcFeJsXH2Edg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 14 Feb 2018 10:51:50 +0800
Message-ID: <CAMz4kuLCVPo1KgHQ8wOv=y+-c6UkV+ubp8uChXn8KQipvrNesA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: Add Spreadtrum GPIO controller documentation
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 13 February 2018 at 17:20, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 5, 2018 at 2:55 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> This patch adds the device tree bindings for the Spreadtrum
>> GPIO controller. The gpios will be supported by the GPIO
>> generic library.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> I took this patch out again for now, as it turns out
> that not all of the variants are really GPIO controllers,
> but rather irqchips.
>
> If they can't read nor write any GPIO lines, they should
> not have the property gpio-controller at all. Then they are
> just irqchips.

I did not get you here. All GPIOs can be read or write for this GPIO controller.

-- 
Baolin.wang
Best Regards
