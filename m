Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C52C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97BD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeIGRKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:10:04 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:52424 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727598AbeIGRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:10:04 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 2506D98CDE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 12:29:19 +0000 (UTC)
Received: (qmail 9729 invoked from network); 7 Sep 2018 12:29:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2018 12:29:19 -0000
Date:   Fri, 7 Sep 2018 13:29:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/4] Follow-up fixes for v4.19-rc1 NUMA balancing
Message-ID: <20180907122917.GD1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907112455.GT24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180907112455.GT24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:24:55PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 07, 2018 at 11:11:35AM +0100, Mel Gorman wrote:
> > Srikar had an automatic NUMA balancing series merged during the 4.19 window
> > and there some issues I missed during review that this series addresses.
> > 
> > Patches 1-2 are simply removing redundant code and calculations that are
> > never used.
> 
> I already have those queued, from Vincent:
> 
>   https://lkml.kernel.org/r/1535548752-4434-1-git-send-email-vincent.guittot@linaro.org

They are exactly equivalent. Consider them acked!

-- 
Mel Gorman
SUSE Labs
