Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936734AbeE2O5n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:57:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36258 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935746AbeE2O5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:57:13 -0400
X-Google-Smtp-Source: ADUXVKJeaeWFmSdxFGfRqOCiGAHTCDyZdO5nTU4X9MVhjKaLxixUMx+Gx5ze1JvMoPDCbX9GtsqAKS+Wr6yIQp6oZNA=
MIME-Version: 1.0
In-Reply-To: <20180529.105455.676464019941488974.davem@davemloft.net>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
 <20180529.101553.694799514284747444.davem@davemloft.net> <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
 <20180529.105455.676464019941488974.davem@davemloft.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 22:56:32 +0800
Message-ID: <CALOAHbChjp=drVw7XGSptRpJHVrtAYqTe3AXbQ+cMChiWo6Rhw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len in tcp_probe
To: David Miller <davem@davemloft.net>
Cc: Song Liu <songliubraving@fb.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:54 PM, David Miller <davem@davemloft.net> wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> Date: Tue, 29 May 2018 22:36:50 +0800
>
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
> Sorry, I pushed it out already.  You'll need to send me relative changes.

OK
