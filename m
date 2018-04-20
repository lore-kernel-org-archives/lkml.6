Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeDTLeI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40611 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754549AbeDTLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:34:07 -0400
Date: Fri, 20 Apr 2018 13:34:04 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, torvalds@linux-foundation.org,
        pasha.tatashin@oracle.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: use PHYS_ADDR_MAX to avoid type casting
 ULLONG_MAX
Message-ID: <20180420113404.GZ17484@dhcp22.suse.cz>
References: <20180419214204.19322-1-stefan@agner.ch>
 <20180420111510.GA10788@bombadil.infradead.org>
 <d91c35be6f85a20028910babb35243d0@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91c35be6f85a20028910babb35243d0@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-04-18 13:20:10, Stefan Agner wrote:
> On 20.04.2018 13:15, Matthew Wilcox wrote:
> > On Thu, Apr 19, 2018 at 11:42:04PM +0200, Stefan Agner wrote:
> >> With PHYS_ADDR_MAX there is now a type safe variant for all
> >> bits set. Make use of it.
> > 
> > There is?  I don't see it in linux-next.
> 
> The patch "mm/memblock: introduce PHYS_ADDR_MAX" got merged earlier this
> week, should be in the -mm tree.

Andrew hasn't released his mmotm tree yet so this is not in linux-next
yet as well.
-- 
Michal Hocko
SUSE Labs
