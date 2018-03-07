Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeCGOBT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:01:19 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeCGOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:01:17 -0500
X-Google-Smtp-Source: AG47ELsxBlqD91ZdvD45XlaAVu/0uL4F/x0lG+2ELeVVzuWV3+mWzMS1kVK0osN893MJX/dmB5Butw==
Date: Wed, 7 Mar 2018 23:01:13 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180307140113.GB521@tigerII.localdomain>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV>
 <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
 <20180307114845.GA894@jagdpanzerIV>
 <20180307234142.1c7d2710@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307234142.1c7d2710@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (03/07/18 23:41), Stephen Rothwell wrote:
[..]
> > OK. Petr, Stephen, what would be your preference?
> 
> I can easily stop building blackfin - and, if the intention is to
> remove it, there is not much point in wasting resources building it any
> anyway.

OK, sounds good to me.

Then we can drop my dump_stack patch from printk.git and keep
Dave's patch.

Thanks guys.

	-ss
