Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeDEGKS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:10:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58363 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeDEGKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:10:17 -0400
Date: Thu, 5 Apr 2018 08:10:15 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Buddy Lumpkin <buddy.lumpkin@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, mgorman@suse.de, willy@infradead.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 1/1 v2] vmscan: Support multiple kswapd threads per
 node
Message-ID: <20180405061015.GU6312@dhcp22.suse.cz>
References: <1522878594-52281-1-git-send-email-buddy.lumpkin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522878594-52281-1-git-send-email-buddy.lumpkin@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-04-18 21:49:54, Buddy Lumpkin wrote:
> v2:
> - Make update_kswapd_threads_node less racy
> - Handle locking for case where CONFIG_MEMORY_HOTPLUG=n

Please do not repost with such a small changes. It is much more
important to sort out the big picture first and only then deal with
minor implementation details. The more versions you post the more
fragmented and messy the discussion will become.

You will have to be patient because this is a rather big change and it
will take _quite_ some time to get sorted.

Thanks!
-- 
Michal Hocko
SUSE Labs
