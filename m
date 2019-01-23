Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA0C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33E7217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfAWBLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:11:07 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:35373 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfAWBLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:11:06 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 6394C5C2617; Wed, 23 Jan 2019 02:10:46 +0100 (CET)
Date:   Wed, 23 Jan 2019 02:10:46 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
Message-ID: <20190123011046.GA26908@osadl.at>
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
 <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz>
 <20ef1d3a-2916-ce00-2938-3397746efac9@redhat.com>
 <alpine.LSU.2.21.1812180934090.9644@pobox.suse.cz>
 <adeb1bca-9fa1-b150-d551-a9cf0853a63b@redhat.com>
 <13b0bd3d-1441-b83b-bee3-d5fc666a9d26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b0bd3d-1441-b83b-bee3-d5fc666a9d26@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:30:30AM -0500, Joe Lawrence wrote:
> On 12/18/18 10:18 AM, Joe Lawrence wrote:
> >On 12/18/2018 03:49 AM, Miroslav Benes wrote:
> >>On Mon, 17 Dec 2018, Joe Lawrence wrote:
> >>
> >>>I'm just being picky about its documentation and how we should note its
> >>>usage in the v3 patch.  Think that s/__noclone/used/g of the v2 commit
> >>>message would be sufficient?
> >>
> >>We could rephrase it. After all it is not only about symbol names in the
> >>symbol table. The traceable/patchable code has to be present...
> >>
> >>"Sparse reported warnings about non-static symbols. For the variables
> >>a simple static attribute is fine - for the functions referenced by
> >>livepatch via klp_func the symbol-names must be unmodified in the
> >>symbol table and the patchable code has to be emitted.
> >>
> >>Attach __used attribute to the shared statically declared functions."
> >>
> >>?
> >
> >That works for me.
> >
> Hi Nicholas,
> 
> Did you still want to post a v3 for this fix?  I think there were only a few
> v3 suggestions (link tag, tag order, __used attribute, and commit msg
> phrasing.)
>
yup - will go cleanup and repost.

thx!
hofrat 
