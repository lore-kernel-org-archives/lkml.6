Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeEGOqs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:46:48 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49432 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeEGOqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:46:47 -0400
Date: Mon, 7 May 2018 10:48:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: drain stocks on resize limit
Message-ID: <20180507144835.GA5163@cmpxchg.org>
References: <20180504205548.110696-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504205548.110696-1-shakeelb@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:55:48PM -0700, Shakeel Butt wrote:
> Resizing the memcg limit for cgroup-v2 drains the stocks before
> triggering the memcg reclaim. Do the same for cgroup-v1 to make the
> behavior consistent.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
