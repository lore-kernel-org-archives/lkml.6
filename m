Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDDOMh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:12:37 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49984 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeDDOMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:12:36 -0400
Date: Wed, 4 Apr 2018 10:13:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: mhocko@kernel.org, vdavydov.dev@gmail.com, guro@fb.com,
        riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] mm: memcontrol: Remove lruvec_stat
Message-ID: <20180404141355.GB28966@cmpxchg.org>
References: <20180324160901.512135-1-tj@kernel.org>
 <20180324160901.512135-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324160901.512135-4-tj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 09:09:01AM -0700, Tejun Heo wrote:
> lruvec_stat doesn't have any consumer.  Remove it.

This tracks counters at the node-memcg intersection, which is a
requirement for Josef's shrinker rework.

I don't know what happened to that patch series. Josef, Andrew?
