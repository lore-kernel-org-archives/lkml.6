Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1833921916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBHW3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:29:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60226 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:29:31 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gsEe8-0001kI-R7; Fri, 08 Feb 2019 22:29:21 +0000
Date:   Fri, 8 Feb 2019 22:29:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] hugetlbfs: a terminator for hugetlb_param_specs[]
Message-ID: <20190208222920.GG2217@ZenIV.linux.org.uk>
References: <ce8d60c2-5166-6c40-011f-4dff8dc25ebe@oracle.com>
 <20190205012224.65672-1-cai@lca.pw>
 <16207.1549643499@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16207.1549643499@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:31:39PM +0000, David Howells wrote:
> Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > Thanks for fixing this.  Looks like a simple oversight when 2284cf59cbce
> > was added.
> 
> I've already pushed a fix for this which Al should have folded in already.

It has been in -next since Tuesday.
