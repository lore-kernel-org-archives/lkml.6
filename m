Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9929620659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9929620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIEAVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:21:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIEAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:21:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB549CE5;
        Tue,  4 Sep 2018 19:55:03 +0000 (UTC)
Date:   Tue, 4 Sep 2018 12:55:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        npiggin@gmail.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/5] Extend and consolidate mmu_gather into new file
Message-Id: <20180904125501.642e1004825350aca476a653@linux-foundation.org>
In-Reply-To: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
References: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Sep 2018 12:45:28 +0100 Will Deacon <will.deacon@arm.com> wrote:

> This series builds on the core changes I previously posted here:
> 
>   rfc:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597821.html
>   v1:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/598919.html
> 
> The main changes are:
> 
>   * Move the mmu_gather bits out of memory.c and into their own file
>     (looped in the mm people for this)
> 
>   * Add a MAINTAINERS entry for the new file, and all tlb.h headers.
>     If any mm developers would like to be included here as well, please
>     just ask.
> 
> I'd like to queue these patches on their own branch in the arm64 git so
> that others can develop on top of them for the next merge window. Peter
> and Nick have both expressed an interest in that, and I already have a
> bunch of arm64 optimisations on top which I posted previously.

All looks good to me - please proceed that way.  Please also add me to
the MAINTAINERS record so I get more emails.

