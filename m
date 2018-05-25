Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967846AbeEYSx0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:53:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36098 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967543AbeEYSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:53:25 -0400
Date: Fri, 25 May 2018 14:53:23 -0400 (EDT)
Message-Id: <20180525.145323.1635564901910925854.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: remove stale comment
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524112707.3580-1-yuehaibing@huawei.com>
References: <20180524112707.3580-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 24 May 2018 19:27:07 +0800

> This comment is outdated as fec_ptp_ioctl has been replaced by fec_ptp_set/fec_ptp_get 
> since commit 1d5244d0e43b ("fec: Implement the SIOCGHWTSTAMP ioctl")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
