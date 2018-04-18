Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeDRN4S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbeDRN4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:56:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08D421726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 09:56:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Howard McLauchlan <hmclauchlan@fb.com>
Subject: Re: [RFC PATCH 31/35] Revert "vfs: add d_real_inode() helper"
Message-ID: <20180418095607.7acfc1bb@gandalf.local.home>
In-Reply-To: <CAJfpeguJN0+m9Vhtv0fo79xq-P1UzWki9GqQq9WyJRMEwiJBqQ@mail.gmail.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
        <20180412150826.20988-32-mszeredi@redhat.com>
        <CAOQ4uxgdWCWvwWgjUu06H=BeMxh-BVAjxVE5Ckj-poKRGgwvMQ@mail.gmail.com>
        <CAJfpegtLdmnxieDx7+FBUoc-fKsTEwA+oHinhAfa4E9SDFfSNw@mail.gmail.com>
        <20180418093845.19ca33f3@gandalf.local.home>
        <CAJfpeguJN0+m9Vhtv0fo79xq-P1UzWki9GqQq9WyJRMEwiJBqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 15:49:02 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:


> > I just received this patch:
> >
> >  http://lkml.kernel.org/r/20180418062907.3210386-1-songliubraving@fb.com
> >
> > Which removes this code. Can you review it and I'll take it.  
> 
> It shouldn't remove d_real_inode(), because that part is correct and
> fixes a real bug in handling overlayfs files.
> 
> I'll review, but apparently I wasn't CC-d on that patch.   Weird.

Especially since you are on the "Reported-by".

My scripts know to add to the Cc "Reported-by" tags. Not all scripts do
though :-/

-- Steve
