Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935271AbeE2OsX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:48:23 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35941 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936712AbeE2Oqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:50 -0400
X-Google-Smtp-Source: AB8JxZo8EZ5AsOAR/qgHhYhytXCN+g45Zw2sGiW5JKC3BdxiRk+eGCb8//+240kdUt6/fSc/qlcVRs19yqBBt05mfNw=
MIME-Version: 1.0
In-Reply-To: <98df6d86-f237-b2d4-9f85-ce6d11c1ac4f@gmail.com>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
 <20180529.101553.694799514284747444.davem@davemloft.net> <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
 <98df6d86-f237-b2d4-9f85-ce6d11c1ac4f@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 22:46:09 +0800
Message-ID: <CALOAHbCHRCrxEFGQHhuc51_9DYPbxjWO=dJN75eoh-WC=dGXng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len in tcp_probe
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>, Song Liu <songliubraving@fb.com>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:42 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/29/2018 07:36 AM, Yafang Shao wrote:
>> On Tue, May 29, 2018 at 10:15 PM, David Miller <davem@davemloft.net> wrote:
>>> From: Yafang Shao <laoar.shao@gmail.com>
>>> Date: Fri, 25 May 2018 18:14:05 +0800
>>>
>>>> skb->len is meaningless to user.
>>>> data length could be more helpful, with which we can easily filter out
>>>> the packet without payload.
>>>>
>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>
>>> Applied, thank you.
>>
>> Hi Dave,
>>
>> There's an update on this patch.
>> Pls.  see V4.
>>
>> And I will send a V5 patch per Eric's suggestion.
>
> Ah, if it is merged it might be too late.
>
> No big deal.
>

Since V3, it is changed to two patches. My bad.
Only the original single patch was merged this time.

Will change it based on the new tree.

Thanks
Yafang
