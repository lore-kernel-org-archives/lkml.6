Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeCUBsI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:48:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45714 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCUBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:48:03 -0400
X-Google-Smtp-Source: AG47ELufoeQ7c6vPMWgp7Vd7YcJ6lpioYX4lvAUPeEZCU+kmdDviyfWS+FWvqSlMRS1hnlsdxMnebX0J21w/zATUtZo=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-7MP9OqsQpR+AKzn=yHTH5qv5pa4THy0X5JGr-O+XLDg@mail.gmail.com>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu_hRsJGT-inrzXmAmabaZiUTL7BowdUrxwSWHJecjeVsg@mail.gmail.com> <CAKv+Gu-7MP9OqsQpR+AKzn=yHTH5qv5pa4THy0X5JGr-O+XLDg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 21 Mar 2018 09:48:02 +0800
Message-ID: <CAKv+Gu-SEYwM1CF3-9YPVK4xNMy8hUt=JNTCA4GbP5j1Ts3_2w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] add support for Socionext SynQuacer I2C controller
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 March 2018 at 00:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 10 March 2018 at 15:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 2 March 2018 at 08:31, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
>>> SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.
>>>
>>> I think this is good to go now. Wolfram?
>>>
>>
>> Ping?
>>
>
> Ping?
>

Hello Wolfram,

Do you intend to queue this for v4.17? Or are there any issues that
need to be addressed first?

Thanks,
Ard.


>>> v5:
>>> - add Rob's ack to #1
>>> - drop unnecessary 'platform_set_drvdata(pdev, NULL)' in remove path (#2)
>>>
>>> v4:
>>> - clarify binding that only a single interrupt specifier is expected (#1)
>>> - check return value of clk_prepare_enable() on probe path (#2)
>>> - add Andy's R-b to patch #2
>>>
>>> v3:
>>> - incorporate more of Andy's review comments (#2), especially regarding the
>>>   bus speed and clock source handling for ACPI
>>> - patch #1 unchanged.
>>>
>>> v2:
>>> - incorporate Andy's review comments (#2)
>>> - patch #1 unchanged.
>>>
>>> Ard Biesheuvel (2):
>>>   dt-bindings: i2c: add binding for Socionext SynQuacer I2C
>>>   i2c: add support for Socionext SynQuacer I2C controller
>>>
>>>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
>>>  drivers/i2c/busses/Kconfig                              |  10 +
>>>  drivers/i2c/busses/Makefile                             |   1 +
>>>  drivers/i2c/busses/i2c-synquacer.c                      | 791 ++++++++++++++++++++
>>>  4 files changed, 831 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>>>  create mode 100644 drivers/i2c/busses/i2c-synquacer.c
>>>
>>> --
>>> 2.11.0
>>>
