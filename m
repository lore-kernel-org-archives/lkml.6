Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeDTS3v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:29:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeDTS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:29:50 -0400
Date: Fri, 20 Apr 2018 11:29:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs fixes
Message-Id: <20180420112945.98686d9c78121bdc1e93483a@linux-foundation.org>
In-Reply-To: <20180420155846.GO30522@ZenIV.linux.org.uk>
References: <20180420155846.GO30522@ZenIV.linux.org.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 16:58:46 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:

> 	Assorted fixes.  Some of that is only a matter with fault injection
> (broken handling of small allocation failure in various mount-related places),
> but the last one is a root-triggerable stack overflow, and combined with
> userns it gets really nasty ;-/
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-linus
> 
> for you to fetch changes up to 16a34adb9392b2fe4195267475ab5b472e55292c:
> 
>   Don't leak MNT_INTERNAL away from internal mounts (2018-04-19 23:52:15 -0400)
> ...
>
> Tetsuo Handa (1):
>       mm,vmscan: Allow preallocating memory for register_shrinker().

Confused.  You had a bunch of issues with this patch
(http://lkml.kernel.org/r/20180411005938.GN30522@ZenIV.linux.org.uk)
and Tetsuo sent out a v2 but now we've merged the v1.  Deliberate?

Also, it would be nice if you could get the Link: thing working in your
commits please - this one took a bit of hunting down.
