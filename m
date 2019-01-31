Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17528C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4C02086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfAaWvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:51:55 -0500
Received: from dliviu.plus.com ([80.229.23.120]:59670 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfAaWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:51:55 -0500
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 8F20341D13D6;
        Thu, 31 Jan 2019 22:51:52 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 31 Jan 2019 22:51:52 +0000
Date:   Thu, 31 Jan 2019 22:51:52 +0000
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tags needs some work in the akpm-current tree
Message-ID: <20190131225151.GA3110@bart.dudau.co.uk>
References: <20190131110541.3f3a808c@canb.auug.org.au>
 <6d110fc4-85b6-cf66-6045-dc81956ffc5c@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d110fc4-85b6-cf66-6045-dc81956ffc5c@lca.pw>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:51:42PM -0500, Qian Cai wrote:
> 
> 
> On 1/30/19 7:05 PM, Stephen Rothwell wrote:
> > In commit
> > 
> >   6e9ed490d190 ("mm/page_owner: fix for deferred struct page init")
> > 
> > Fixes tag
> > 
> >   Fixes: fe53ca54270 ("mm: use early_pfn_to_nid in page_ext_init")
> > 
> > has these problem(s):
> > 
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
> > 
> 
> I think it is better to replace with this version instead,
> 
> https://lore.kernel.org/lkml/20190115202812.75820-1-cai@lca.pw/


That patch does not look related, afaict.

Andrew, do you want me to re-send the patch with a fixed commit log, or are you OK to
do some inline editing?

Best regards,
Liviu


-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\
