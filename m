Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeFDPhB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:37:01 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:37:00 -0400
Date: Mon, 04 Jun 2018 11:36:58 -0400 (EDT)
Message-Id: <20180604.113658.2119075765827988070.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: maxime.chevallier@bootlin.com, kbuild-all@01.org,
        netdev@vger.kernel.org, antoine.tenart@bootlin.com,
        thomas.petazzoni@free-electrons.com, ymarkman@marvell.com,
        stefanc@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: mvpp2: mvpp2_percpu_read_relaxed()
 can be static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180601194613.GA44770@xian>
References: <201806020329.B1k6qmEB%fengguang.wu@intel.com>
        <20180601194613.GA44770@xian>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 2 Jun 2018 03:46:13 +0800

> 
> Fixes: db9d7d36eecc ("net: mvpp2: Split the PPv2 driver to a dedicated directory")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Applied to net-next, thank you.
