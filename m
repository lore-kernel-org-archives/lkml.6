Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeCQXur (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:50:47 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeCQXun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:50:43 -0400
Date: Sat, 17 Mar 2018 19:50:41 -0400 (EDT)
Message-Id: <20180317.195041.149491190187125605.davem@davemloft.net>
To: sz.lin@moxa.com
Cc: spatton@ti.com, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org,
        j-keerthy@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: add check for in-band mode
 setting with RGMII PHY interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180315165603.30471-1-sz.lin@moxa.com>
References: <20180315165603.30471-1-sz.lin@moxa.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SZ Lin (林上智) <sz.lin@moxa.com>
Date: Fri, 16 Mar 2018 00:56:01 +0800

> According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
> DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
> available when PHY is configured in RGMII mode with 10Mbps speed. It will
> cause some networking issues without RGMII mode, such as carrier sense
> errors and low throughput. TI also mentioned this issue in their forum[4].
> 
> This patch adds the check mechanism for PHY interface with RGMII interface
> type, the in-band mode can only be set in RGMII mode with 10Mbps speed.
> 
> References:
> [1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
> [2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
> [3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
> [4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155
> 
> Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Signed-off-by: Schuyler Patton <spatton@ti.com>

Applied and queued up for -stable, thank you.
