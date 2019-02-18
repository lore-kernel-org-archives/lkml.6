Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388FC21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbfBROcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:32:11 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:58751 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389711AbfBROcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:32:07 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 57A17B8764
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 14:32:05 +0000 (GMT)
Received: (qmail 6242 invoked from network); 18 Feb 2019 14:32:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Feb 2019 14:32:05 -0000
Date:   Mon, 18 Feb 2019 14:32:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [LSF/MM ATTEND] MM track: NUMA, THP locality, reclaim
Message-ID: <20190218143203.GW9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to attend the MM track of LSF/MM if a slot is available. My
involvement in MM-specific topics tend to be a little sporadic given my
current role but I generally pop up for some page allocator, compaction,
NUMA, reclaim and THP topics in particular. Recent contributions have
been primarily compaction and fragmentation control related with a number
of patches queued up in Andrew's tree for 5.1-rc1 that finally seems to
have stopped generating bug reports.

I'm particularly interested in the following proposals in rough order
of interest;

o NUMA remote THP vs NUMA local non-THP under MADV_HUGEPAGE
o NUMA, memory hierarchy and device memory
o Memory reclaim with NUMA rebalancing

The other topics are interesting but these are the three I'm likely
to spend the most brain power on. At this time I'm not proposing a
topic. While I'm periodically kicking a compaction-related series around,
I don't expect it to be particularly controversial that would warrant a
discussion. That might change, particularly if it starts colliding with
"NUMA remote THP vs NUMA local non-THP under MADV_HUGEPAGE". If so, I'll
do a topic proposal later or beg/borrow/steal a lightening talk slot.

-- 
Mel Gorman
SUSE Labs
