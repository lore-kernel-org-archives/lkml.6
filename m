Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759529AbeD1Chc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:37:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15959 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1Cha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:37:30 -0400
Subject: Re: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
To: syzbot <syzbot+e1670f554caa60fb147b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <0000000000008bce26056a7a6c23@google.com>
 <CAKdAkRRyRPEnghR6YqE++-H=HJbFL0ejK73Z_vMp_TMyNTT4ew@mail.gmail.com>
 <20180424125541.GB4189@thunk.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ac8e7097-eb86-b938-6f18-769d05d46d3c@I-love.SAKURA.ne.jp>
Date: Sat, 28 Apr 2018 11:37:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424125541.GB4189@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Patch was sent to linux.git as 6c1e851c4edc13a4.

#syz fix: random: fix possible sleeping allocation from irq context
