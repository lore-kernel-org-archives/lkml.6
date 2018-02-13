Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbeBMR7l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:59:41 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40655 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965168AbeBMR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:59:39 -0500
X-Google-Smtp-Source: AH8x224ZYyXhG+c6+RJMLT9Yvd18KIjPAJ1Abdoc5fFp41U8q0crdapgODW8oPnlV0ov9hNMPjKmdzAhTb7z62zN6rw=
MIME-Version: 1.0
In-Reply-To: <20180213171742.ssblqj37l5daxc4s@gmail.com>
References: <tip-b4b56015ed1c98cbc9469e35ebbc4373a2844030@git.kernel.org>
 <20180213065155.GA14087@outlook.office365.com> <20180213080816.vwh64jiz23frjiot@node.shutemov.name>
 <20180213084121.GA19906@outlook.office365.com> <20180213090249.vnjwitt657jabnlt@node.shutemov.name>
 <20180213165337.GA20735@outlook.office365.com> <20180213171742.ssblqj37l5daxc4s@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 13 Feb 2018 17:59:18 +0000
Message-ID: <CAJwJo6YrYps2mOwEQxvwR4pxiSKrb4U_F4qdzKxwN-EOf9WKRw@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Handle 5-level paging boot
 if kernel is above 4G
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrei Vagin <avagin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        tip-bot for Jacob Shin <tipbot@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, willy@infradead.org,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 17:17 GMT+00:00 Ingo Molnar <mingo@kernel.org>:
>
> * Andrei Vagin <avagin@virtuozzo.com> wrote:
>
>> On Tue, Feb 13, 2018 at 12:02:49PM +0300, Kirill A. Shutemov wrote:
>> > On Tue, Feb 13, 2018 at 12:41:22AM -0800, Andrei Vagin wrote:
>> > > On Tue, Feb 13, 2018 at 11:08:16AM +0300, Kirill A. Shutemov wrote:
>> > > > On Mon, Feb 12, 2018 at 10:51:56PM -0800, Andrei Vagin wrote:
>> > > > > Hi Kirill,
>> > > > >
>> > > > > Something is wrong in this patch.
>> >
>> > Could you please check if this makes a difference?
>>
>> The kernel booted with this patch. Thanks!
>> https://travis-ci.org/avagin/linux/jobs/341030882
>
> Fantastic, thanks for the help!
>
> I've amended the commit to keep the series bisectable, and added these two tags:
>
>  Debugged-by: "Kirill A. Shutemov" <kirill@shutemov.name>
>  Tested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
>
> To credit your debugging/testing help.

I believe you wanted
Reported-by: Andrei Vagin <avagin@virtuozzo.com>
Tested-by: Andrei Vagin <avagin@virtuozzo.com>

Or `Reported-and-Tested-by'.

Thanks,
             Dmitry
