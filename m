Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeENH0L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:26:11 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44790 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbeENH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:26:08 -0400
X-Google-Smtp-Source: AB8JxZokMIyNXylofZztpoM/1UrYqClcffi1RzkMomHXe15XxA1ZI3R0m/RQgWqc8VOSNOV3WSd6syU7pKMlHPm86S4=
MIME-Version: 1.0
In-Reply-To: <20180514172042.093bd880@canb.auug.org.au>
References: <20180514172042.093bd880@canb.auug.org.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 10:26:07 +0300
Message-ID: <CAHp75Vfs_Za5d8YLJ5FNJDmytRJE-P+q_Kds9V+ivBGy3v+p8g@mail.gmail.com>
Subject: Re: linux-next: Tree for May 14
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:20 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Changes since 20180511:
>
> New trees: btrfs-fixes
>         vfs-fixes
>         dma-mapping-fixes
>
> The f2fs tree gained a conflict against the vfs-fixes tree.
>
> The bpf-next tree gained a conflict against the bpf tree.
>
> The rcu tree gained a conflict against Linus' tree.
>
> The kselftest tree gained a conflict against the kvm-fixes tree.
>
> Non-merge commits (relative to Linus' tree): 5724
>  5580 files changed, 217262 insertions(+), 101414 deletions(-)
>
> ----------------------------------------------------------------------------
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.

Hmm... It seems my message was buried in the pile of the thread WRT
fixes branches.

Please, add our PDx86 fixes branch as well:
git://git.infradead.org/linux-platform-drivers-x86.git fixes

-- 
With Best Regards,
Andy Shevchenko
