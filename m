Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeDWP60 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:58:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755878AbeDWP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:58:23 -0400
Date: Mon, 23 Apr 2018 11:58:21 -0400 (EDT)
Message-Id: <20180423.115821.640630949143585629.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: eric.dumazet@gmail.com, alexei.starovoitov@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: init sk_cookie for inet socket
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
References: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 22 Apr 2018 21:50:04 +0800

> With sk_cookie we can identify a socket, that is very helpful for
> traceing and statistic, i.e. tcp tracepiont and ebpf.
> So we'd better init it by default for inet socket.
> When using it, we just need call atomic64_read(&sk->sk_cookie).
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied, thank you.
