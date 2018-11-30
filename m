Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEE12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeLAHA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:00:29 -0500
Received: from twin.jikos.cz ([91.219.245.39]:35458 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeLAHA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:00:28 -0500
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id wAUJnTFO025786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 30 Nov 2018 20:49:29 +0100
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id wAUJnSxR025783;
        Fri, 30 Nov 2018 20:49:28 +0100
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Fri, 30 Nov 2018 20:49:28 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RFC 14/15] lib: replace **** with a hug
In-Reply-To: <20181130124621.47a25ee2@lwn.net>
Message-ID: <alpine.LRH.2.00.1811302048500.18805@gjva.wvxbf.pm>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>        <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>        <20181130144111.067d447e@gandalf.local.home> <20181130124621.47a25ee2@lwn.net>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Jonathan Corbet wrote:

> > Since the code has been greatly modified since that comment was added,
> > I would say the comment is simply out of date.
> > 
> > Just nuke the comment, and that will be an accurate change with or
> > without CoC.
> 
> For both patches, actually, I'd much rather see either deletion or a
> rewrite over bleeping out words that somebody might not like.

Exactly. Turning comments into something that often doesn't make sense to 
anybody at all is hardly productive.

-- 
Jiri Kosina
SUSE Labs
