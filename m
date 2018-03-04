Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeCDADy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 19:03:54 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:51240 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeCDADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 19:03:50 -0500
X-Google-Smtp-Source: AG47ELtm/165hr4PmA5AA6quYnGVjW1qu3OjqW0x/SmeeKHNACZqVkUH5+aff2FuY0ISOWOCaEAsuA==
Subject: Re: Fwd: Re: Hibernation on i386 failure...
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <1cd7fdbb-3b3e-02b5-743b-2cc8c4d755b5@intel.com>
 <92900026-5110-bde7-fba2-89d545bca29a@gmail.com> <20180109223047.GA26431@amd>
 <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com> <20180303210617.GA22392@amd>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <f840d714-2a84-505f-35c4-3bf22c95e907@gmail.com>
Date: Sat, 3 Mar 2018 19:03:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <20180303210617.GA22392@amd>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>>> On Tue 2018-01-09 16:54:51, Woody Suwalski wrote:
>>>> Hey Pavel, so you have found that issue earlier... Do you have a patch to
>>>> try?
>>> Did I? I do not remember clearly.
>>>
>>> Anyway, here are my hibernation-related patches... Absolutely no
>>> guarantees.
>> Pavel, here is my attempt to convert your patch to 4.15 git, it builds
>> cleanly, and it does not work. If you have a moment to spare - could you
>> check if it is a classic case "everything is good, just does not
>> work"?
> Sorry for the delay.
>
> I've tested today's linux-next, and hibernation works for me, no
> patches needed.
>
> Best regards,
> 									Pavel
My January tests have showed that hibernation does work if I turn off 
the CONFIG_RELOCATABLE option.
So can you confirm that you have it enabled and it works again? I will 
try it on 4.16-rc4 tomorrow...

Thanks, Woody
