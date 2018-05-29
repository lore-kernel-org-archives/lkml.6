Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934627AbeE2OP4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:15:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeE2OPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:15:55 -0400
Date: Tue, 29 May 2018 10:15:53 -0400 (EDT)
Message-Id: <20180529.101553.694799514284747444.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tcp: use data length instead of skb->len
 in tcp_probe
From: David Miller <davem@davemloft.net>
In-Reply-To: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
References: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 25 May 2018 18:14:05 +0800

> skb->len is meaningless to user.
> data length could be more helpful, with which we can easily filter out
> the packet without payload.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied, thank you.
