Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeAaPcO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:32:14 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44892 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeAaPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:32:13 -0500
Date: Wed, 31 Jan 2018 10:32:11 -0500 (EST)
Message-Id: <20180131.103211.71037107784083462.davem@davemloft.net>
To: hau@realtek.com
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] r8169: fix RTL8168EP take too long to complete
 driver initialization.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1517333556-4378-1-git-send-email-hau@realtek.com>
References: <1517333556-4378-1-git-send-email-hau@realtek.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunhao Lin <hau@realtek.com>
Date: Wed, 31 Jan 2018 01:32:36 +0800

> Driver check the wrong register bit in rtl_ocp_tx_cond() that keep driver
> waiting until timeout.
> 
> Fix this by waiting for the right register bit.
> 
> Signed-off-by: Chunhao Lin <hau@realtek.com>

Applied and queued up for -stable.
