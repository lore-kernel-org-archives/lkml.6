Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeCIXVs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:21:48 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44978 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932358AbeCIXVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:21:46 -0500
X-Google-Smtp-Source: AG47ELsX7olJbPtc2NzPuwO8fZJbH55uRhTal0uH3d/U3ams+/7tpsmOXKG4qdRZRnTiidAK/pYxuQ==
Subject: Re: WARNING in __proc_create
To: Cong Wang <xiyou.wangcong@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <001a113f2be668a1e9056701e617@google.com>
 <CAM_iQpV+PnGUXEKcSrF7u19NOeLLp0PhDW-DOkEfS+8pLnTgYw@mail.gmail.com>
 <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
 <c4b2dca8-f2b9-c187-9ee5-e7c4816848f5@gmail.com>
 <CAM_iQpXLQtaBRBPmcGzUTUhNHiomos4eAvXy7kyrY+uAzpNt3g@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5d89ba78-64b4-9c9b-c9f3-c67094343c3f@gmail.com>
Date: Fri, 9 Mar 2018 15:21:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXLQtaBRBPmcGzUTUhNHiomos4eAvXy7kyrY+uAzpNt3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 03:05 PM, Cong Wang wrote:
> 
> BTW, the warning itself is all about empty names, so perhaps
> it's better to fix them separately.

Huh ? You want more syzbot reports ? I do not.

I unblocked this report today [1], you can be sure that as soon
as syzbot gets the correct tag (Reported-by: ...), it will find the 
other problems, which are currently on hold to avoid spam.

[1] It has been sitting for a while here at Google, since January 28th.
    At some point you have to ping Pablo/Florian again ;)
