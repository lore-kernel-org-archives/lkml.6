Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeA3OkF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:42932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbeA3OkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:40:03 -0500
Date: Tue, 30 Jan 2018 15:39:58 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Miller <davem@davemloft.net>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev <netdev@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.s@alibaba-inc.com>, syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [netfilter-core] kernel panic: Out of memory and no killable
 processes... (2)
Message-ID: <20180130143958.GG21609@dhcp22.suse.cz>
References: <20180129165722.GF5906@breakpoint.cc>
 <20180129182811.fze4vrb5zd5cojmr@node.shutemov.name>
 <20180129223522.GG5906@breakpoint.cc>
 <20180130075226.GL21609@dhcp22.suse.cz>
 <20180130081127.GH5906@breakpoint.cc>
 <20180130082817.cbax5qj4mxancx4b@node.shutemov.name>
 <CACT4Y+bFKwoxopr1dwnc7OHUoHy28ksVguqtMY6tD=aRh-7LyQ@mail.gmail.com>
 <20180130095739.GV21609@dhcp22.suse.cz>
 <20180130140104.GE21609@dhcp22.suse.cz>
 <20180130140111.GM5906@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130140111.GM5906@breakpoint.cc>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 15:01:11, Florian Westphal wrote:
> > From d48e950f1b04f234b57b9e34c363bdcfec10aeee Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Tue, 30 Jan 2018 14:51:07 +0100
> > Subject: [PATCH] net/netfilter/x_tables.c: make allocation less aggressive
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Thanks! How should we route this change? Andrew, David?

-- 
Michal Hocko
SUSE Labs
