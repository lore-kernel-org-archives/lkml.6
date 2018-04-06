Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeDFT6s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:58:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeDFT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:58:47 -0400
Date: Fri, 6 Apr 2018 12:58:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: JianKang Chen <chenjiankang1@huawei.com>, mgorman@techsingularity.net,
        hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xieyisheng1@huawei.com, guohanjun@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH resend] mm/page_alloc: fix comment is __get_free_pages
Message-Id: <20180406125845.72c7e116f53fc70e59302c99@linux-foundation.org>
In-Reply-To: <20180406100236.GK8286@dhcp22.suse.cz>
References: <1511780964-64864-1-git-send-email-chenjiankang1@huawei.com>
        <20171127113341.ldx32qvexqe2224d@dhcp22.suse.cz>
        <20171129160446.jluzpv3n6mjc3fwv@dhcp22.suse.cz>
        <20180406100236.GK8286@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 12:02:36 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 29-11-17 17:04:46, Michal Hocko wrote:
> [...]
> > From 000bb422fe07adbfa8cd8ed953b18f48647a45d6 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Wed, 29 Nov 2017 17:02:33 +0100
> > Subject: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
> > 
> > There is no real reason to blow up just because the caller doesn't know
> > that __get_free_pages cannot return highmem pages. Simply fix that up
> > silently. Even if we have some confused users such a fixup will not be
> > harmful.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Andrew, have we reached any conclusion for this? Should I repost or drop
> it on the floor?

I actually thought we'd settled on something and merged it.  hrm.

Please send a fresh patch sometime?
