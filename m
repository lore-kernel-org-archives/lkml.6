Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeEQT4D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:56:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33994 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:56:02 -0400
Date: Thu, 17 May 2018 15:56:00 -0400 (EDT)
Message-Id: <20180517.155600.903265775108610740.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: doshir@vmware.com, pv-drivers@vmware.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vmxnet3: Replace msleep(1) with usleep_range()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517034641.30004-1-yuehaibing@huawei.com>
References: <20180517034641.30004-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 17 May 2018 11:46:41 +0800

> As documented in Documentation/timers/timers-howto.txt,
> replace msleep(1) with usleep_range().
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
