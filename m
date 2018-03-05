Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeCERxW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:53:22 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55478 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCERxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:53:18 -0500
Date: Mon, 05 Mar 2018 12:53:17 -0500 (EST)
Message-Id: <20180305.125317.931550472772357002.davem@davemloft.net>
To: j.neuschaefer@gmx.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] net: core: dst: Add kernel-doc for 'net' parameter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180304022953.4508-3-j.neuschaefer@gmx.net>
References: <20180304022953.4508-1-j.neuschaefer@gmx.net>
        <20180304022953.4508-3-j.neuschaefer@gmx.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Sun,  4 Mar 2018 03:29:53 +0100

> This fixes the following kernel-doc warning:
> 
> ./include/net/dst.h:366: warning: Function parameter or member 'net' not described in 'skb_tunnel_rx'
> 
> Fixes: ea23192e8e57 ("tunnels: harmonize cleanup done on skb on rx path")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to net-next.
