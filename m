Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFEJDx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:03:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbeFEJDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:03:51 -0400
Date: Tue, 5 Jun 2018 11:03:49 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: don't skip memory guarantee calculations
Message-ID: <20180605090349.GW19202@dhcp22.suse.cz>
References: <20180522132528.23769-1-guro@fb.com>
 <20180522132528.23769-2-guro@fb.com>
 <20180604122953.GN19202@dhcp22.suse.cz>
 <20180604162259.GA3404@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604162259.GA3404@castle>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-06-18 17:23:06, Roman Gushchin wrote:
[...]
> I'm happy to discuss any concrete issues/concerns, but I really see
> no reasons to drop it from the mm tree now and start the discussion
> from scratch.

I do not think this is ready for the current merge window. Sorry! I
would really prefer to see the whole thing in one series to have a
better picture.

-- 
Michal Hocko
SUSE Labs
