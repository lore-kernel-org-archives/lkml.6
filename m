Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934141AbeEWS7J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:59:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33438 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbeEWS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:59:05 -0400
Date: Wed, 23 May 2018 14:59:03 -0400 (EDT)
Message-Id: <20180523.145903.822514317497182953.davem@davemloft.net>
To: haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc: netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hv_netvsc: Add handlers for ethtool get/set
 msg level
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522182934.31515-1-haiyangz@linuxonhyperv.com>
References: <20180522182934.31515-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Tue, 22 May 2018 11:29:34 -0700

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The handlers for ethtool get/set msg level are missing from netvsc.
> This patch adds them.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied.
