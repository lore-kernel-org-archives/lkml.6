Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeFESkv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:40:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40844 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeFESkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:40:49 -0400
Date: Tue, 05 Jun 2018 14:40:46 -0400 (EDT)
Message-Id: <20180605.144046.766561700879427040.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, wangxi11@huawei.com
Subject: Re: [PATCH net-next 2/3] net: hns3: Fix for VF mailbox receiving
 unknown message
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605114201.29900-3-salil.mehta@huawei.com>
References: <20180605114201.29900-1-salil.mehta@huawei.com>
        <20180605114201.29900-3-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Tue, 5 Jun 2018 12:42:00 +0100

> +		if (unlikely(!hnae3_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {

This breaks the build, there is no such symbol named hnae3_get_bit().
