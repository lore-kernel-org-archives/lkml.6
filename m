Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeDAC23 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 22:28:29 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDAC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 22:28:28 -0400
Date: Sat, 31 Mar 2018 22:28:26 -0400 (EDT)
Message-Id: <20180331.222826.960939519966790751.davem@davemloft.net>
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH] ethernet: hisilicon: hns: hns_dsaf_mac: Use generic
 eth_broadcast_addr
From: David Miller <davem@davemloft.net>
In-Reply-To: <7ca107f9960b176c10c7b1ac4c4fe0b492fb1b48.1522438626.git.joe@perches.com>
References: <7ca107f9960b176c10c7b1ac4c4fe0b492fb1b48.1522438626.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Fri, 30 Mar 2018 12:37:30 -0700

> Rather than use an on-stack array to copy a broadcast address, use
> the generic eth_broadcast_addr function to save a trivial amount of
> object code.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
