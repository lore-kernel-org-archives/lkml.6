Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbeDTMac (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:30:32 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38285 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754716AbeDTMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:30:30 -0400
X-Google-Smtp-Source: AB8JxZrFZITK95+zxnpfFsudSvHaRMuAJO9UXExjP8bLrhUzJ/HzwCryzJhO/6A+wtrUmEeWrXSqNiwnw+dT7W7t7kI=
MIME-Version: 1.0
In-Reply-To: <fe2654fb-8c46-0a29-541a-71850c01b64b@axentia.se>
References: <20180411143828.1046-1-brgl@bgdev.pl> <fe2654fb-8c46-0a29-541a-71850c01b64b@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 20 Apr 2018 14:30:29 +0200
Message-ID: <CAMRc=Mc6NVmkgPYvX9iyVVuMRMC=q3c=XCo6uCPay-VD4a_XTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] eeprom: at24: last bits of the big refactoring
To: Peter Rosin <peda@axentia.se>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-12 17:08 GMT+02:00 Peter Rosin <peda@axentia.se>:
> On 2018-04-11 16:38, Bartosz Golaszewski wrote:
>> This is a follow-up to the big series merged for 4.17. The patches
>> contain some bits and pieces that were missing in the last submission
>> or depend on some new features merged this merge window.
>>
>> v1 -> v2:
>> - dropped patch 1/4 because id_table is still needed as pointed out by
>>   Peter Rosin
>> - fixed patch 3/3: we need to free the dummy client if regmap_init fails
>>
>> Bartosz Golaszewski (3):
>>   eeprom: at24: use devm_nvmem_register()
>>   eeprom: at24: provide and use a helper for releasing dummy i2c clients
>>   eeprom: at24: provide a separate routine for creating dummy i2c
>>     clients
>
> For all three:
>
> Reviewed-by: Peter Rosin <peda@axentia.se>
>
> Cheers,
> Peter

Applied to at24/for-next.
