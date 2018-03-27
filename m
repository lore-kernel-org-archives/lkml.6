Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeC0Lk3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:40:29 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:44860 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0Lk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:40:28 -0400
X-Google-Smtp-Source: AG47ELt5umGteSMij+TNAutw/SxOrPBS8hXdipQ7wFxfUvjxFwVL5TDf3Y4aBPnShhj7z5VCGcPCjF/ocmN2EMPW2lM=
MIME-Version: 1.0
In-Reply-To: <CACRpkdb38=qXh7to0pL4=Qon8t-AW+AeaBmhiY-a4b3mWqcE_w@mail.gmail.com>
References: <20180312235940.6coamzh4qhckaohh@gmail.com> <CACRpkdb38=qXh7to0pL4=Qon8t-AW+AeaBmhiY-a4b3mWqcE_w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Mar 2018 13:40:07 +0200
Message-ID: <CANiq72=Dm-ev5dWRLMLN0-yxGqw3F7REf2+PHG-tsKiAmC8Z1g@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: arm-charlcd: Fix struct charlcd doc line
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Walleij <triad@df.lth.se>, Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 1:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Mar 13, 2018 at 12:59 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>
>> There was a missing first line and a missing member,
>> which gave a warning under W=1:
>>
>>     CC      drivers/auxdisplay/arm-charlcd.o
>>   drivers/auxdisplay/arm-charlcd.c:57: warning: Cannot understand
>>    * @dev: a pointer back to containing device on line 57 - I thought
>>   it was a doc line
>>
>> Cc: Linus Walleij <triad@df.lth.se>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus.

Cheers,
Miguel
