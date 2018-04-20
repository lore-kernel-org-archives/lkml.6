Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbeDTIJz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50425 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754426AbeDTIJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:09:52 -0400
Date: Fri, 20 Apr 2018 10:09:48 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Minchan Kim <minchan@kernel.org>
Cc: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180420080948.GV17484@dhcp22.suse.cz>
References: <20180418022912.248417-1-minchan@kernel.org>
 <20180418072002.GN17484@dhcp22.suse.cz>
 <20180418074117.GA210164@rodete-desktop-imager.corp.google.com>
 <20180418075437.GP17484@dhcp22.suse.cz>
 <20180418132328.GB210164@rodete-desktop-imager.corp.google.com>
 <20180418132715.GD17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804181152240.227784@chino.kir.corp.google.com>
 <20180419064005.GL17484@dhcp22.suse.cz>
 <20180420054239.GA221997@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420054239.GA221997@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-04-18 14:42:39, Minchan Kim wrote:
[...]
> When I see replies of this thread, it's arguble to add such one-line
> warn so if you want it strongly, could you handle by yourself?

I do not feel strongly about it to argue as well. So the patch Andrew
added with a better explanation is sufficient from my POV.
-- 
Michal Hocko
SUSE Labs
