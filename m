Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDFCYk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:24:40 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35626 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDFCYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:24:39 -0400
Date: Thu, 05 Apr 2018 22:24:37 -0400 (EDT)
Message-Id: <20180405.222437.1573582680811455269.davem@davemloft.net>
To: andrew@lunn.ch
Cc: esben@haabendal.dk, f.fainelli@gmail.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rasmus.villemoes@prevas.dk
Subject: Re: [PATCH 2/2] net: phy: dp83640: Read strapped configuration
 settings
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180405204049.GD17495@lunn.ch>
References: <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com>
        <87d0zdjszu.fsf@haabendal.dk>
        <20180405204049.GD17495@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 5 Apr 2018 22:40:49 +0200

> Or could it still contain whatever state the last boot of Linux, or
> maybe the bootloader, left the PHY in?

Right, this is my concern as well.
