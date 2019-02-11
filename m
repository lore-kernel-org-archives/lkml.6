Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A961C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0623B2229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbfBKTSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:18:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfBKTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:18:47 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21496D6DD;
        Mon, 11 Feb 2019 19:18:47 +0000 (UTC)
Date:   Mon, 11 Feb 2019 11:18:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 0/3] vmalloc enhancements
Message-Id: <20190211111845.fcc4210d35020a721149da74@linux-foundation.org>
In-Reply-To: <20190211190822.GA14443@cmpxchg.org>
References: <20181219173751.28056-1-guro@fb.com>
        <20190211190822.GA14443@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 14:08:22 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, Dec 19, 2018 at 09:37:48AM -0800, Roman Gushchin wrote:
> > The patchset contains few changes to the vmalloc code, which are
> > leading to some performance gains and code simplification.
> > 
> > Also, it exports a number of pages, used by vmalloc(),
> > in /proc/meminfo.
>
> These slipped through the cracks. +CC Andrew directly.
> Andrew, if it's not too late yet, could you consider them for 5.1?
> 

There's been some activity in vmalloc.c lately and these have
bitrotted.  They'll need a redo, please.

