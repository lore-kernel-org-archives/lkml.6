Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755782AbeDTPYf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755566AbeDTPYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:24:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7476720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 11:24:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Song Liu <songliubraving@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
Message-ID: <20180420112431.42762006@gandalf.local.home>
In-Reply-To: <CAJfpegsjgK3-q00qX2A9eopDydKXxSBMwprL8XZH5w=g2BvBZQ@mail.gmail.com>
References: <20180418174014.1592871-1-songliubraving@fb.com>
        <CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com>
        <CAELBmZBvt=9p8muDsRucR_06kmia9vKT6CMfZbHjQL97N4aFag@mail.gmail.com>
        <F7C1033B-A155-4DA9-A686-AD39BA4CCC03@fb.com>
        <CAJfpegsjgK3-q00qX2A9eopDydKXxSBMwprL8XZH5w=g2BvBZQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 16:34:25 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> This corner case is simply not interesting (modifying a binary while
> it is being debugged with uprobe).  Let's just concentrate on making
> this crash and leak free.

Yes please. I'm waiting for a final patch to run my tests. I have other
patches that need to go mainline as well, and I'll start testing all of
them when I get the final version of this one.

-- Steve
