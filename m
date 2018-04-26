Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeDZT2Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:28:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752000AbeDZT2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:28:23 -0400
Date: Thu, 26 Apr 2018 21:28:18 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
Message-ID: <20180426192818.GX17484@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <87efj2q6sq.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efj2q6sq.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-04-18 11:19:33, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > I've had a patch to remove owner few years back. It needed some work
> > to finish but maybe that would be a better than try to make
> > non-scalable thing suck less.
> 
> I have a question.  Would it be reasonable to just have a mm->memcg?
> That would appear to be the simplest solution to the problem.

I do not remember details. Have to re-read the whole thing again. Hope
to get to this soon but with the current jet lag and backlog from the
LSFMM I rather not promis anything. Going with mm->memcg would be the
most simple of course but I have a very vague recollection that it was
not possible. Maybe I misremember...

-- 
Michal Hocko
SUSE Labs
