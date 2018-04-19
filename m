Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDSBH5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:07:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeDSBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:07:55 -0400
Date: Wed, 18 Apr 2018 21:07:51 -0400 (EDT)
Message-Id: <20180418.210751.1793156688029577127.davem@davemloft.net>
To: m-karicheri2@ti.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com
Subject: Re: [net-next PATCH v4 00/13] Add support for netcp driver on K2G
 SoC
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Tue, 17 Apr 2018 17:30:29 -0400

> K2G SoC is another variant of Keystone family of SoCs. This patch
> series add support for NetCP driver on this SoC. The QMSS found on
> K2G SoC is a cut down version of the QMSS found on other keystone
> devices with less number of queues, internal link ram etc. The patch
> series has 2 patch sets that goes into the drivers/soc and the
> rest has to be applied to net sub system. Please review and merge
> if this looks good.
> 
> K2G TRM is located at http://www.ti.com/lit/ug/spruhy8g/spruhy8g.pdf
> Thanks
> 
> The boot logs on K2G ICE board (tftp boot over Ethernet and from mmc)
> https://pastebin.ubuntu.com/p/yvZ6drFhkW/
> 
> 
> The boot logs on K2G GP board (tftp boot over Ethernet and from mmc)
> https://pastebin.ubuntu.com/p/QTr6K7s4Zp/
> 
> Also regressed boot on K2HK and K2L EVMs as we have modified GBE
> version detection logic (K2E uses same version of NetCP as in K2L.
> So regression on one of them is needed).
> 
> Boot log on K2L and K2HK EVMs are at
> https://pastebin.ubuntu.com/p/N9DBdPjbvR/ 
> 
> This series applies to net-next master branch.

Series applied, thank you.
