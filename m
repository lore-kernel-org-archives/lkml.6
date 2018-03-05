Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbeCEFlw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:41:52 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:46577 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932614AbeCEFlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:41:50 -0500
X-Google-Smtp-Source: AG47ELt3w2Xn1crVskKXs3oNexbUaTngaVk0Y4IoqFqViwCfQslqqRa2zNAREagZgLrlxyCHKl6RNw==
Date: Mon, 5 Mar 2018 14:41:46 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Greentime Hu <green.hu@gmail.com>, Dave Young <dyoung@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20180305054146.GB6202@jagdpanzerIV>
References: <20180302160732.12691fbc@canb.auug.org.au>
 <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
 <20180303144739.GA516@tigerII.localdomain>
 <20180305032005.GA4661@dhcp-128-65.nay.redhat.com>
 <CAEbi=3dz8OE_8JBZ17ihP7=YQamPPK-qewVjtYv4ZEy4jHC6ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3dz8OE_8JBZ17ihP7=YQamPPK-qewVjtYv4ZEy4jHC6ww@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/18 13:27), Greentime Hu wrote:
[..]
> >> Opinions? Will this work?
> >
> > I would think b) is better, thanks for the fix!
> >
> Hi,
> 
> b works in nds32.
> Thanks for the fix :)

Greentime, Dave, thanks!

I'll send out a patch then.

Petr, once the patch has enough Ack/etc do you want to pick it up?
We need to merge it first, before Dave's patch.

	-ss
