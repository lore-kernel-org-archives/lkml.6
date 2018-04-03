Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDCOUe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:20:34 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:39116 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeDCOUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:20:32 -0400
X-Google-Smtp-Source: AIpwx4/e7dLdIvRZmMs3CfBbqk+0iGAwCqJo2SSBGJd418tzsU00qCCyiVOJLoFq/Z+XlEyyjCMYzA==
Date: Tue, 3 Apr 2018 07:20:29 -0700
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yufen Yu <yuyufen@huawei.com>, David Sterba <dsterba@suse.cz>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180403142029.GM388343@devbig577.frc2.facebook.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
 <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180201092551.759f32be@canb.auug.org.au>
 <20180314101704.51aaae7f@canb.auug.org.au>
 <20180403122919.3c503f74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403122919.3c503f74@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Stephen.

On Tue, Apr 03, 2018 at 12:29:19PM +1000, Stephen Rothwell wrote:
> > I am still applying this to the merge of the btrfs tree every day ...
> > 
> > Commit
> >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > was merged into Linus' tree on Jan 31.
> > 
> > Here is the actual merge fix patch:

Yeah, the merge fix looks correct to me.  Depending on the merge
order, it can go either after the btrfs merge or the f2fs merge, I
guess.  Stephen, beyond appyling the merge fix afterwards, is there
somethine else you are concerned about?

Thanks.

-- 
tejun
