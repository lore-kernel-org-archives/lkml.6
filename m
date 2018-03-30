Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeC3Qy5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:54:57 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:43432 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeC3Qyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:54:54 -0400
X-Google-Smtp-Source: AIpwx4+yv/I9xVw0WFg7VFmodyHOO4Z9p8Yc4VNtNzaxQ/RRhzxI+PhYkiSY/K6p1oGqCTMaGxUpL0Y/UOYUv2p8CJs=
MIME-Version: 1.0
In-Reply-To: <94eb2c05b2d8af3dfa0568a3f964@google.com>
References: <000000000000878b6a05688805c5@google.com> <94eb2c05b2d8af3dfa0568a3f964@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 30 Mar 2018 18:54:33 +0200
Message-ID: <CACT4Y+Yj+yAQ3gAAsJfHt5cHsxtC_opKWa4qJEUF=3bMtEGDCg@mail.gmail.com>
Subject: Re: INFO: task hung in stop_sync_thread (2)
To: syzbot <syzbot+5fe074c01b2032ce9618@syzkaller.appspotmail.com>
Cc: coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, horms@verge.net.au,
        Julian Anastasov <ja@ssi.bg>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>, lvs-devel@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs@googlegroups.com, wensong@linux-vs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 6:46 PM, syzbot
<syzbot+5fe074c01b2032ce9618@syzkaller.appspotmail.com> wrote:
> syzbot has found reproducer for the following crash on net-next commit

/\/\/\/\/\/\

now syzbot can test fixes

> 18845557fd6fc1998f2d0d8c30467f86db587529 (Thu Mar 29 20:24:06 2018 +0000)
> Merge tag 'wireless-drivers-next-for-davem-2018-03-29' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=5fe074c01b2032ce9618
>
> So far this crash happened 2 times on net-next.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5531070485233664
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5632385408303104
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6520566391504896
> Kernel config: https://syzkaller.appspot.com/x/.config?id=-37309782588693906
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5fe074c01b2032ce9618@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
