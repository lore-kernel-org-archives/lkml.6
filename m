Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEQNVR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeEQNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:21:14 -0400
Date: Thu, 17 May 2018 15:21:09 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tony Lindgren <tony@atomide.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>, Rik van Riel <riel@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm/cma: manage the memory of the CMA area by
 using the ZONE_MOVABLE"
Message-ID: <20180517132109.GU12670@dhcp22.suse.cz>
References: <20180517125959.8095-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517125959.8095-1-ville.syrjala@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-05-18 15:59:59, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> This reverts commit bad8c6c0b1144694ecb0bc5629ede9b8b578b86e.
> 
> Make x86 with HIGHMEM=y and CMA=y boot again.

Is there any bug report with some more details? It is much more
preferable to fix the issue rather than to revert the whole thing
right away.
-- 
Michal Hocko
SUSE Labs
