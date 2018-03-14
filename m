Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeCNNLY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:11:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeCNNLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:11:23 -0400
Date: Wed, 14 Mar 2018 14:11:18 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v9 00/24] Speculative page faults
Message-ID: <20180314131118.GC23100@dhcp22.suse.cz>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-03-18 18:59:30, Laurent Dufour wrote:
> Changes since v8:
>  - Don't check PMD when locking the pte when THP is disabled
>    Thanks to Daniel Jordan for reporting this.
>  - Rebase on 4.16

Is this really worth reposting the whole pile? I mean this is at v9,
each doing little changes. It is quite tiresome to barely get to a
bookmarked version just to find out that there are 2 new versions out.

I am sorry to be grumpy and I can understand some frustration it doesn't
move forward that easilly but this is a _big_ change. We should start
with a real high level review rather than doing small changes here and
there and reach v20 quickly.

I am planning to find some time to look at it but the spare cycles are
so rare these days...
-- 
Michal Hocko
SUSE Labs
