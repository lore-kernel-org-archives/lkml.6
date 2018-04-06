Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDFNR1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:17:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38939 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbeDFNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:17:24 -0400
X-Google-Smtp-Source: AIpwx49bE0ByluJGTltxeCDYJt0tyGQiCSS6P/Uv+rZwJkwdwedpgHQ/sEfiF0M+yOKYGVtKPet9dw==
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
To: Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
 <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
Date: Fri, 6 Apr 2018 15:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-06 13:43, Petr Mladek wrote:
> On Thu 2018-04-05 16:55:35, Joe Perches wrote:
>> On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
>>> On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
>>>> Even just git grep -1 -E '%p"$' finds %pt and %po
>>>> which should get fixed before somebody claims those extensions.
>>>
>>> Neither %pt nor %po is used in a vsprintf
>>> in the kernel.
>>
>> Nope, you are right, both are defectively used in the
>> kernel via string concatenation.
> 
> Ah, I see.

Yes, that was the point of that particular grep pattern with context. I
sent patches three years ago and several pings, but despite an email
telling me it would be picked up "for the next release" nothing has
happened, so I've just been waiting for someone to implement a %po.

> Otherwise, the changes make perfect sense. Are you going to send
> them as proper patches, please?

Good luck. Unless Petr will be taking them through the printk tree?

Rasmus
