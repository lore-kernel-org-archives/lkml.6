Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeBVN0f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:26:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:47292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbeBVN0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:26:34 -0500
Date: Thu, 22 Feb 2018 14:26:30 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mm-commits@vger.kernel.org,
        sfr@canb.auug.org.au,
        richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: mmotm 2018-02-21-14-48 uploaded (mm/page_alloc.c on UML)
Message-ID: <20180222132630.GH30681@dhcp22.suse.cz>
References: <20180221224839.MqsDtkGCK%akpm@linux-foundation.org>
 <7bcc52db-57eb-45b0-7f20-c93a968599cd@infradead.org>
 <20180222072037.GC30681@dhcp22.suse.cz>
 <20180222103832.GA11623@vmlxhi-102.adit-jv.com>
 <20180222125955.GD30681@dhcp22.suse.cz>
 <20180222130814.GA30385@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222130814.GA30385@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-02-18 14:08:14, Eugeniu Rosca wrote:
> On Thu, Feb 22, 2018 at 01:59:55PM +0100, Michal Hocko wrote:
> > On Thu 22-02-18 11:38:32, Eugeniu Rosca wrote:
> > > Hi Michal,
> > > 
> > > Please, let me know if any action is expected from my end.
> > 
> > I do not thing anything is really needed right now. If you have a strong
> > opinion about the solution (ifdef vs. noop stub) then speak up.
> 
> No different preference on my side. I was more thinking if you are going
> to amend the patch or create a fix on top of it. Since it didn't reach
> mainline, it makes sense to amend it. If you can do it without the
> intervention of the author, that's also fine for me.

Andrew usually takes the incremental fix and then squash them when
sending to Linus

-- 
Michal Hocko
SUSE Labs
