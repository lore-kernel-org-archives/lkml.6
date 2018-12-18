Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240A22080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeLRMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:21:09 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:33868 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbeLRMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:21:08 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 621513C62; Tue, 18 Dec 2018 13:21:07 +0100 (CET)
Date:   Tue, 18 Dec 2018 13:21:07 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: do not report isolation failures for CMA pages
Message-ID: <20181218122107.vyvkxa5xg4hhfhtb@d104.suse.de>
References: <20181218092802.31429-1-mhocko@kernel.org>
 <20181218101831.ma3j5llxcsthibop@d104.suse.de>
 <20181218112822.GG30879@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218112822.GG30879@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:28:22PM +0100, Michal Hocko wrote:
> Well, I haven't seen any reports about hugetlb pages so I didn't bother
> to mention it. Is this really important to note?

I guess not.

> 
> > "Only report isolation failures from memhotplug code" ?
> 
> only report isolation failures when offlining memory

Yes, that looks good.
-- 
Oscar Salvador
SUSE L3
