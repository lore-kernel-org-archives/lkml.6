Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeDYLF6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:05:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57501 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeDYLFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:05:54 -0400
Subject: Re: INFO: rcu detected stall in d_walk
To: syzbot <syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000237cc60569ad11c7@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <46b9489e-6986-d512-1276-9da14c96999e@I-love.SAKURA.ne.jp>
Date: Wed, 25 Apr 2018 20:05:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000237cc60569ad11c7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Patch is in vfs.git#for-next as 4fb48871409e2fcd.

#syz fix: restore cond_resched() in shrink_dcache_parent()
