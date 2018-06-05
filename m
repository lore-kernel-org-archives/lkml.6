Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeFEK2w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:28:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56117 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeFEK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:28:51 -0400
Date: Tue, 5 Jun 2018 12:28:49 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: don't skip memory guarantee calculations
Message-ID: <20180605102849.GZ19202@dhcp22.suse.cz>
References: <20180522132528.23769-1-guro@fb.com>
 <20180522132528.23769-2-guro@fb.com>
 <20180604122953.GN19202@dhcp22.suse.cz>
 <20180604162259.GA3404@castle>
 <20180605090349.GW19202@dhcp22.suse.cz>
 <20180605101544.GB5464@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605101544.GB5464@castle>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-06-18 11:15:45, Roman Gushchin wrote:
> On Tue, Jun 05, 2018 at 11:03:49AM +0200, Michal Hocko wrote:
> > On Mon 04-06-18 17:23:06, Roman Gushchin wrote:
> > [...]
> > > I'm happy to discuss any concrete issues/concerns, but I really see
> > > no reasons to drop it from the mm tree now and start the discussion
> > > from scratch.
> > 
> > I do not think this is ready for the current merge window. Sorry! I
> > would really prefer to see the whole thing in one series to have a
> > better picture.
> 
> Please, provide any specific reason for that. I appreciate your opinion,
> but *I think* it's not an argument, seriously.

Seeing two follow up fixes close to the merge window just speaks for
itself. Besides that there is not need to rush this now.
 
> We've discussed the patchset back to March and I made several iterations
> based on the received feedback. Later we had a separate discussion with Greg,
> who proposed an alternative solution, which, unfortunately, had some serious
> shortcomings. And, as I remember, some time ago we've discussed memory.min
> with you.
> And now you want to start from scratch without providing any reason.
> I find it counter-productive, sorry.

I am sorry I couldn't give it more time, but this release cycle was even
crazier than usual.
-- 
Michal Hocko
SUSE Labs
