Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeDVS4F (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 14:56:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeDVS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 14:56:04 -0400
Date: Sun, 22 Apr 2018 14:56:03 -0400 (EDT)
Message-Id: <20180422.145603.2079222042973638224.davem@davemloft.net>
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: fix tx vlan priority
 mapping
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524167349-11004-1-git-send-email-ivan.khoronzhuk@linaro.org>
References: <1524167349-11004-1-git-send-email-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 19 Apr 2018 22:49:09 +0300

> The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
> register and basically replaces vlan pcp field for tagged packets.
> So, set it to be 1:1 mapping. Otherwise, it will cause unexpected
> change of egress vlan tagged packets, like prio 2 -> prio 5.
> 
> Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

Applied and queud up for -stable.
