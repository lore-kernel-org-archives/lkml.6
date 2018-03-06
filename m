Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeCFFfK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:35:10 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46044 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCFFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:35:09 -0500
X-Google-Smtp-Source: AG47ELtIL82+bkG+cYrOcWf9fJv80ISwvD0FpnUt/ANPiPKQGLZkgyBExu6Un/6BlrQ/aGd7rbcSBBJ+KCFoP/4XJqA=
MIME-Version: 1.0
In-Reply-To: <20180306043117.GF6713@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <20180305144846.3jommv372c73dltt@pathway.suse.cz> <CAEbi=3f2h0Uw3UOFOyVHXUtzPhr02AK6FfCaZ=N-8jfZDLNpHQ@mail.gmail.com>
 <20180306043117.GF6713@jagdpanzerIV>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 6 Mar 2018 13:34:28 +0800
Message-ID: <CAEbi=3cR8GAoychQ67uCr8T9vsd6+t5zhp7K927fXn_uXcwutw@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-06 12:31 GMT+08:00 Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com>:
> On (03/06/18 10:50), Greentime Hu wrote:
> [..]
>> > Greentime Hu, you tested this on nds32. Could I use your Tested-by,
>> > please?
>> >
>>
>> Yes, please use it. :)
>
> Thanks.
>
> To be sure, is this
>
>   Tested-by: Greentime Hu <green.hu@gmail.com> # nds32
> or
>   Acked-by: Greentime Hu <green.hu@gmail.com> # nds32
>

Acked-by is prefered.
Thanks.
