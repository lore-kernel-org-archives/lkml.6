Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeFDPf4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:35:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:35:54 -0400
Date: Mon, 04 Jun 2018 11:35:52 -0400 (EDT)
Message-Id: <20180604.113552.1136710379930167373.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, wangxi11@huawei.com
Subject: Re: [PATCH net] net: hns: Fix the process of adding broadcast
 addresses to tcam
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180601170011.22700-1-salil.mehta@huawei.com>
References: <20180601170011.22700-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Fri, 1 Jun 2018 18:00:11 +0100

> +		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
> +			mc_mask, mac_entry->addr);

Please indent things properly when arguments span multiple lines.

The second line here should be precisely after the opennning parenthesis
of the previous line.

> +		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
> +			mc_mask, mac_entry->addr);

Likewise.
