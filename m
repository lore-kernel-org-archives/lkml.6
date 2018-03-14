Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCNRVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:21:45 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCNRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:21:41 -0400
Date: Wed, 14 Mar 2018 13:21:38 -0400 (EDT)
Message-Id: <20180314.132138.804498167496036853.davem@davemloft.net>
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH net-next] tuntap: XDP_TX can use native XDP
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520997820-8289-1-git-send-email-jasowang@redhat.com>
References: <1520997820-8289-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Mar 2018 11:23:40 +0800

> Now we have ndo_xdp_xmit, switch to use it instead of the slow generic
> XDP TX routine. XDP_TX on TAP gets ~20% improvements from ~1.5Mpps to
> ~1.8Mpps on 2.60GHz Core(TM) i7-5600U.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks Jason.
