Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeDZTFU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:05:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34003 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeDZTFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:05:19 -0400
Date: Thu, 26 Apr 2018 22:05:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        dm-devel@redhat.com, eric.dumazet@gmail.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, edumazet@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
 fallback options
Message-ID: <20180426220314-mutt-send-email-mst@kernel.org>
References: <1524694663.4100.21.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
 <20180426125817.GO17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
 <1524753932.3226.5.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
 <1524756256.3226.7.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
 <20180426184845-mutt-send-email-mst@kernel.org>
 <alpine.LRH.2.02.1804261454380.23716@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804261454380.23716@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 02:58:08PM -0400, Mikulas Patocka wrote:
> 
> 
> On Thu, 26 Apr 2018, Michael S. Tsirkin wrote:
> 
> > How do you make sure QA tests a specific corner case? Add it to
> > the test plan :)
> 
> BTW. how many "lines of code" of corporate bureaucracy would that take? :-)

It's pretty easy at least here at Red Hat.

> > I don't speak for Red Hat, etc.
> > 
> > -- 
> > MST
> 
> Mikulas
