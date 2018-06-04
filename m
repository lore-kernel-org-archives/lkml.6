Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeFDCfz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:35:55 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43684 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeFDCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:35:53 -0400
X-Google-Smtp-Source: ADUXVKJm8TDizQvRnOUX74qzIBdAaIPCWwPjLwtTYt9O8RMi1fdZk1i6O1CtsfOlH2qFZLb9qTjWv9Zgv7hSl2gKRIQ=
MIME-Version: 1.0
In-Reply-To: <CAGFP0L+EprYNOoz2-rubi+EOytsEJmwckUZk9J8y3jZ9xjdHmw@mail.gmail.com>
References: <CAGFP0L+ndXDPRFT3fjgwBoVZwHOhCEan4Pcj_oW0FXNHV2Rkbw@mail.gmail.com>
 <CAGFP0L+EprYNOoz2-rubi+EOytsEJmwckUZk9J8y3jZ9xjdHmw@mail.gmail.com>
From: Geunsik Lim <geunsik.lim@gmail.com>
Date: Mon, 4 Jun 2018 11:35:50 +0900
Message-ID: <CAGFP0LK3jWq=rW+3QY+=OxrJFHsVZyjd5jZ5=jvZ4TStebD23g@mail.gmail.com>
Subject: Re: About GPL license compliance of Tesla Model S, Linux kernel 4.4
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Harald Welte <laforge@gnumonks.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, https://sfconservancy.org/blog/2018/may/18/tesla-incomplete-ccs/

On Sun, Nov 26, 2017 at 8:23 PM, Geunsik Lim <geunsik.lim@gmail.com> wrote:
> Here is my next activity.
>
> After reading http://gpl-violations.org/helping/,
> I have reported this issue to solve a potential GPL misuse about the
> Linux kernel open source code
> that is used to deploy Tesla Model S (Linux kernel based commercial product).
>
>
>
>
> BRs,
> Geunsik Lim.
>
>
> On Sat, Nov 25, 2017 at 4:48 PM, Geunsik Lim <geunsik.lim@gmail.com> wrote:
>> Hi All,
>>
>> I want to talk about a potential GPL misuse of the Linux open source
>> that is used by Tesla Model S. Some months ago, I have read that a
>> version information of Linux kernel that is deployed into the
>> commercial self-driving car such as Tesla Model S via (1) the twitter
>> web page of Tesla CEO Elon Musk  and (2) the presentation material of
>> the Blackhat 2017  presenter Sen Nie as follows.
>>
>> Oct-05-2016, Twitter, "When we upgrade the core Linux OS to 4.4, which
>> is probably December"
>> https://twitter.com/elonmusk/status/783759011724210176
>>
>> Jul-22-2017, Blackhat 2017, "FREE-FALL: HACKING TESLA FROM WIRELESS TO CAN BUS"
>> https://www.blackhat.com/us-17/briefings.html#free-fall-hacking-tesla-from-wireless-to-can-bus
>>
>>
>> In case of the embedded device vendors, it seems that the most of the
>> global vendors have being uploaded related open source software that
>> are used by commercial products via their open source release center
>> to keep the GPL compliance as following:
>>
>> https://opensource.google.com/
>> https://opensource.microsoft.com/
>> https://opensource.apple.com
>> https://opensource.samsung.com
>> https://opensource.lge.com
>> https://opensource.dell.com/
>> http://opensource.alibaba.com/
>> https://developer.sonymobile.com/knowledge-base/open-source/
>> http://consumer.huawei.com/en/opensource/
>> http://xiaomi.github.io/
>> https://software.intel.com/en-us/open-source
>>
>>
>> Also, we can download related open sources such as Linux kernel, GCC,
>> and so on from their official homepage in case of BMW, GM, Ford, and
>> Toyota cars.
>>
>> BMW - http://www.bmw-carit.de/open-source/
>> GM - http://oss.bosch-cm.com/gm.html
>> Ford - http://corporate.ford.com/ford-open-source.html
>> Toyota - http://www.globaldenso.com/en/opensource/ivi/toyota/
>>
>>
>> BTW, in case of Tesla, where can we find an official open source
>> release center to download their Linux kernel source that is deployed
>> into a commercial self-driving car? I could not find an official web
>> page of Tesla to download Linux Kernel 4.4 (GPLv2) and other open
>> sources that are used by Tesla company. And, I can not find the
>> related Linux kernel source code from https://github.com/teslamotors.
>> Unfortunately, even though I asked a person in charging on this issue,
>> they do not reply me any e-mail for 2 weeks. Anyone that already tried
>> to get their Linux kernel source of Tesla Model S?
>>
>> As we all know, Linus Torvalds has released his Linux Kernel under
>> GPLv2 license via https://www.kernel.org/.
>> For more details, please visit the below web-pages.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/COPYING?h=v4.4
>> http://www.gnu.org/licenses/gpl-faq.en.html#GPLRequireSourcePostedPublic
>>
>> I wonder if they correctly keep the GPL compliance because I am not a lawyer.
>>
>>
>> Thanks for reading.
>>
>>
>>
>> BRs,
>> Geunsik Lim.
>>
>>
>>
>> ----
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> ----
>
>
>
> --
> ----
> Best regards,
> Geunsik Lim, Samsung Electronics
> http://leemgs.fedorapeople.org
> ----
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
----
Best regards,
Geunsik Lim, Samsung Electronics
http://leemgs.fedorapeople.org
