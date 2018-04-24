Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756490AbeDXGmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:42:47 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:33938 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756025AbeDXGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:42:02 -0400
X-Google-Smtp-Source: AIpwx4+PpKI4xLWZdnqCEZbMDGeBR14iUTIqyDSCVzILvFGZ7AidjoNZgja6BMa4hhuSEYn7co+3WGtBvBgnwbQZN/faOVUS0E5h
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 23:42:02 -0700
In-Reply-To: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae37a6056a9273f6@google.com>
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

failed to create VM pool: failed to create GCE image: failed to get create  
image operation operation-1524552040215-56a926ecc71d9-3edfeb8b-8abca81c:  
googleapi: Error 403: Rate Limit Exceeded, rateLimitExceeded


Tested on  
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev commit
b549e322861b99f1862fb5f08dfb5e5753a38635 (Sat Apr 21 06:44:59 2018 +0000)
f2fs: check cap_resource only for data blocks

compiler: gcc (GCC) 8.0.1 20180413 (experimental)
Patch: https://syzkaller.appspot.com/x/patch.diff?id=5565179303559168
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
