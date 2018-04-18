Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDRQZl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeDRQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:25:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A564A2077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 12:25:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <songliubraving@fb.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tracing: fix bad use of igrab in trace_uprobe.c
Message-ID: <20180418122536.32e62b5e@gandalf.local.home>
In-Reply-To: <6E88C284-7EEB-43EF-8C54-3DCB5F13124B@fb.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
        <CAELBmZCvrL4s+cx2cECMQLQUx0hMxVP-dv9UGBfh64AS6unaBA@mail.gmail.com>
        <6E88C284-7EEB-43EF-8C54-3DCB5F13124B@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 16:08:50 +0000
Song Liu <songliubraving@fb.com> wrote:

> > This is not against -linus tree.  
> 
> These patches are against tip/perf/core. I can also send version against 
> -linus tree. 

I can take this patch in my tree (which is currently equal to
4.17-rc1). The other patch should go through tip.

-- Steve
