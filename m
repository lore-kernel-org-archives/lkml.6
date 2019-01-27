Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD72C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A5B214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA0KI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:08:26 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:40343 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfA0KIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:08:25 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 94A955C0FEA; Sun, 27 Jan 2019 11:08:04 +0100 (CET)
Date:   Sun, 27 Jan 2019 11:08:04 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] livepatch: non static warnings fix
Message-ID: <20190127100804.GA32729@osadl.at>
References: <1548294496-22719-1-git-send-email-hofrat@osadl.org>
 <nycvar.YFH.7.76.1901251644040.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.1901251644040.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 04:44:18PM +0100, Jiri Kosina wrote:
> On Thu, 24 Jan 2019, Nicholas Mc Guire wrote:
> 
> > Sparse reported warnings about non-static symbols. For the variables
> > a simple static attribute is fine - for the functions referenced by
> > livepatch via klp_func the symbol-names must be unmodified in the
> > symbol table and the patchable code has to be emitted. The resolution
> > is to attach __used attribute to the shared statically declared functions.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Acked-by: Miroslav Benes <mbenes@suse.cz>
> > Link: https://lore.kernel.org/lkml/1544965657-26804-1-git-send-email-hofrat@osadl.org/
> 
> I've reordered the tags :) and applied. Thanks,
>

thx for your patience - I´ll try getting this streight a bit faster next time

thx!
hofrat 
