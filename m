Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C083C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C00B218E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393123AbeLWDx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389248AbeLWDx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:53:28 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FDE218D9;
        Sun, 23 Dec 2018 03:53:26 +0000 (UTC)
Date:   Sat, 22 Dec 2018 22:53:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and
 usages
Message-ID: <20181222225325.6be0c77f@vmware.local.home>
In-Reply-To: <20181223034120.GF11421@danjae.aot.lge.com>
References: <20181222162007.697862256@goodmis.org>
        <20181223034120.GF11421@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 12:41:20 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > Steven Rostedt (VMware) (5):
> >       string.h: Add str_has_prefix() helper function
> >       tracing: Use str_has_prefix() helper for histogram code
> >       tracing: Use str_has_prefix() instead of using fixed sizes
> >       tracing: Have the historgram use the result of str_has_prefix() for len of prefix
> >       tracing: Use the return of str_has_prefix() to remove open coded numbers  
> 
> For the series:
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung!

-- Steve
