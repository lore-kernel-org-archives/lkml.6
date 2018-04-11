Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeDKFuH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeDKFuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:50:06 -0400
Date: Wed, 11 Apr 2018 07:50:02 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Thelen <gthelen@google.com>, Wang Long <wanglong19@meituan.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        npiggin@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] writeback: safer lock nesting
Message-ID: <20180411055002.GA30893@dhcp22.suse.cz>
References: <201804080259.VS5U0mKT%fengguang.wu@intel.com>
 <20180410005908.167976-1-gthelen@google.com>
 <20180410063357.GS21835@dhcp22.suse.cz>
 <20180410134837.d2b0f2d1cd940bb08c2bad0a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410134837.d2b0f2d1cd940bb08c2bad0a@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 13:48:37, Andrew Morton wrote:
> On Tue, 10 Apr 2018 08:33:57 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > Reported-by: Wang Long <wanglong19@meituan.com>
> > > Signed-off-by: Greg Thelen <gthelen@google.com>
> > > Change-Id: Ibb773e8045852978f6207074491d262f1b3fb613
> > 
> > Not a stable material IMHO
> 
> Why's that?  Wang Long said he's observed the deadlock three times?

I thought it is just too unlikely to hit all the conditions. My fault,
I have completely missed/forgot the fact Wang Long is seeing the issue
happening.

No real objection for the stable backport from me.

-- 
Michal Hocko
SUSE Labs
