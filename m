Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE559C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04B52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfAaW5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:57:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAaW5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:57:36 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55E444E94;
        Thu, 31 Jan 2019 22:57:35 +0000 (UTC)
Date:   Thu, 31 Jan 2019 14:57:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Qian Cai <cai@lca.pw>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tags needs some work in the akpm-current tree
Message-Id: <20190131145734.80036199beb369d3ceb0123a@linux-foundation.org>
In-Reply-To: <20190131225151.GA3110@bart.dudau.co.uk>
References: <20190131110541.3f3a808c@canb.auug.org.au>
        <6d110fc4-85b6-cf66-6045-dc81956ffc5c@lca.pw>
        <20190131225151.GA3110@bart.dudau.co.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 22:51:52 +0000 Liviu Dudau <liviu@dudau.co.uk> wrote:

> On Wed, Jan 30, 2019 at 08:51:42PM -0500, Qian Cai wrote:
> > 
> > 
> > On 1/30/19 7:05 PM, Stephen Rothwell wrote:
> > > In commit
> > > 
> > >   6e9ed490d190 ("mm/page_owner: fix for deferred struct page init")
> > > 
> > > Fixes tag
> > > 
> > >   Fixes: fe53ca54270 ("mm: use early_pfn_to_nid in page_ext_init")
> > > 
> > > has these problem(s):
> > > 
> > >   - SHA1 should be at least 12 digits long
> > >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> > >     or later) just making sure it is not set (or set to "auto").
> > > 
> > 
> > I think it is better to replace with this version instead,
> > 
> > https://lore.kernel.org/lkml/20190115202812.75820-1-cai@lca.pw/
> 
> 
> That patch does not look related, afaict.

Confused.

https://lore.kernel.org/lkml/20190115202812.75820-1-cai@lca.pw/
and
https://lore.kernel.org/lkml/20181220203156.43441-1-cai@lca.pw/T/#u

are very much related?

> Andrew, do you want me to re-send the patch with a fixed commit log, or are you OK to
> do some inline editing?

Resend what, exactly?
