Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeCIXCV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:02:21 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56570 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932186AbeCIXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:02:19 -0500
Date: Sat, 10 Mar 2018 00:02:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>,
        coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __proc_create
Message-ID: <20180309230212.GD19924@breakpoint.cc>
References: <001a113f2be668a1e9056701e617@google.com>
 <CAM_iQpV+PnGUXEKcSrF7u19NOeLLp0PhDW-DOkEfS+8pLnTgYw@mail.gmail.com>
 <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>fs/proc/generic.c:354
> >
> >We need to reject empty names.
> >
> 
> I sent a patch a while back, but Pablo/Florian wanted more than that simple
> fix.
> 
> We also need to filter special characters like '/'
> 
> Or maybe I am mixing with something else.

Argh, sorry, this fell off the truck it seems :(

I'll work on this tomorrow unless someone else does it today ;)
