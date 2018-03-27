Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeC0PoZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:44:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36259 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbeC0PoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:44:23 -0400
X-Google-Smtp-Source: AG47ELvggBPzgnikadbHsGzCj/3iT/jr2mwZjKyQw12KRgGSvuM0wlZZamW7PeV6+pJFM/WkPJ/qng==
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
 <1522136107.12357.58.camel@perches.com>
 <5ec8703b-2979-7a1d-fbc3-bd528d7a5e29@roeck-us.net>
 <1522151285.12357.78.camel@perches.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9e908abe-2dc8-dbba-97f9-d9614fa4b199@roeck-us.net>
Date: Tue, 27 Mar 2018 08:44:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522151285.12357.78.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 04:48 AM, Joe Perches wrote:
> On Tue, 2018-03-27 at 03:28 -0700, Guenter Roeck wrote:
>> On 03/27/2018 12:35 AM, Joe Perches wrote:
>>> On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
>>>> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
>>>
>>> fyi: It's marked Maintained in MAINTAINERS
>>>
>>
>> I did not say that it was not maintained, and I am aware of the information
>> in the MAINTAINERS file, thanks.
> 
> As am I.
> 
> I do agree that hwmon is obscure.  Almost everything about
> anything is obscure to those that don't fully understand it.
> 
> I am unaware though of any use of "obsolete" in drivers/hwmon/
> or in Documentation/ about hwmon or the wiki/
> 
> In what sense do you mean hwmon is obsolete?
> 

_I_ did not say it was obsolete. It was described as obsolete by a maintainer
of a different subsystem at a conference a couple of years ago. If I wasn't too
lazy, I could try to find the presentation, but I don't see the point.

> And the cocci script?
> 
> Anything later than:
> https://systeme.lip6.fr/pipermail/cocci/2016-December/003887.html
> https://github.com/groeck/coccinelle-patches/tree/master/hwmon
> ?
> 
I don't think I ever published it. If I recall correctly, it required
some cleanup patches to be applied first, but then I gave up on the idea
because I didn't want to proceed without code reviews.

> btw: I think the perl scripts I posted for DEV_ATTR_<RW|RO|WO>
> transforms are simpler and less prone to tool versioning
> issues.
> 
> https://lkml.org/lkml/2017/12/22/844
> 
> It'd be fairly simple to add SENSOR_ support.
> 

I'll keep it in mind.

Thanks,
Guenter
