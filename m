Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbeEAQRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:17:42 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37760 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeEAQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:17:41 -0400
X-Google-Smtp-Source: AB8JxZpfQ2YjA6wBlZmLHjO78r/esKsoX2iUU8VJTff+i2qQ2d1dZwTQCrQvd0bqrFCr7RFx3pJ2Kg==
Subject: Re: INFO: task hung in wb_shutdown (2)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
Cc: syzbot <syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com>,
        christophe.jaillet@wanadoo.fr, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        weiping zhang <zhangweiping@didichuxing.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org
References: <94eb2c05b2d83650030568cc8bd9@google.com>
 <e56c1600-8923-dd6b-d065-c2fd2a720404@I-love.SAKURA.ne.jp>
 <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <16c2860a-05db-9534-5960-e26c9ba9214c@kernel.dk>
Date: Tue, 1 May 2018 10:12:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/18 4:27 AM, Tetsuo Handa wrote:
> Tejun, Jan, Jens,
> 
> Can you review this patch? syzbot has hit this bug for nearly 4000 times but
> is still unable to find a reproducer. Therefore, the only way to test would be
> to apply this patch upstream and test whether the problem is solved.

I'll review it today.

-- 
Jens Axboe
