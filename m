Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965763AbeBMUMi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:12:38 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:36625 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965608AbeBMUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:12:36 -0500
X-Google-Smtp-Source: AH8x2268q7DWrqwKL/AjwWyVySPPd1goDHPaBkmBimvdtH6sCvRg8liGgMpfDPzs0o3Yc+epECqGYMl9jhP981RLukw=
MIME-Version: 1.0
In-Reply-To: <d91da249-5a0f-7a1f-cfd5-68f10f0a2fc1@oracle.com>
References: <089e08231920353a4805618b365c@google.com> <d91da249-5a0f-7a1f-cfd5-68f10f0a2fc1@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 13 Feb 2018 21:12:15 +0100
Message-ID: <CACT4Y+bd6Tyq672JC3GNSHPX2CEHacVKkcbKOAgpi8o-=T8DRg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rds_find_bound
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: syzbot <syzbot+93a5839deb355537440f@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2017 at 8:41 PM, santosh.shilimkar@oracle.com
<santosh.shilimkar@oracle.com> wrote:
> On 12/30/17 1:17 AM, syzbot wrote:
>>
>> Hello,
>>
>> syzkaller hit the following crash on
>> fba961ab29e5ffb055592442808bb0f7962e05da
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>> Unfortunately, I don't have any reproducer for this bug yet.
>>
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+93a5839deb355537440f@syzkaller.appspotmail.com
>
>
> Posted a fix[1] for above issue. Didn't test it but looks straight
> forward.


Hi Santosh,

What is that fix? You forgot to provide any link/reference. I also
don't see any patches from you at around that date...
