Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDHX7M (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 19:59:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeDHX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 19:59:11 -0400
Date: Sun, 08 Apr 2018 19:59:10 -0400 (EDT)
Message-Id: <20180408.195910.1975592713449918150.davem@davemloft.net>
To: esben.haabendal@gmail.com
Cc: netdev@vger.kernel.org, eha@deif.com, richardcochran@gmail.com,
        andrew@lunn.ch, f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dp83640: Ensure against premature access to PHY
 registers after reset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180408201702.23299-1-esben.haabendal@gmail.com>
References: <20180406170844.4248-1-esben.haabendal@gmail.com>
        <20180408201702.23299-1-esben.haabendal@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben.haabendal@gmail.com>
Date: Sun,  8 Apr 2018 22:17:01 +0200

> From: Esben Haabendal <eha@deif.com>
> 
> The datasheet specifies a 3uS pause after performing a software
> reset. The default implementation of genphy_soft_reset() does not
> provide this, so implement soft_reset with the needed pause.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied, thank you.
