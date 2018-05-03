Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeECUbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:31:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeECUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:31:16 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <25f6b309-9346-7e28-beeb-a37e69a91ce8@infradead.org>
 <ac506aa3-e5f6-9bfa-a18b-441e04b21d97@infradead.org>
 <CAFkk2KTE+h+UY83vvbFDgG9zcyNy4jZYg+-O3p1yOBmLH-K9Xw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5768c009-d659-c5d7-ae63-ea041362762d@infradead.org>
Date: Thu, 3 May 2018 13:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTE+h+UY83vvbFDgG9zcyNy4jZYg+-O3p1yOBmLH-K9Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 07:47 PM, Ulf Magnusson wrote:
> On Tue, May 1, 2018 at 8:52 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 05/01/2018 11:13 AM, Randy Dunlap wrote:
>>
>> Hi Ulf,
>>
>> When menuconfig displays the Kconfig menu tree and it is over term-width
>> characters, it truncates on the left so that the user can see all of
>> the current menu name. menuconfig.py truncates on the right so that
>> the current menu name may be partially lost or totally lost.
> 
> Fixed. The menu path now scrolls to the right as needed. Maybe "..."
> could be displayed as well, though I'm not sure if it's helpful in
> practice.

Not needed.

>>
>> To enable=y a tristate symbol, cannot enter Y, must do Space Space to cycle
>> from N to M to Y.
> 
> Fixed.
> 
>>
>> No / symbol search. I use that a lot, but I don't claim to be a
>> typical user.
> 
> Coming soon. I have added a "show-all" mode in preparation for it, as
> you might want to jump to invisible symbols.

Sounds good.

> Screenshot: https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss9.png


One minor nit (bikeshed?):  I'm not crazy about "make scriptconfig".  :)

thanks,
-- 
~Randy
