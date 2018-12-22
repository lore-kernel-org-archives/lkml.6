Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210FA2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbeLVRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390038AbeLVRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:15 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E7C2192C;
        Sat, 22 Dec 2018 04:42:07 +0000 (UTC)
Date:   Fri, 21 Dec 2018 23:42:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181221234205.07a04b96@vmware.local.home>
In-Reply-To: <20181221231924.4583e90b@vmware.local.home>
References: <20181221231924.4583e90b@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 23:19:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

This should have been:

Suggestions-by: Linus Torvalds ...

But I went back to a further reflog when doing a reset --hard to get
back to returning length from str_has_prefix, which didn't have this
update.

-- Steve
 

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggestions-by: Joe Perches <joe@perches.com>
> Suggestions-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
