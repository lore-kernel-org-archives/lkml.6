Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756722AbeDZPoa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:44:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755709AbeDZPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:44:27 -0400
Date: Thu, 26 Apr 2018 11:44:21 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        dm-devel@redhat.com, eric.dumazet@gmail.com, mst@redhat.com,
        netdev@vger.kernel.org, jasowang@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        edumazet@google.com, Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
 options
In-Reply-To: <1524756256.3226.7.camel@HansenPartnership.com>
Message-ID: <alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180424170349.GQ17484@dhcp22.suse.cz>   <alpine.LRH.2.02.1804241319390.28995@file01.intranet.prod.int.rdu2.redhat.com>   <20180424173836.GR17484@dhcp22.suse.cz>   <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
  <1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>   <alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>   <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>   <alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
  <1524694663.4100.21.camel@HansenPartnership.com>   <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>   <20180426125817.GO17484@dhcp22.suse.cz>   <alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
 <1524753932.3226.5.camel@HansenPartnership.com>  <alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com> <1524756256.3226.7.camel@HansenPartnership.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-1316700408-1524757462=:21152"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1316700408-1524757462=:21152
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 26 Apr 2018, James Bottomley wrote:

> On Thu, 2018-04-26 at 11:05 -0400, Mikulas Patocka wrote:
> > 
> > On Thu, 26 Apr 2018, James Bottomley wrote:
> [...]
> > > Perhaps find out beforehand instead of insisting on an approach
> > without
> > > knowing.  On openSUSE the grub config is built from the files in
> > > /etc/grub.d/ so any package can add a kernel option (and various
> > > conditions around activating it) simply by adding a new file.
> > 
> > And then, different versions of the debug kernel will clash when 
> > attempting to create the same file.
> 
> Don't be silly ... there are many ways of coping with that in rpm/dpkg.

I know you can deal with it - but how many lines of code will that 
consume? Multiplied by the total number of rpm-based distros.

Mikulas

--185206533-1316700408-1524757462=:21152--
