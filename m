Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53966C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4372173C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeLVSDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbeLVSC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:02:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FAE20874;
        Sat, 22 Dec 2018 18:02:58 +0000 (UTC)
Date:   Sat, 22 Dec 2018 13:02:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for
 histogram code
Message-ID: <20181222130256.1f9de57c@gandalf.local.home>
In-Reply-To: <20181222130107.43aaac9c@gandalf.local.home>
References: <20181222162007.697862256@goodmis.org>
        <20181222162856.666843139@goodmis.org>
        <20181222130107.43aaac9c@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 13:01:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Cc: Tom Zanussi <zanussi@linux.intel.com>  
> 
> I have no idea why I copied your intel email. The linux.intel.com
> appears to be no longer active. I'm going to rebase to fix this email
> address.

Looking at the other patches, I guess I cut and pasted wrong.

I see:  Tom Zanussi <tom.zanussi@linux.intel.com>

(with the "tom." part missing in this patch).

Still I'll fix it.

-- Steve
