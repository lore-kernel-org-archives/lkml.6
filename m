Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeEORvf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:51:35 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56636 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752021AbeEORvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:51:33 -0400
Date: Tue, 15 May 2018 19:51:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Westphal <fw@strlen.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: linux-next: build warning after merge of the netfilter-next tree
Message-ID: <20180515175123.ncxzaaexp3ehcpwx@breakpoint.cc>
References: <20180507105519.1d34f19e@canb.auug.org.au>
 <20180508102101.768d5c52@canb.auug.org.au>
 <20180508071756.grie5wln2lpo52un@breakpoint.cc>
 <CAMuHMdU0iUBbkPL5ZKxKuORnQA9ujX1J+5NLw=ft80hJh20VxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU0iUBbkPL5ZKxKuORnQA9ujX1J+5NLw=ft80hJh20VxQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, May 8, 2018 at 9:17 AM, Florian Westphal <fw@strlen.de> wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> On Mon, 7 May 2018 10:55:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> >
> >> > After merging the netfilter-next tree, today's linux-next build (x86_64
> >> > allmodconfig) produced this warning:
> >> >
> >> > ./usr/include/linux/netfilter/nf_osf.h:25: found __[us]{8,16,32,64} type without #include <linux/types.h>
> >>
> >> > Introduced by commit
> >> >
> >> >   bfb15f2a95cb ("netfilter: extract Passive OS fingerprint infrastructure from xt_osf")
> >
> > I'll send a fix for this, thanks for reporting.
> 
> +config NF_OSF
> +       tristate 'Passive OS fingerprint infrastructure'
> 
> "There is no help available for this option."
> 
> Is this meant to be a user-visible symbol?

No, its not.  I can send a patch in case you're too busy, let me know.
