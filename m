Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEVM6G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:58:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEVM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:58:00 -0400
Date: Tue, 22 May 2018 14:57:57 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
Message-ID: <20180522125757.GL20020@dhcp22.suse.cz>
References: <20180503133338.GA23401@redhat.com>
 <87y3h0x0qg.fsf@xmission.com>
 <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <87tvrncoyc.fsf_-_@xmission.com>
 <20180510121418.GD5325@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510121418.GD5325@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-05-18 14:14:18, Michal Hocko wrote:
> On Fri 04-05-18 12:26:03, Eric W. Biederman wrote:
> > 
> > Andrew can you pick up these two fixes as well.
> > 
> > These address the issues Michal Hocko and Oleg Nesterov noticed.
> 
> I completely got lost in this thread. There are way too many things
> discussed at once. Could you repost the full series for a proper review
> please?

ping
-- 
Michal Hocko
SUSE Labs
