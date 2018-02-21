Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeBUUGv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:06:51 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:34494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:06:50 -0500
Date: Wed, 21 Feb 2018 15:06:48 -0500 (EST)
Message-Id: <20180221.150648.1497471262036825265.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: remove the hardcode in the definition of
 TCPF Macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519133311-22068-1-git-send-email-laoar.shao@gmail.com>
References: <1519133311-22068-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 Feb 2018 21:28:31 +0800

> TCPF_ macro depends on the definition of TCP_ macro.
> So it is better to define them with TCP_ marco.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied, thank you.
