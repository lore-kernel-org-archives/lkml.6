Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeAaAgC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:36:02 -0500
Received: from www62.your-server.de ([213.133.104.62]:57316 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeAaAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:36:01 -0500
Subject: Re: general protection fault in ___bpf_prog_run
To: syzbot <syzbot+1eb094057b338eb1fc00@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <001a1145708e44fca00564049e52@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1ef4ac96-f409-5711-e8f7-2e7632ef618b@iogearbox.net>
Date: Wed, 31 Jan 2018 01:35:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <001a1145708e44fca00564049e52@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 09:58 PM, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 868c36dcc949c26bc74fa4661b670d9acc6489e4 (Mon Jan 29 03:00:16 2018 +0000)
> Merge tag 'wireless-drivers-next-for-davem-2018-01-26' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
> 
> So far this crash happened 2 times on bpf-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1eb094057b338eb1fc00@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for details.
> If you forward the report, please keep this part and the footer.

Really great syzkaller report !

Fixed by: http://patchwork.ozlabs.org/patch/867748/
