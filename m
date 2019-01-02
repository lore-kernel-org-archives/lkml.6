Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77287C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF9D206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfABMYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:24:55 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:34890 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbfABMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:24:55 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 6F6831C2829
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jan 2019 12:24:52 +0000 (GMT)
Received: (qmail 12175 invoked from network); 2 Jan 2019 12:24:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Jan 2019 12:24:52 -0000
Date:   Wed, 2 Jan 2019 12:24:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mm: compaction.c: Propagate return value upstream
Message-ID: <20190102122450.GD31517@techsingularity.net>
References: <20181226194257.11038-1-pakki001@umn.edu>
 <20181227035029.GE20878@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181227035029.GE20878@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 07:50:29PM -0800, Matthew Wilcox wrote:
> On Wed, Dec 26, 2018 at 01:42:56PM -0600, Aditya Pakki wrote:
> > In sysctl_extfrag_handler(), proc_dointvec_minmax() can return an
> > error. The fix propagates the error upstream in case of failure.
> 
> Why not just ...
> 
> Mel, Randy?  You seem to have been the prime instigators on this.
> 

Patch seems fine.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
