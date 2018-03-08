Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934818AbeCHCrZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:47:25 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:46802 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934597AbeCHCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:47:23 -0500
X-Google-Smtp-Source: AG47ELvNUPh+Zt9VprohmHv7Ifx0toXUmB33BTDOEyN1TxEz6yo1P9m/bl0Jgv5Az9Ec3UXpFYUJH4Z05Wwo9zaJLlU=
MIME-Version: 1.0
In-Reply-To: <20180307225411.GA20370@piout.net>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
 <20180307225411.GA20370@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 8 Mar 2018 10:47:22 +0800
Message-ID: <CAMz4kuKcLif02j6VwfAgQ1=4orhydboj9yXgvau=KQofkuosLA@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] rtc: Use time64_t to save range_max of RTC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 8 March 2018 at 06:54, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Hi,
>
> On 26/02/2018 at 16:33:56 +0800, Baolin Wang wrote:
>> We need use rtc->range_max to valid if the time values are valid,
>> and the time values are saved by time64_t type. So change the
>> rtc->range_max to time64_t type for comparison correctly.
>>
>
> I'm not applying this one because the described issue will never happen
> as negative times are forbidden by the rtc subsystem.

OK.

>
> I've applied the two following patches
>

Thanks.


-- 
Baolin.wang
Best Regards
