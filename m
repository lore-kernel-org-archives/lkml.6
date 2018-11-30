Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E297520834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E297520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:56:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:43410 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:56:44 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34E5A2E2;
        Fri, 30 Nov 2018 19:46:22 +0000 (UTC)
Date:   Fri, 30 Nov 2018 12:46:21 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RFC 14/15] lib: replace **** with a hug
Message-ID: <20181130124621.47a25ee2@lwn.net>
In-Reply-To: <20181130144111.067d447e@gandalf.local.home>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
        <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
        <20181130144111.067d447e@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:41:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > - * Wirzenius wrote this portably, Torvalds fucked it up :-)
> > + * Wirzenius wrote this portably, Torvalds hugged it up :-)  
> 
> Since the code has been greatly modified since that comment was added,
> I would say the comment is simply out of date.
> 
> Just nuke the comment, and that will be an accurate change with or
> without CoC.

For both patches, actually, I'd much rather see either deletion or a
rewrite over bleeping out words that somebody might not like.

jon
