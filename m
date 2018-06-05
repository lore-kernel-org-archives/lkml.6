Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeFEIPG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:15:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:46501 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbeFEIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:15:04 -0400
Date: Tue, 5 Jun 2018 10:15:01 +0200
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
Message-ID: <20180605081501.GT19202@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <877enj9uwf.fsf@xmission.com>
 <20180601135725.GE15278@dhcp22.suse.cz>
 <87a7sey3ud.fsf@xmission.com>
 <20180601150219.GG15278@dhcp22.suse.cz>
 <87y3fyv88o.fsf@xmission.com>
 <20180604065425.GF19202@dhcp22.suse.cz>
 <87r2lmlj1p.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2lmlj1p.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-06-18 09:31:46, Eric W. Biederman wrote:
[...]
> My key point is that it is easy to trigger which makes the current
> mm_update_next_owner a fundamentally flawed design, and something that
> needs to be fixed.

Ohh, absolutely agreed! I was not trying to argue that part of course.

-- 
Michal Hocko
SUSE Labs
