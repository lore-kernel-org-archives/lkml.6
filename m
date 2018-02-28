Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeB1BQA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:16:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:48135 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeB1BP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:15:59 -0500
Date: Wed, 28 Feb 2018 01:15:57 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] fs/sysctl: remove redundant link check in
 proc_sys_link_fill_cache()
Message-ID: <20180228011557.GC14069@wotan.suse.de>
References: <20180227233156.29826-1-danilokrummrich@dk-develop.de>
 <20180227233156.29826-2-danilokrummrich@dk-develop.de>
 <CAGXu5jLs2Fu+0yUNE4v6+xkfLXdEBs2QY=HctVFGfd__vNPW1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLs2Fu+0yUNE4v6+xkfLXdEBs2QY=HctVFGfd__vNPW1g@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:41:40PM -0800, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 3:31 PM, Danilo Krummrich
> <danilokrummrich@dk-develop.de> wrote:
> > proc_sys_link_fill_cache() does not need to check whether we're
> > called for a link - it's already done by scan().
> >
> > Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> > ---
> > v2: removed 'err' as it's only used for sysctl_follow_link()
> 
> Thanks :)
> 
> Luis, do you have a tree for sysctl, or should these just go via -mm?

-mm has been working beautifully so far.

Now that acks have been collected, Danilo, can you also add the other tags
mentioned and resubmit and add akpm@linux-foundation.org ?

  Luis
