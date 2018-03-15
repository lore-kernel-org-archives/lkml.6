Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCOHnf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeCOHne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:43:34 -0400
Date: Thu, 15 Mar 2018 08:43:32 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mm-commits@vger.kernel.org, rdunlap@infradead.org
Subject: Re: + headers-untangle-kmemleakh-from-mmh-fix.patch added to -mm tree
Message-ID: <20180315074332.GS23100@dhcp22.suse.cz>
References: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
 <20180314121704.GA23036@dhcp22.suse.cz>
 <20180315080001.3737e5c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315080001.3737e5c8@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-03-18 08:00:01, Stephen Rothwell wrote:
> Hi Michal,
> 
> On Wed, 14 Mar 2018 13:17:04 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> >
> > My build test battery says we need also this one, m32r complains
> > otherwise for allmodconfig.
> 
> Note that the m32r architecture is being removed (the removal will be
> in linux-next today) so you might want to remove it from your testing.

Sure, will happily do
 
> Also cris, metag, mn10300, frv, score, blackfin and tile.

Those were not in my list due to predominating failures.

Thanks!
-- 
Michal Hocko
SUSE Labs
