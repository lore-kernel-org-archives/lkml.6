Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935398AbeE2Ome (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:42:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36313 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935324AbeE2Om1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:42:27 -0400
X-Google-Smtp-Source: ADUXVKJOFdVJcs5zvZoqyeRgTSeL6xC9ABAb/iPPsPRZf8HyHVjRAGznZ9q7DuVIU82q6VZZ3/lhuQ==
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len in
 tcp_probe
To: Yafang Shao <laoar.shao@gmail.com>, David Miller <davem@davemloft.net>
Cc: Song Liu <songliubraving@fb.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
 <20180529.101553.694799514284747444.davem@davemloft.net>
 <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <98df6d86-f237-b2d4-9f85-ce6d11c1ac4f@gmail.com>
Date: Tue, 29 May 2018 07:42:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 07:36 AM, Yafang Shao wrote:
> On Tue, May 29, 2018 at 10:15 PM, David Miller <davem@davemloft.net> wrote:
>> From: Yafang Shao <laoar.shao@gmail.com>
>> Date: Fri, 25 May 2018 18:14:05 +0800
>>
>>> skb->len is meaningless to user.
>>> data length could be more helpful, with which we can easily filter out
>>> the packet without payload.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>
>> Applied, thank you.
> 
> Hi Dave,
> 
> There's an update on this patch.
> Pls.  see V4.
> 
> And I will send a V5 patch per Eric's suggestion.

Ah, if it is merged it might be too late.

No big deal.
