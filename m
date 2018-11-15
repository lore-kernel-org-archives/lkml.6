Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968A8223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968A8223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeKORll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:41:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:32822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbeKORlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:41:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09CA5ABB1;
        Thu, 15 Nov 2018 07:34:59 +0000 (UTC)
Date:   Thu, 15 Nov 2018 08:34:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Congyang <tangchen@cn.fujitsu.com>,
        Tang Chen <wency@cn.fujitsu.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, memory_hotplug: do not clear numa_node
 association after hot_remove
Message-ID: <20181115073457.GB23831@dhcp22.suse.cz>
References: <20181108100413.966-1-mhocko@kernel.org>
 <20181114071442.GB23419@dhcp22.suse.cz>
 <20181114151809.06c43a508cc773d3a5ee04f4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114151809.06c43a508cc773d3a5ee04f4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 15:18:09, Andrew Morton wrote:
> On Wed, 14 Nov 2018 08:14:42 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > It seems there were no objections here. So can we have it in linux-next
> > for a wider testing a possibly target the next merge window?
> > 
> 
> top-posting sucks!

I thought it would make your life easier in this case. Will do it
differently next time.

> I already have this queued for 4.21-rc1.

Thanks! I must have missed the mm-commit email.

-- 
Michal Hocko
SUSE Labs
