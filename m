Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED6C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA0A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAXIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:53:29 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:54680 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbfAXIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:53:28 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 0E666B8B29
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:53:27 +0000 (GMT)
Received: (qmail 24754 invoked from network); 24 Jan 2019 08:53:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Jan 2019 08:53:26 -0000
Date:   Thu, 24 Jan 2019 08:53:25 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 00/22] Increase success rates and reduce latency of
 compaction v3
Message-ID: <20190124085325.GT27437@techsingularity.net>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190118175136.31341-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:51:14PM +0000, Mel Gorman wrote:
> This is a drop-in replacement for the series currently in Andrews tree that
> incorporates static checking and compile warning fixes (Dan, YueHaibing)
> and extensive review feedback from Vlastimil. Big thanks to Vlastimil as
> the review was extremely detailed and a number of issues were caught. Not
> all the patches have been acked but I think an update is still worthwhile.
> 
> Andrew, please drop the series you have and replace it with the following
> on the off-chance we get bug reports that are fixed already. Doing this
> with -fix patches would be relatively painful for little gain.
> 

Andrew?

-- 
Mel Gorman
SUSE Labs
