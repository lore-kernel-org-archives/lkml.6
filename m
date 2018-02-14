Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030928AbeBNOkK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:40:10 -0500
Received: from www62.your-server.de ([213.133.104.62]:49483 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030907AbeBNOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:40:08 -0500
Subject: Re: WARNING: kmalloc bug in bpf_prog_array_copy_info
From: Daniel Borkmann <daniel@iogearbox.net>
To: syzbot <syzbot+cab5816b0edbabf598b3@syzkaller.appspotmail.com>,
        ast@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <001a11452e225976de056520c7b3@google.com>
 <1171a3b4-67b2-dc8b-af87-d9378d42ab4c@iogearbox.net>
Message-ID: <146902fb-3f03-b8dd-1c3c-88fcdeb6e2af@iogearbox.net>
Date: Wed, 14 Feb 2018 15:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1171a3b4-67b2-dc8b-af87-d9378d42ab4c@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 01:36 PM, Daniel Borkmann wrote:
> On 02/14/2018 12:59 AM, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on bpf-next commit
>> 7928b2cbe55b2a410a0f5c1f154610059c57b1b2 (Sun Feb 11 23:04:29 2018 +0000)
>> Linux 4.16-rc1
>>
>> So far this crash happened 362 times on bpf-next.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
> 
> Will send a fix for this in a bit.

(http://patchwork.ozlabs.org/patch/873373/)

#syz fix: bpf: fix bpf_prog_array_copy_to_user warning from perf event prog query
