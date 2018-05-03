Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECJvj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:51:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48569 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECJvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:51:38 -0400
Date: Thu, 3 May 2018 11:49:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180503094900.GA21272@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, Tejun Heo <tj@kernel.org>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
 <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180201092551.759f32be@canb.auug.org.au>
 <20180314101704.51aaae7f@canb.auug.org.au>
 <20180403122919.3c503f74@canb.auug.org.au>
 <20180503084259.4a3b68d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503084259.4a3b68d6@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:42:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 3 Apr 2018 12:29:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Ping?
> 
> Ping again ...
> 
> So has Chris gone missing?  Or should I just remove the btrfs tree from linux-next?

As far as btrfs code changes are concerned, they go through my tree. The
other conflicting changes are some cgroup tweaks that have impact on
btrfs but do not affect the development.
