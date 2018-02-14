Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967697AbeBNMgv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:36:51 -0500
Received: from www62.your-server.de ([213.133.104.62]:57352 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967541AbeBNMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:36:50 -0500
Subject: Re: WARNING: kmalloc bug in bpf_prog_array_copy_info
To: syzbot <syzbot+cab5816b0edbabf598b3@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <001a11452e225976de056520c7b3@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1171a3b4-67b2-dc8b-af87-d9378d42ab4c@iogearbox.net>
Date: Wed, 14 Feb 2018 13:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <001a11452e225976de056520c7b3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 12:59 AM, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on bpf-next commit
> 7928b2cbe55b2a410a0f5c1f154610059c57b1b2 (Sun Feb 11 23:04:29 2018 +0000)
> Linux 4.16-rc1
> 
> So far this crash happened 362 times on bpf-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.

Will send a fix for this in a bit.
