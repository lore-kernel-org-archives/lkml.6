Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1AB2152D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1AB2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeHVAFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:05:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:05:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D493B9DA;
        Tue, 21 Aug 2018 20:43:19 +0000 (UTC)
Date:   Tue, 21 Aug 2018 13:43:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v4 0/4] Refactoring for
 remove_memory_section/unregister_mem_sect_under_nodes
Message-Id: <20180821134318.f743b6c58f2b5a91e17e596e@linux-foundation.org>
In-Reply-To: <20180821162122.GA10300@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
        <20180821162122.GA10300@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 18:21:22 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:

> On Fri, Aug 17, 2018 at 11:00:13AM +0200, Oscar Salvador wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > v3 -> v4:
> >         - Make nodemask_t a stack variable
> >         - Added Reviewed-by from David and Pavel
> > 
> > v2 -> v3:
> >         - NODEMASK_FREE can deal with NULL pointers, so do not
> >           make it conditional (by David).
> >         - Split up node_online's check patch (David's suggestion)
> >         - Added Reviewed-by from Andrew and David
> >         - Fix checkpath.pl warnings
> 
> Andrew, will you pick up this patchset?
> I saw that v3 was removed from the -mm tree because it was about
> to be updated with a new version (this one), but I am not sure if
> anything wrong happened.

Yes, things are still changing and we're late in the merge window.  I
decided to park it and shall take it up again after 4.19-rc1.

