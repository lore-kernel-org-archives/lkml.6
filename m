Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D29C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDC62147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfBHFBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:01:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBHFBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:01:43 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79C49BD47;
        Fri,  8 Feb 2019 05:01:42 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:01:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_poison: update comment after code moved
Message-Id: <20190207210141.f0c0b08841f53ba4ee668440@linux-foundation.org>
In-Reply-To: <20190207191113.14039-1-mst@redhat.com>
References: <20190207191113.14039-1-mst@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 14:11:16 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> mm/debug-pagealloc.c is no more, so of course header now needs to be
> updated. This seems like something checkpatch should be
> able to catch - worth looking into?
> 
> Cc: trivial@kernel.org
> Cc: linux-mm@kvack.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: akpm@linux-foundation.org
> Fixes: 8823b1dbc05f ("mm/page_poison.c: enable PAGE_POISONING as a separate option")

Please send along a signed-off-by: for this.
