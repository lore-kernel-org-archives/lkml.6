Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeFERUn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:20:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45658 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeFERUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:20:39 -0400
X-Google-Smtp-Source: ADUXVKKTH2dVb0Yagjb6fBaQG++xIZ7EBNZEqmRHfoOp6taiqd6pBAhFZZY0kJHbDqgu5NHAlL2s9A==
Subject: Re: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-3-marek.vasut+renesas@gmail.com>
 <20180604122658.GC21163@dell>
 <3853ee6e-86a7-793e-c633-fc9c2910976f@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941AD654@SW-EX-MBX02.diasemi.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c457e76f-aefb-041b-c030-fe8228d7926d@gmail.com>
Date: Tue, 5 Jun 2018 19:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941AD654@SW-EX-MBX02.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 07:16 PM, Steve Twiss wrote:
> 
> 
> On 04 June 2018 19:32, Marek Vasut wrote,
> 
>> Subject: Re: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
>> PMIC_CHIP_ID_DA9063
>>
>> On 06/04/2018 02:26 PM, Lee Jones wrote:
>>> On Sat, 02 Jun 2018, Marek Vasut wrote:
>>>
>>>> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
>>>> DA9063 chip ID register, so rename it as such. It is also the value
>>>> of chip ID register of DA9063L though, so drop the enum as all the
>>>> DA9063 "models" share the same chip ID and thus the distinction will
>>>> have to be made using DT or otherwise.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> ---
>>>> V2: No change
>>>> V3: No change
>>>> ---
>>>>  drivers/mfd/da9063-core.c            | 2 +-
>>>>  drivers/mfd/da9063-i2c.c             | 2 +-
>>>>  drivers/regulator/da9063-regulator.c | 2 +-
>>>>  include/linux/mfd/da9063/core.h      | 4 +---
>>>>  4 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> For my own reference:
>>>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>
>> Thanks.
>>
>> Any other comments before I submit the next round in a few days?
>>
> 
> Hi Marek,
> 
> Thanks.
> I'm reviewing it now.
> Could you hold off until tomorrow please?

Yeah, why ?

-- 
Best regards,
Marek Vasut
