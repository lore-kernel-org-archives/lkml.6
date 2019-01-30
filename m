Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D104C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D9A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfA3Hyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:54:47 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:4165 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfA3Hyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:54:46 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 3C38840CF; Wed, 30 Jan 2019 08:54:45 +0100 (CET)
Date:   Wed, 30 Jan 2019 08:54:45 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memory_hotplug: is_mem_section_removable do not
 pass the end of a zone
Message-ID: <20190130075445.czrecevdvjgxed75@d104.suse.de>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190128144506.15603-2-mhocko@kernel.org>
 <20190129090605.lenisalq2zxtck3u@d104.suse.de>
 <20190129091224.GG18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129091224.GG18811@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:12:24AM +0100, Michal Hocko wrote:
> Yes, those pages should be unreachable because they are out of the zone.
> Reasons might be various. The memory range is not mem section aligned,
> or cut due to mem parameter etc.

I see, thanks.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
