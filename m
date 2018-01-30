Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeA3Vbh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:31:37 -0500
Received: from www62.your-server.de ([213.133.104.62]:34744 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeA3Vbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:31:35 -0500
Subject: Re: general protection fault in ___bpf_prog_run
To: syzbot <syzbot+1eb094057b338eb1fc00@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <001a1145708e44fca00564049e52@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <95e128c8-7f26-91a7-9cda-90a15dc31db1@iogearbox.net>
Date: Tue, 30 Jan 2018 22:31:29 +0100
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

Thanks for the report, looking into it right now.
