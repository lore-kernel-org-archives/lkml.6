Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeCGRXS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:23:18 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeCGRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:23:15 -0500
Date: Wed, 07 Mar 2018 12:23:13 -0500 (EST)
Message-Id: <20180307.122313.352163759170213843.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: stefanc@marvell.com, kbuild-all@01.org, antoine.tenart@bootlin.com,
        thomas.petazzoni@free-electrons.com, elfring@users.sourceforge.net,
        maxime.chevallier@bootlin.com, miquel.raynal@free-electrons.com,
        mw@semihalf.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] net: mvpp2: mvpp2_check_hw_buf_num()
 can be static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306050506.GA35183@xian>
References: <201803061326.5AOkQ4Wu%fengguang.wu@intel.com>
        <20180306050506.GA35183@xian>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 6 Mar 2018 13:05:06 +0800

> Fixes: effbf5f58d64 ("net: mvpp2: update the BM buffer free/destroy logic")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Applied.
