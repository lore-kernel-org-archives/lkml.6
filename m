Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE07C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B08A218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfAaVJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:09:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfAaVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:09:01 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 263234CAC;
        Thu, 31 Jan 2019 21:09:00 +0000 (UTC)
Date:   Thu, 31 Jan 2019 13:08:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong jiang <zhongjiang@huawei.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Shuriyc Chu <sureeju@gmail.com>, Joe Perches <joe@perches.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 akpm-current tree
Message-Id: <20190131130859.b4fc9a18405008f08130abb6@linux-foundation.org>
In-Reply-To: <20190131111046.36de09c3@canb.auug.org.au>
References: <20190131111046.36de09c3@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 11:10:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commits
> 
>   7a738192604a ("mm/page_owner: align with pageblock_nr_pages")
>   ed2205fd9fc0 ("filemap-drop-the-mmap_sem-for-all-blocking-operations-fix")
>   d5b0dce6cd86 ("mm-swap-check-if-swap-backing-device-is-congested-or-not-fix-2")
>   bce20e289b36 ("vmalloc-add-test-driver-to-analyse-vmalloc-allocator-fix")

Yes, they'll all vanish later.

>   e59a90e1c227 ("fs/file.c: initialize init_files.resize_wait")

I've asked Shuriyc to send us a Signed-off-by: for this?

>   8a97a2585bb6 ("checkpatch: don't interpret stack dumps as commit IDs")

a temp for-testing thing from Joe.  I've seen no problems, so perhaps
he can send along a real version?

