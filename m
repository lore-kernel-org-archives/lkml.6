Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeBTAmI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 19:42:08 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:44047 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBTAmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 19:42:07 -0500
X-Google-Smtp-Source: AH8x225Yd/cWpdJ5TmnKsWO8kq4uAftn5ZgFkXgLDgbqggjelIgO8zfUmckkOIWr0O1elKiNV459BgtzY8CbDij/Kp4=
MIME-Version: 1.0
In-Reply-To: <878tbov9i6.fsf@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
 <20180216150933.971-5-john.ogness@linutronix.de> <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
 <87y3js36s7.fsf@linutronix.de> <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
 <87r2pk358g.fsf@linutronix.de> <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
 <87lgfs3374.fsf@linutronix.de> <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
 <878tbov9i6.fsf@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Feb 2018 16:42:05 -0800
X-Google-Sender-Auth: a5D6Aza0Wu1Y874ztWxSsTroqPI
Message-ID: <CA+55aFz0nPOiwHysfBW+YkzNE770s9V0u9DxbCvxjW-ER574=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 3:34 PM, John Ogness <john.ogness@linutronix.de> wrote:
>
> IMHO the original v1 patchset is the simplest codewise. And if the
> comments were updated to not mislead, it is the way I would want to go.

Ok, looking at your alternatives, I am inclined to agree.

           Linus
