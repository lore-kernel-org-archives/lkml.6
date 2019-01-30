Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E116C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFE920989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfA3VwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:52:06 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:40913 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfA3VwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:52:05 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 59CB540DF; Wed, 30 Jan 2019 22:52:04 +0100 (CET)
Date:   Wed, 30 Jan 2019 22:52:04 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     linux-mm@kvack.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, david@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH v2 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20190130215159.culyc2wcgocp5l2p@d104.suse.de>
References: <20190122103708.11043-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122103708.11043-1-osalvador@suse.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:37:04AM +0100, Oscar Salvador wrote:
> I yet have to check a couple of things like creating an accounting item
> like VMEMMAP_PAGES to show in /proc/meminfo to ease to spot the memory that
> went in there, testing Hyper-V/Xen to see how they react to the fact that
> we are using the beginning of the memory-range for our own purposes, and to
> check the thing about gigantic pages + hotplug.
> I also have to check that there is no compilation/runtime errors when
> CONFIG_SPARSEMEM but !CONFIG_SPARSEMEM_VMEMMAP.
> But before that, I would like to get people's feedback about the overall
> design, and ideas/suggestions.

just a friendly reminder if some feedback is possible :-)

-- 
Oscar Salvador
SUSE L3
