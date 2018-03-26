Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeCZBXx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:23:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44432 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCZBXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:23:51 -0400
Date: Sun, 25 Mar 2018 21:23:50 -0400 (EDT)
Message-Id: <20180325.212350.997141590667345909.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: jon.maloy@ericsson.com, kbuild-all@01.org, netdev@vger.kernel.org,
        ying.xue@windriver.com, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] tipc: tipc_disc_addr_trial_msg() can be
 static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180323194742.GA68339@athens>
References: <201803240317.PGXU57zT%fengguang.wu@intel.com>
        <20180323194742.GA68339@athens>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 24 Mar 2018 03:47:42 +0800

> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Applied.
