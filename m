Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeCGNkx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:40:53 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33945 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeCGNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:40:51 -0500
X-Google-Smtp-Source: AG47ELsNpRFhVwUixnvWKmQ19HHI+2El+FoTWlM7ZEJQZ5f2cvhBk/UkVxy/uzb7NlKp+U545QAPfA==
Date: Wed, 7 Mar 2018 22:40:47 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180307134047.GA521@tigerII.localdomain>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV>
 <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
 <20180307114845.GA894@jagdpanzerIV>
 <20180307234142.1c7d2710@canb.auug.org.au>
 <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/18 13:48), Arnd Bergmann wrote:
[..]
> >
> > I can easily stop building blackfin - and, if the intention is to
> > remove it, there is not much point in wasting resources building it any
> > anyway.
> 
> Right. At the moment, the plan is to remove metag, score, unicore32,
> m32r, frv and blackfin. If you are building any more of those, you can
> stop that as well.
> 
> The fate of tile and mn10300 is still open, but I suspect they won't
> last long either.

That's a huge list.

I heard that CRIS is having some problems as well:
https://lkml.org/lkml/2018/1/11/403

	-ss
