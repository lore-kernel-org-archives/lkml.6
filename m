Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeDICok (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:44:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755583AbeDICoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:44:38 -0400
Date: Mon, 9 Apr 2018 05:44:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
Message-ID: <20180409054316-mutt-send-email-mst@kernel.org>
References: <001a11449424f11322056932b09c@google.com>
 <CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 10:37:45AM +0800, Stefan Hajnoczi wrote:
> On Sat, Apr 7, 2018 at 3:02 AM, syzbot
> <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com> wrote:
> > syzbot hit the following crash on upstream commit
> > 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
> > Merge tag 'armsoc-drivers' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=65a84dde0214b0387ccd
> 
> To prevent duplicated work: I am working on this one.
> 
> Stefan

Do you want to try this patchset:
https://lkml.org/lkml/2018/4/5/665

?

-- 
MST
