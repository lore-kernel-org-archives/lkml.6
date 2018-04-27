Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758819AbeD0TWp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:22:45 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758069AbeD0TWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:22:44 -0400
Date: Fri, 27 Apr 2018 15:22:42 -0400 (EDT)
Message-Id: <20180427.152242.1168752739048631383.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp_pch: use helpers function for converting between
 ns and timespec
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427073618.12036-1-yuehaibing@huawei.com>
References: <20180427073618.12036-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 27 Apr 2018 15:36:18 +0800

> use ns_to_timespec64() and timespec64_to_ns() instead of open coding
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to net-next, thanks.
