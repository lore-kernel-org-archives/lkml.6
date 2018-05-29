Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033819AbeE2DDC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:03:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033722AbeE2DC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:02:59 -0400
Date: Mon, 28 May 2018 23:02:57 -0400 (EDT)
Message-Id: <20180528.230257.843191181090212127.davem@davemloft.net>
To: jmaxwell37@gmail.com
Cc: dsahern@gmail.com, mschiffer@universe-factory.net,
        zhangshengju@cmss.chinamobile.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: Re: [PATCH net-next] ifb: fix packets checksum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524213829.15208-1-jmaxwell37@gmail.com>
References: <20180524213829.15208-1-jmaxwell37@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Fri, 25 May 2018 07:38:29 +1000

> Fixup the checksum for CHECKSUM_COMPLETE when pulling skbs on RX path. 
> Otherwise we get splats when tc mirred is used to redirect packets to ifb.
> 
> Before fix:
> 
> nic: hw csum failure
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

Applied.
