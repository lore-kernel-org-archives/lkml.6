Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeCEPoE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:44:04 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54048 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeCEPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:44:02 -0500
Date: Mon, 05 Mar 2018 10:44:01 -0500 (EST)
Message-Id: <20180305.104401.786259807319660242.davem@davemloft.net>
To: sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next v2] net/ncsi: Add generic netlink family
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180305003905.27227-1-sam@mendozajonas.com>
References: <20180305003905.27227-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Mon,  5 Mar 2018 11:39:05 +1100

> Add a generic netlink family for NCSI. This supports three commands;
> NCSI_CMD_PKG_INFO which returns information on packages and their
> associated channels, NCSI_CMD_SET_INTERFACE which allows a specific
> package or package/channel combination to be set as the preferred
> choice, and NCSI_CMD_CLEAR_INTERFACE which clears any preferred setting.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> ---
> v2: Add a separate NCSI_CMD_CLEAR_INTERFACE command instead of allowing
> missing attributes in NCSI_CMD_SET_INTERFACE.

Applied, thank you.
