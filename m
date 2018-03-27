Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeC0NwW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:52:22 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33072 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeC0NwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:52:20 -0400
X-Google-Smtp-Source: AG47ELszXYuUfiXl/eQ8cx76GAX6/5mY5STeEX0UGbYuEu4+sjAZ4h4msoWfoOVoXrv21eLxM8XYNg==
Date: Tue, 27 Mar 2018 06:52:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        guro@fb.com, riel@surriel.com, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHSET] mm, memcontrol: Implement memory.swap.events
Message-ID: <20180327135217.GI1840639@devbig577.frc2.facebook.com>
References: <20180324165127.701194-1-tj@kernel.org>
 <20180326143931.41a15320fd4d4af26c86d42e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326143931.41a15320fd4d4af26c86d42e@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:39:31PM -0700, Andrew Morton wrote:
> On Sat, 24 Mar 2018 09:51:25 -0700 Tejun Heo <tj@kernel.org> wrote:
> 
> > This patchset implements memory.swap.events which contains max and
> > fail events so that userland can monitor and respond to swap running
> > out.  It contains the following two patches.
> > 
> >  0001-mm-memcontrol-Move-swap-charge-handling-into-get_swa.patch
> >  0002-mm-memcontrol-Implement-memory.swap.events.patch
> > 
> > This patchset is on top of the "cgroup/for-4.17: Make cgroup_rstat
> > available to controllers" patchset[1] and "mm, memcontrol: Make
> > cgroup_rstat available to controllers" patchset[2] and also available
> > in the following git branch.
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-memcg-swap.events
> 
> This doesn't appear to be in linux-next yet.  It should be by now if it's
> targeted at 4.17?

You're right.  It's too late for 4.17.  Let's aim for 4.18.

Thanks.

-- 
tejun
