Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBHUBy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:01:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:01:53 -0500
Subject: Re: [PATCH] cramfs: better MTD dependency expression
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <nycvar.YSQ.7.76.1802072149330.7021@knanqh.ubzr>
 <CA+55aFzHtRbis95-D-nLB6v_FM8ZVPU6Wt=A04bG2zH+RukhaA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <518cf447-3eca-3030-df45-7ed5da2e2521@infradead.org>
Date: Thu, 8 Feb 2018 12:01:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzHtRbis95-D-nLB6v_FM8ZVPU6Wt=A04bG2zH+RukhaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 11:38 AM, Linus Torvalds wrote:
> On Wed, Feb 7, 2018 at 7:08 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>>
>> Viro once told me that my cramfs pull requests could go either to him or
>> to you. I have only this one patch at the moment, and since it depends
>> on a commit that recently appeared in your tree I'm therefore sending it
>> directly to you.
> 
> Applied.
> 
> Although I'm not entirely convinced that the simpler dependency is
> easier to _read_ and understand.
> 
> It is clearly simpler, though.
> 
>             Linus
> 


There was some pushback on the patch, mostly from Arnd.

I think we agree that it's not easier to read/understand, but Nicolas
is the maintainer... and he patched kconfig so that this would work.
kconfig did need fixing in that respect -- it was supposed to work
but didn't.

(That was commit 9059a3493efea6492451430c7e2fa0af799a2abb:
kconfig: fix relational operators for bool and tristate symbols)

-- 
~Randy
