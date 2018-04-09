Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeDINRv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:17:51 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41481 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDINRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:17:37 -0400
X-Google-Smtp-Source: AIpwx4/9g6so3C+tNju9iRGv9TAsiN6/G5pwotmQRADKYAPHWSuDXxQsNoo//VCFYf47cYdLroqADnOvFNDMTvaVdP4=
MIME-Version: 1.0
In-Reply-To: <20180409032835.GB1648@stefanha-x1.localdomain>
References: <001a11449424f11322056932b09c@google.com> <CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
 <20180409054316-mutt-send-email-mst@kernel.org> <20180409032835.GB1648@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 9 Apr 2018 21:17:35 +0800
Message-ID: <CAJSP0QUgySKEk79EzFSQAdTfbmFRE+CdJPkLdV5+6MoX6tf3eg@mail.gmail.com>
Subject: Re: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 11:28 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Apr 09, 2018 at 05:44:36AM +0300, Michael S. Tsirkin wrote:
>> On Mon, Apr 09, 2018 at 10:37:45AM +0800, Stefan Hajnoczi wrote:
>> > On Sat, Apr 7, 2018 at 3:02 AM, syzbot
>> > <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com> wrote:
>> > > syzbot hit the following crash on upstream commit
>> > > 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
>> > > Merge tag 'armsoc-drivers' of
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> > > syzbot dashboard link:
>> > > https://syzkaller.appspot.com/bug?extid=65a84dde0214b0387ccd
>> >
>> > To prevent duplicated work: I am working on this one.
>> >
>> > Stefan
>>
>> Do you want to try this patchset:
>> https://lkml.org/lkml/2018/4/5/665
>>
>> ?
>
> Thanks, I'll give it a shot.
>
> I also noticed a regression in commit
> d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log when
> IOTLB is enabled") and am currently testing a fix.

I have sent a fix:
https://lkml.org/lkml/2018/4/9/390

Stefan
