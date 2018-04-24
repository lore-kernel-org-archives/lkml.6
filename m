Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDXQdF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:33:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750826AbeDXQdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:33:02 -0400
Date: Tue, 24 Apr 2018 12:33:01 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Michal Hocko <mhocko@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        eric.dumazet@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
In-Reply-To: <20180424161242.GK17484@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1804241229410.23702@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180420130852.GC16083@dhcp22.suse.cz> <alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com> <20180420210200.GH10788@bombadil.infradead.org> <alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
 <20180421144757.GC14610@bombadil.infradead.org> <alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com> <20180423151545.GU17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804232006540.2299@file01.intranet.prod.int.rdu2.redhat.com>
 <20180424133146.GG17484@dhcp22.suse.cz> <alpine.LRH.2.02.1804241107010.31601@file01.intranet.prod.int.rdu2.redhat.com> <20180424161242.GK17484@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2018, Michal Hocko wrote:

> On Tue 24-04-18 11:30:40, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 24 Apr 2018, Michal Hocko wrote:
> > 
> > > On Mon 23-04-18 20:25:15, Mikulas Patocka wrote:
> > > 
> > > > Fixing __vmalloc code 
> > > > is easy and it doesn't require cooperation with maintainers.
> > > 
> > > But it is a hack against the intention of the scope api.
> > 
> > It is not!
> 
> This discussion simply doesn't make much sense it seems. The scope API
> is to document the scope of the reclaim recursion critical section. That
> certainly is not a utility function like vmalloc.

That 15-line __vmalloc bugfix doesn't prevent you (or any other kernel 
developer) from converting the code to the scope API. You make nonsensical 
excuses.

Mikulas
