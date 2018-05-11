Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeEKVW7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:22:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:22:58 -0400
Date: Fri, 11 May 2018 14:22:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Larry Chen <lchen@suse.com>
Cc: mfasheh@versity.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH] ocfs2: ocfs2_inode_lock_tracker does not distinguish
 lock level
Message-Id: <20180511142256.ecabae077ddd5fb18df29959@linux-foundation.org>
In-Reply-To: <88053e38-350e-34a4-b3d8-431297dc1f90@suse.com>
References: <20180510053230.17217-1-lchen@suse.com>
        <20180510144944.d0842b82b99a471dbbc745ad@linux-foundation.org>
        <88053e38-350e-34a4-b3d8-431297dc1f90@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 12:16:51 +0800 Larry Chen <lchen@suse.com> wrote:

> > Nice changelog, but it gives no information about the severity of the
> > bug: how often does it hit and what is the end-user impact.
> >
> > This info is needed so that I and others can decide which kernel
> > version(s) need the patch, so please always include it when fixing a
> > bug, thanks.
> 
> Thanks for your review and feel sorry for not providing enough information.
> 
> For the status quo of ocfs2, without this patch, neither a bug nor end-user
> impact will be caused because the wrong logic is avoided.
> 
> But I'm afraid this generic interface, may be called by other
> developers in future and used in this situation.
> 
>      a process
> ocfs2_inode_lock_tracker(ex=0)
> ocfs2_inode_lock_tracker(ex=1)

OK, thanks.

> By the way, should I resend this patch with this info included?

I pasted the above into my copy of the changelog so we're good.
