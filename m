Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756217AbeDXGED (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:04:03 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:38737 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755919AbeDXGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:04:02 -0400
X-Google-Smtp-Source: AB8JxZpjuqIwyHW7bcR3UvYhPtrZinrFYLyJfXOJw9d4Y0/fl3FnwyimNu9L4yoM3TemvQHmFaAWScZa5JrjALxYiKDvzNxtCEfC
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 23:04:01 -0700
In-Reply-To: <20180424060137.GA57142@jaegeuk-macbookpro.roam.corp.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bec77e056a91eb55@google.com>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
From: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

patch is already applied


Tested on  
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev-test  
commit
65b966f58e8264477da6c8b70703ce362cb1f8f0 (Tue Apr 24 05:02:31 2018 +0000)
f2fs: give message and set need_fsck given broken node id

compiler: gcc (GCC) 8.0.1 20180413 (experimental)
Patch: https://syzkaller.appspot.com/x/patch.diff?id=5525459446005760
