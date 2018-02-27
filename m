Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeB0RB5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:01:57 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:50605 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeB0RBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:01:55 -0500
X-Google-Smtp-Source: AH8x226UOB6Y5WHRjoH72A5ASpoIb2QzsWtlzX/5R3wkwLCxjv0mTz3c+nVxcXQHH4t+UZw7AEjNBvo2Vz0VXhDhimk=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc_AUD2b5m-6CzKhAWJDudyObGs_oUUiFRk_BQv2QT7Xg@mail.gmail.com>
References: <20180227110107.30259-1-ard.biesheuvel@linaro.org> <CAHp75Vc_AUD2b5m-6CzKhAWJDudyObGs_oUUiFRk_BQv2QT7Xg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 27 Feb 2018 17:01:53 +0000
Message-ID: <CAKv+Gu_YJSnk0=5-yS03KSunCr-EusfMs2PNFNB0chqpL9sQQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] add support for Socionext SynQuacer I2C controller
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2018 at 15:59, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 1:01 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
>> SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.
>>
>
> Thanks for an update!
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

Thanks Andy


>> v3:
>> - incorporate more of Andy's review comments (#2), especially regarding the
>>   bus speed and clock source handling for ACPI
>> - patch #1 unchanged.
>>
>> v2:
>> - incorporate Andy's review comments (#2)
>> - patch #1 unchanged.
>>
>> Ard Biesheuvel (2):
>>   dt-bindings: i2c: add binding for Socionext SynQuacer I2C
>>   i2c: add support for Socionext SynQuacer I2C controller
>>
>>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
>>  drivers/i2c/busses/Kconfig                              |  10 +
>>  drivers/i2c/busses/Makefile                             |   1 +
>>  drivers/i2c/busses/i2c-synquacer.c                      | 787 ++++++++++++++++++++
>>  4 files changed, 827 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>>  create mode 100644 drivers/i2c/busses/i2c-synquacer.c
>>
>> --
>> 2.11.0
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
