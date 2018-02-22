Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeBVNI1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:08:27 -0500
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:59851 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeBVNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:08:25 -0500
Date: Thu, 22 Feb 2018 14:08:14 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, <akpm@linux-foundation.org>,
        <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mm-commits@vger.kernel.org>,
        <sfr@canb.auug.org.au>,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: mmotm 2018-02-21-14-48 uploaded (mm/page_alloc.c on UML)
Message-ID: <20180222130814.GA30385@vmlxhi-102.adit-jv.com>
References: <20180221224839.MqsDtkGCK%akpm@linux-foundation.org>
 <7bcc52db-57eb-45b0-7f20-c93a968599cd@infradead.org>
 <20180222072037.GC30681@dhcp22.suse.cz>
 <20180222103832.GA11623@vmlxhi-102.adit-jv.com>
 <20180222125955.GD30681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180222125955.GD30681@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 01:59:55PM +0100, Michal Hocko wrote:
> On Thu 22-02-18 11:38:32, Eugeniu Rosca wrote:
> > Hi Michal,
> > 
> > Please, let me know if any action is expected from my end.
> 
> I do not thing anything is really needed right now. If you have a strong
> opinion about the solution (ifdef vs. noop stub) then speak up.

No different preference on my side. I was more thinking if you are going
to amend the patch or create a fix on top of it. Since it didn't reach
mainline, it makes sense to amend it. If you can do it without the
intervention of the author, that's also fine for me.

> > Thank you for your support and sorry for the ifdef troubles.
> 
> No troubles at all. It was me who pushed you this direction...
> -- 
> Michal Hocko
> SUSE Labs

Thanks,
Eugeniu.
