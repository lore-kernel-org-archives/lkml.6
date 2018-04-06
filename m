Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeDFIJ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeDFIJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:09:24 -0400
Date: Fri, 6 Apr 2018 10:09:22 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: viro@zeniv.linux.org.uk,
        syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in kill_block_super
Message-ID: <20180406080922.GH8286@dhcp22.suse.cz>
References: <001a114043bcfab6ab05689518f9@google.com>
 <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-04-18 19:53:07, Tetsuo Handa wrote:
> Al and Michal, are you OK with this patch?

Maybe I've misunderstood, but hasn't Al explained [1] that the
appropriate fix is in the fs code?

[1] http://lkml.kernel.org/r/20180402143415.GC30522@ZenIV.linux.org.uk
-- 
Michal Hocko
SUSE Labs
