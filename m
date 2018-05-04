Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEDRT3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:19:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:15943 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeEDRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:19:28 -0400
Subject: Re: KASAN: use-after-free Read in fuse_kill_sb_anon
To: syzbot <syzbot+4bb3ee1dd0bd632f21d7@syzkaller.appspotmail.com>,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
References: <0000000000004e82ff056b639fde@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <390b18a0-0a1f-7821-4db4-e8695fc147fc@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 02:19:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000004e82ff056b639fde@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos, please respond to a patch at
http://lkml.kernel.org/r/37d2030a-124c-9927-aa48-bb769da792cf@I-love.SAKURA.ne.jp .

#syz dup: KASAN: use-after-free Read in fuse_kill_sb_blk
