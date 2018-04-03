Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/19G2YUTuaB/yoGT27wiolDzlBye9KoHI8urw7KIKW1+L33Whj6/FSQe/FM5fFlJGSL38n
ARC-Seal: i=1; a=rsa-sha256; t=1522756984; cv=none;
        d=google.com; s=arc-20160816;
        b=YTGfQbVVoILBtQW86Cyjw7RMyoUokuAeMz+XpKIbnlbBM5qQWpRurRNhuItRrvdJYE
         cxlx6e2guuvs0n7Pn2HBT+xDQbrAREkLdpa17Fehd5m/BDcIxV4mwRlO+jXM3wITnZj+
         jYB4iVftztyIjigRHr/kxhGX8xyQee3fS7yUzcxq3h/MVNF3iZJEb7M9pC2ue48/1DoH
         y7ksLlOS6tHMcWtVVpJJwG4WENWc5cWnPUz/ih+jNR9I07+OUPXjeJt/ReTO9s4W8VjK
         cqZqLjNmzHl5Fxni5iWaIcYrEGMh1rW5TZ4kLahWtpWCn9+GSQvYBEnXJ9uOIOogp6w4
         234w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=rdPeSMEsXneill/xdQnDgBpO4cU1P++2sMbIP6hM9pQ=;
        b=cr3Je9PqILnWV38sgr1CkPVO1fjdetNvawxGK4TZw+x4UbLvGM8aKjIKQQsL9pGxAz
         MHGGx7lpjKfW2TVuChg1HBIrjJYdx/dJZngIVJOv9bOzETGdl9BuVn7ZJ/ShDFtXg5ID
         lc/V2jRomGkglqKnIRVulaz3hS8vhpSMu1EyIM0UXQt2yYQUbLAiLRlejfLsxggW+Ucu
         A81/6rt+theg2tuxulLgchxMZFJsKoJARpN9RK54u9vuncw5cOYU2laPD07t9LYfIJ65
         pxdd4cP6JqS7YXthYShXnstzd7xxDizqdnOvNtI/NlAXibTxUfBQ67P06CLqWxaBIvoo
         sN0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeDCMDE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 3 Apr 2018 08:03:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:17204
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755300AbeDCMDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Apr 2018 08:03:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,400,1517871600";
   d="scan'208";a="260703314"
Date: Tue, 3 Apr 2018 14:02:46 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Steven Rostedt <rostedt@goodmis.org>
cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        trivial@kernel.org
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
In-Reply-To: <20180403075944.0fd44f82@gandalf.local.home>
Message-ID: <alpine.DEB.2.20.1804031402131.3630@hadrien>
References: <20180329172431.8171-1-colin.king@canonical.com>        <20180329133102.6061ba66@gandalf.local.home>        <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>        <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>       
 <20180329140409.1311baac@gandalf.local.home>        <583c21dd-2ffc-4375-af8a-aa721ffb4594@kernel.org>        <20180403100704.hwdugt2piatcngqw@mwanda> <20180403075944.0fd44f82@gandalf.local.home>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596726428619108367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Tue, 3 Apr 2018, Steven Rostedt wrote:

> On Tue, 3 Apr 2018 13:07:05 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> > On Fri, Mar 30, 2018 at 09:51:21AM -0600, Shuah Khan wrote:
> > > On 03/29/2018 12:04 PM, Steven Rostedt wrote:
> > > > On Thu, 29 Mar 2018 11:54:28 -0600
> > > > Shuah Khan <shuah@kernel.org> wrote:
> > > >
> > > >> I will pick this up with your Ack Steve, unless you want include
> > > >> it in your pull request.
> > > >
> > > > You or Janitors can take it.
> > > >
> > >
> > > Okay we can leave it to the Janitors then.
> > >
> >
> > There isn't a Janitor tree...
> >
>
> But there is a trivial tree. I guess the confusion was that
> kernel-janitors@vger.kernel.org was Cc'd. Where do their work go?

kernel-janitors@vger.kernel.org is just a mailing list that lets people
see what other people are doing.

julia
