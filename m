Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeBHSue (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:50:34 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47968 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:50:33 -0500
Date: Thu, 08 Feb 2018 13:50:31 -0500 (EST)
Message-Id: <20180208.135031.1017713600177598876.davem@davemloft.net>
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
From: David Miller <davem@davemloft.net>
In-Reply-To: <e1ef5d15-91f9-c4ad-9a85-cc360a0b425a@ti.com>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
        <20180207.215735.1518454397358783732.davem@davemloft.net>
        <e1ef5d15-91f9-c4ad-9a85-cc360a0b425a@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 8 Feb 2018 10:04:31 -0600

> Could this be marked as stable material 4.9+?

Sure, queued up.
