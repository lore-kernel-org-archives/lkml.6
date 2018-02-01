Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeBAPK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:10:29 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44348 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeBAPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:10:18 -0500
Date: Thu, 01 Feb 2018 10:10:17 -0500 (EST)
Message-Id: <20180201.101017.2235446399504795866.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@redhat.com,
        nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] rtnetlink: remove check for IFLA_IF_NETNSID
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201115600.29334-1-christian.brauner@ubuntu.com>
References: <20180201115600.29334-1-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu,  1 Feb 2018 12:56:00 +0100

> RTM_NEWLINK supports the IFLA_IF_NETNSID property since
> 5bb8ed075428b71492734af66230aa0c07fcc515 so we should not error out
> when it is passed.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks Christian.
