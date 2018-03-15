Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCOM3e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:29:34 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:40560 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:29:32 -0400
X-Google-Smtp-Source: AG47ELuEqL3UpGHuMLOaAioLQAsF+tkGkkryiFWtwGmfk28fbqkjgPGPSBGOh4gIrxKirlTJUpNNeOYllw8+j+LJsk0=
MIME-Version: 1.0
In-Reply-To: <1521109575.10722.654.camel@linux.intel.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
 <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com> <1521109575.10722.654.camel@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 13:29:30 +0100
Message-ID: <CAPDyKFrZaDx2NdvaFdgOxWBuwtjMnJE41p=x5b2x2moFEO3kXQ@mail.gmail.com>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2018 at 11:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
>> On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor.com
>> > wrote:
>> >
>
>> Honestly, I don't like this, but maybe other people do, then I am fine
>> with this approach.
>>
>> If were to decide, I would just rather print the caps field in a
>> hexadecimal bit form and leave the translation to the user.
>
> A compromise would be to print both:
>
> 0xHHHHHHHH\n
> Description of each enabled field, one per line
>
>
> Another format would be:
>
> Bit XX: Description of a field

If we were to print the description, there is no point in printing the
bits in hex. Or is it?

As I said, if you and other folkz thinks this is valuable, then I am
fine as well. Just saying, it's not my preferred option.

Kind regards
Uffe
