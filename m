Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeCFEbX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 23:31:23 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35971 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeCFEbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 23:31:22 -0500
X-Google-Smtp-Source: AG47ELu/Bpj3S23glZ2YGp7JKO7Tg7o07pisqQST0CQFhqvNl/lqyw/7VDJbVyGJ206q1+ygMdXvjw==
Date: Tue, 6 Mar 2018 13:31:17 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Greentime Hu <green.hu@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180306043117.GF6713@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <20180305144846.3jommv372c73dltt@pathway.suse.cz>
 <CAEbi=3f2h0Uw3UOFOyVHXUtzPhr02AK6FfCaZ=N-8jfZDLNpHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3f2h0Uw3UOFOyVHXUtzPhr02AK6FfCaZ=N-8jfZDLNpHQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/06/18 10:50), Greentime Hu wrote:
[..]
> > Greentime Hu, you tested this on nds32. Could I use your Tested-by,
> > please?
> >
> 
> Yes, please use it. :)

Thanks.

To be sure, is this

  Tested-by: Greentime Hu <green.hu@gmail.com> # nds32
or
  Acked-by: Greentime Hu <green.hu@gmail.com> # nds32

?

	-ss
