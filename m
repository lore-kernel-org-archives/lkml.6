Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeA3PP4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:15:56 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45820 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeA3PPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:15:53 -0500
X-Google-Smtp-Source: AH8x227YMv71s9q6/lLTGF1gXs9lfDpF3d24BSGcxgSGEcprKDy4YagaZSHUQAtTP1RX7jT8gXMzkA==
Date: Tue, 30 Jan 2018 07:15:49 -0800
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch -mm v2 2/3] mm, memcg: replace cgroup aware oom killer
 mount option with tunable
Message-ID: <20180130151549.GE1121507@devbig577.frc2.facebook.com>
References: <20180126143950.719912507bd993d92188877f@linux-foundation.org>
 <alpine.DEB.2.10.1801261441340.20954@chino.kir.corp.google.com>
 <20180126161735.b999356fbe96c0acd33aaa66@linux-foundation.org>
 <20180129104657.GC21609@dhcp22.suse.cz>
 <20180129191139.GA1121507@devbig577.frc2.facebook.com>
 <20180130085445.GQ21609@dhcp22.suse.cz>
 <20180130115846.GA4720@castle.DHCP.thefacebook.com>
 <20180130120852.GA21609@dhcp22.suse.cz>
 <20180130121315.GA5888@castle.DHCP.thefacebook.com>
 <20180130122011.GB21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130122011.GB21609@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:20:11PM +0100, Michal Hocko wrote:
> From 361275a05ad7026b8f721f8aa756a4975a2c42b1 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Tue, 30 Jan 2018 09:54:15 +0100
> Subject: [PATCH] oom, memcg: clarify root memcg oom accounting
> 
> David Rientjes has pointed out that the current way how the root memcg
> is accounted for the cgroup aware OOM killer is undocumented. Unlike
> regular cgroups there is no accounting going on in the root memcg
> (mostly for performance reasons). Therefore we are suming up oom_badness
> of its tasks. This might result in an over accounting because of the
> oom_score_adj setting. Document this for now.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks, Michal.

-- 
tejun
