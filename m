Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeEaRXv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:23:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60094 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755827AbeEaRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:23:48 -0400
Date: Thu, 31 May 2018 13:23:44 -0400 (EDT)
Message-Id: <20180531.132344.339904863786377155.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: minor optimization around tcp_hdr()
 usage in receive path
From: David Miller <davem@davemloft.net>
In-Reply-To: <1527607651-28262-1-git-send-email-laoar.shao@gmail.com>
References: <1527607651-28262-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 23:27:31 +0800

> This is additional to the
> commit ea1627c20c34 ("tcp: minor optimizations around tcp_hdr() usage").
> At this point, skb->data is same with tcp_hdr() as tcp header has not
> been pulled yet. So use the less expensive one to get the tcp header.
> 
> Remove the third parameter of tcp_rcv_established() and put it into
> the function body.
> 
> Furthermore, the local variables are listed as a reverse christmas tree :)
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied, thanks.
