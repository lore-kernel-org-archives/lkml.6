Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbeDZM6a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:58:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:35251 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756163AbeDZM6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:58:22 -0400
Date: Thu, 26 Apr 2018 14:58:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Rientjes <rientjes@google.com>, dm-devel@redhat.com,
        eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, edumazet@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
 fallback options
Message-ID: <20180426125817.GO17484@dhcp22.suse.cz>
References: <20180424170349.GQ17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com>
 <20180424173836.GR17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
 <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>
 <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>
 <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
 <1524694663.4100.21.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-04-18 18:42:57, Mikulas Patocka wrote:
> 
> 
> On Wed, 25 Apr 2018, James Bottomley wrote:
[...]
> > Kconfig proliferation, conversely, is a bit of a nightmare from both
> > the user and the tester's point of view, so we're trying to avoid it
> > unless absolutely necessary.
> > 
> > James
> 
> I already offered that we don't need to introduce a new kernel option and 
> we can bind this feature to any other kernel option, that is enabled in 
> the debug kernel, for example CONFIG_DEBUG_SG. Michal said no and he said 
> that he wants a new kernel option instead.

Just for the record. I didn't say I _want_ a config option. Do not
misinterpret my words. I've said that a config option would be
acceptable if there is no way to deliver the functionality via kernel
package automatically. You haven't provided any argument that would
explain why the kernel package cannot add a boot option. Maybe there are
some but I do not see them right now.
-- 
Michal Hocko
SUSE Labs
