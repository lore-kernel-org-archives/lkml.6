Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeDJMHW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:07:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeDJMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:07:21 -0400
Date: Tue, 10 Apr 2018 05:07:19 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Chris Fries <cfries@google.com>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410120719.GC22118@bombadil.infradead.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180410082243.GW21835@dhcp22.suse.cz>
 <20180410085531.m2xvzi7nenbrgbve@quack2.suse.cz>
 <20180410093241.GA21835@dhcp22.suse.cz>
 <20180410102845.3ixg2lbnumqn2o6z@quack2.suse.cz>
 <20180410111931.GA5113@rodete-laptop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410111931.GA5113@rodete-laptop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 08:19:31PM +0900, Minchan Kim wrote:
> If you're okay for that, I really want to go my original patch
> Michal already gave Acked-by.

I NAK this patch.  It is completely wrong.
