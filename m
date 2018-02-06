Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeBFTXQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:23:16 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38971 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeBFTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:23:14 -0500
X-Google-Smtp-Source: AH8x227BGzabwHIe+t+Wxmm19BmrZZC8aygt38bpZfFsVBm6TH7tLTDJ5Bgd/XlQTPEShkT5sAEWSEYJ7EHYKS/7220=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZybLXnPiQ8BDLORD6VA8E7KeMrJZxO8q46MfMKyH7q_Q@mail.gmail.com>
References: <94eb2c0efc1ede1c4205648e8a49@google.com> <CACT4Y+ZybLXnPiQ8BDLORD6VA8E7KeMrJZxO8q46MfMKyH7q_Q@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Feb 2018 06:16:51 +1100
X-Google-Sender-Auth: ow_GsKUTPxv9tpigCv64-7wJUJY
Message-ID: <CAGXu5j+n8XCAwsRzDRoaxRqDEH9byMB=6e5FxPW=1mrGoUzRRQ@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in put_cmsg
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+c4dcac91687a29cbae15@syzkaller.appspotmail.com>,
        keun-o.park@darkmatter.ae, Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 4:33 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Feb 6, 2018 at 6:31 PM, syzbot
> <syzbot+c4dcac91687a29cbae15@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> e237f98a9c134c3d600353f21e07db915516875b (Mon Feb 5 21:35:56 2018 +0000)
>> Merge tag 'xfs-4.16-merge-5' of
>> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>>
>> So far this crash happened 8 times on net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>
> #syz dup: WARNING in usercopy_warn
>
> Let's make that one the main copy, since Kees is already looking at it.

This one has a more descriptive subject, can we dup towards this one?
Whatever the case, yup, still working on it.

-Kees

-- 
Kees Cook
Pixel Security
