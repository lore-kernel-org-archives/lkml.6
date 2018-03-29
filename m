Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeC2QGm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:06:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45324 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeC2QGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:06:40 -0400
Date: Thu, 29 Mar 2018 12:06:38 -0400 (EDT)
Message-Id: <20180329.120638.2239576975237528024.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, scott.branden@broadcom.com,
        abhishek.shah@broadcom.com, fw@strlen.de, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 0/2] net: bgmac: Couple of small bgmac changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180327232002.29399-1-f.fainelli@gmail.com>
References: <20180327232002.29399-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 27 Mar 2018 16:20:00 -0700

> This patch series addresses two minor issues with the bgmac driver:
> 
> - provides the interface name through /proc/interrupts rather than "bgmac"
> - makes sure the interrupts are masked during probe, in case the block was
>   not properly reset

Series applied, thanks Florian.
