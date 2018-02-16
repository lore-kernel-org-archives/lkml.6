Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162142AbeBPRgc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbeBPRgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:36:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ADF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 12:36:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: changbin.du@intel.com, mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to
 rst format
Message-ID: <20180216123629.5ac2b373@gandalf.local.home>
In-Reply-To: <20180216054952.78718f09@lwn.net>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
        <1518750739-12514-3-git-send-email-changbin.du@intel.com>
        <20180215225705.58984492@vmware.local.home>
        <20180216054952.78718f09@lwn.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 05:49:52 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> On Thu, 15 Feb 2018 22:57:05 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This document is out of date, and I rather have it updated before we
> > make it more "available" elsewhere.  
> 
> Imagine that, an out-of-date doc in the kernel :)
> 
> Seriously, though, I'd argue that (1) it's already highly available, and
> (2) it's useful now.  And (3) who knows when that update will happen?
> Unless we have reason to believe that a new version is waiting on the
> wings, I don't really see why we would want to delay this work.

Actually, some of these documents I was thinking of labeling as
"obsolete" or simply removing them. The ftrace-design one is about
how to port ftrace to other architectures, and I already had to correct
people that based their work on it.

Yeah, I really need to get some time to update them, but like everyone
else, that's just the 90th thing I have to do.

-- Steve
