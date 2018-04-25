Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754370AbeDYLCp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:02:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63214 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeDYLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:02:41 -0400
Subject: Re: KASAN: null-ptr-deref Read in xattr_getsecurity
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot+9369930ca44f29e60e2d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Cc: ebiederm@xmission.com, serge@hallyn.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org
References: <0000000000008d2e0d05697a693d@google.com>
 <9d192497-8b1e-ca8d-0ed8-b3324ee1e361@I-love.SAKURA.ne.jp>
 <87o9irw2ad.fsf@xmission.com>
 <201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
Message-ID: <334adbb4-bf19-fab6-c426-5f6e2572b4b0@I-love.SAKURA.ne.jp>
Date: Wed, 25 Apr 2018 20:01:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804110600.CCF73450.FFOOQtSFOLHMVJ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Patch was sent to linux.git as 1f5781725dcbb026.

#syz fix: commoncap: Handle memory allocation failure.
