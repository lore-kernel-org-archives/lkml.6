Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeDNPd2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 11:33:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18845 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeDNPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 11:33:27 -0400
Subject: Re: WARNING: lock held when returning to user space!
To: Jens Axboe <axboe@kernel.dk>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Omar Sandoval <osandov@osandov.com>
References: <00000000000082922905692da9e1@google.com>
 <0e998b77-14f0-aee0-8d32-bc1dd96fcc4c@kernel.dk>
 <CACT4Y+Y0TVJLDA5-0RGq-a-A6KKLKHZtA4pwUH2rtvR0hkiZQQ@mail.gmail.com>
 <63121c85-f417-cde8-510d-f275dbe81c4d@kernel.dk>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7e5ab719-ad6b-015f-2e4c-8cba2ee157f8@I-love.SAKURA.ne.jp>
Date: Sun, 15 Apr 2018 00:33:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <63121c85-f417-cde8-510d-f275dbe81c4d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was sent to linux.git as commit bdac616db9bbadb9.

#syz fix: loop: fix LOOP_GET_STATUS lock imbalance
