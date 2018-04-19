Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeDSOwD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:52:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:36516 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeDSOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:52:02 -0400
X-Google-Smtp-Source: AIpwx49QJ+2Dj3DmCExN5soT47SyPC7p25xSO86XV584YXFK/RKyuVyQI/b7n4TwfqOEmo5+OQEOKLpREN03kw/FWSycxaoZwr+f
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 07:52:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d71bf6056a34b628@google.com>
Subject: unregister_netdevice: waiting for DEV to become free
From: syzbot <syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
87ef12027b9b1dd0e0b12cf311fbcb19f9d92539 (Wed Apr 18 19:48:17 2018 +0000)
Merge tag 'ceph-for-4.17-rc2' of git://github.com/ceph/ceph-client
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2dfb68e639f0621b19fb

So far this crash happened 5 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5531107864870912
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2dfb68e639f0621b19fb@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

connbytes_mt_check: 1 callbacks suppressed
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
unregister_netdevice: waiting for lo to become free. Usage count = 3
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
kernel msg: ebtables bug: please report to author: Entries_size never zero
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
nla_parse: 1 callbacks suppressed
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7
netlink: 17 bytes leftover after parsing attributes in process  
`syz-executor6'.
xt_connbytes: cannot load conntrack support for proto=7


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
