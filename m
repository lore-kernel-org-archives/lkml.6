Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeDSQ2p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:42 -0400
Date: Thu, 19 Apr 2018 12:28:41 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Eric Dumazet <eric.dumazet@gmail.com>
cc: David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        edumazet@google.com, bhutchings@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
In-Reply-To: <6260a8af-3166-94d3-9441-104d342ab7a1@gmail.com>
Message-ID: <alpine.LRH.2.02.1804191228080.31175@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com> <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com> <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com> <20180418.134651.2225112489265654270.davem@davemloft.net>
 <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com> <6260a8af-3166-94d3-9441-104d342ab7a1@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2018, Eric Dumazet wrote:

> 
> 
> On 04/19/2018 09:12 AM, Mikulas Patocka wrote:
> > 
> > 
> > These bugs are hard to reproduce because vmalloc falls back to kmalloc
> > only if memory is fragmented.
> > 
> 
> This sentence is wrong.
> 
> .... because kvmalloc() falls back to vmalloc() ...

Yes. There should be "falls back to vmalloc()".

Mikulas
