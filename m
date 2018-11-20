Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9ABC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C17120989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C17120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeKUBVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:21:38 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:41278 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKUBVi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 20 Nov 2018 20:21:38 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 20 Nov 2018 15:52:05 +0100
Received: from [149.44.172.157] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 20 Nov 2018 14:51:49 +0000
Message-ID: <1542725492.6817.3.camel@suse.com>
Subject: Re: [RFC PATCH 1/3] mm, memory_hotplug: try to migrate full section
 worth of pages
From:   osalvador <osalvador@suse.com>
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Date:   Tue, 20 Nov 2018 15:51:32 +0100
In-Reply-To: <20181120134323.13007-2-mhocko@kernel.org>
References: <20181120134323.13007-1-mhocko@kernel.org>
         <20181120134323.13007-2-mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-20 at 14:43 +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> do_migrate_range has been limiting the number of pages to migrate to
> 256
> for some reason which is not documented. 

When looking back at old memory-hotplug commits one feels pretty sad
about the brevity of the changelogs.

> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
