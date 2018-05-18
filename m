Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeERU3f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:29:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42947 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeERU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:29:34 -0400
X-Google-Smtp-Source: AB8JxZq8JsVk+E7wxyCSV3WGSTg9gfpukM62rKGRy2I9fDYFBoaHqqLlJJ77ntnHaZQERUXH+aXMc7CDyKIPk4CkC4Q=
MIME-Version: 1.0
In-Reply-To: <9332d922caf8e25747aa19e573cc3ab82519f6f7.camel@perches.com>
References: <cover.1525964381.git.joe@perches.com> <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
 <20180518084203.n2etqcigvwxzcanv@pathway.suse.cz> <9332d922caf8e25747aa19e573cc3ab82519f6f7.camel@perches.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 18 May 2018 23:29:33 +0300
Message-ID: <CAHp75VcaAMM7NxSWEFhrmQfKMOskuzbAHL-+eqi4DQ71cT7=Bg@mail.gmail.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to KBUILD_MODNAME
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:10 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-05-18 at 10:42 +0200, Petr Mladek wrote:
>> On Thu 2018-05-10 08:45:29, Joe Perches wrote:

>> [    0.000000] libftrace: ftrace: allocating 40753 entries in 160 pages
>> [    0.004008] apic: APIC: Switch to symmetric I/O mode setup
>
> I believe the uppercase APIC: bit should be removed.

I disagree on lowering the case of some prefixes.

In the case when kernel crashes at boot time and only what you have is
what on your screen it's much better to catch with different cases
than if everything would be either upper or lower.

-- 
With Best Regards,
Andy Shevchenko
