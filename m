Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEQTM1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:12:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEQTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:12:25 -0400
Date: Thu, 17 May 2018 15:12:23 -0400 (EDT)
Message-Id: <20180517.151223.1480085511338001366.davem@davemloft.net>
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: disable mq feature for
 "AM33xx ES1.0" devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516222145.26877-1-ivan.khoronzhuk@linaro.org>
References: <20180516222145.26877-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 17 May 2018 01:21:45 +0300

> The early versions of am33xx devices, related to ES1.0 SoC revision
> have errata limiting mq support. That's the same errata as
> commit 7da1160002f1 ("drivers: net: cpsw: add am335x errata workarround for
> interrutps")
> 
> AM33xx Errata [1] Advisory 1.0.9
> http://www.ti.com/lit/er/sprz360f/sprz360f.pdf
> 
> After additional investigation were found that drivers w/a is
> propagated on all AM33xx SoCs and on DM814x. But the errata exists
> only for ES1.0 of AM33xx family, limiting mq support for revisions
> after ES1.0. So, disable mq support only for related SoCs and use
> separate polls for revisions allowing mq.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master

Patch applied to net-next, thank you.
