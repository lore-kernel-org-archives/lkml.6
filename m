Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1BDC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58B3214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfAJRKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfAJRKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:10:37 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E1820685;
        Thu, 10 Jan 2019 17:10:36 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:10:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/9] x86/kprobes: Prohibit probing on optprobe template
 code
Message-ID: <20190110121034.766f37b4@gandalf.local.home>
In-Reply-To: <20190110235710.6b2a5cdb44ea05df73af997b@kernel.org>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
        <154708887054.6325.3201133039718891603.stgit@devbox>
        <20190110060720.GA12546@kroah.com>
        <20190110235710.6b2a5cdb44ea05df73af997b@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 23:57:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Same for all patches in this series...  
> 
> Oops, sorry. I'll fix the format again.
> BTW, I'm still considering I should make it other patches in this series
> as improvement instead of fix, since those are just adding blacklist, and
> usually user can avoid it with KPROBE_EVENTS_ON_NOTRACE=n (which is default).

The issue is that the other patches Cc stable, which they should not
unless they are to go to stable.

-- Steve
