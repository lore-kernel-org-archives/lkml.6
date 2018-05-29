Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964993AbeE2OzF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:55:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56258 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936597AbeE2Oy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:54:59 -0400
Date: Tue, 29 May 2018 10:54:55 -0400 (EDT)
Message-Id: <20180529.105455.676464019941488974.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len
 in tcp_probe
From: David Miller <davem@davemloft.net>
In-Reply-To: <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
        <20180529.101553.694799514284747444.davem@davemloft.net>
        <CALOAHbAzy_KfT0FcU9fumPKZgSaSOAAfY755TGxsJU7toB_1dA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 22:36:50 +0800

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

Sorry, I pushed it out already.  You'll need to send me relative changes.
