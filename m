Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E5E2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E5E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKOJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:23:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:23:30 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96C20B6E;
        Wed, 14 Nov 2018 23:18:10 +0000 (UTC)
Date:   Wed, 14 Nov 2018 15:18:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Congyang <tangchen@cn.fujitsu.com>,
        Tang Chen <wency@cn.fujitsu.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, memory_hotplug: do not clear numa_node
 association after hot_remove
Message-Id: <20181114151809.06c43a508cc773d3a5ee04f4@linux-foundation.org>
In-Reply-To: <20181114071442.GB23419@dhcp22.suse.cz>
References: <20181108100413.966-1-mhocko@kernel.org>
        <20181114071442.GB23419@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 08:14:42 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> It seems there were no objections here. So can we have it in linux-next
> for a wider testing a possibly target the next merge window?
> 

top-posting sucks!

I already have this queued for 4.21-rc1.
