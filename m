Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FE82151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FE82151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:46:29 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:37788 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbeJQRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:46:29 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id E9B6F1C19CB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:51:32 +0100 (IST)
Received: (qmail 27860 invoked from network); 17 Oct 2018 09:51:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Oct 2018 09:51:32 -0000
Date:   Wed, 17 Oct 2018 10:51:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 1/5] mm/page_alloc: use helper functions to
 add/remove a page to/from buddy
Message-ID: <20181017095131.GI5819@techsingularity.net>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181017063330.15384-2-aaron.lu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:33:26PM +0800, Aaron Lu wrote:
> There are multiple places that add/remove a page into/from buddy,
> introduce helper functions for them.
> 
> This also makes it easier to add code when a page is added/removed
> to/from buddy.
> 
> No functionality change.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
