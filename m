Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBHO0B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:26:01 -0500
Received: from mail02.prevas.se ([62.95.78.10]:20889 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeBHOZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:25:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HYAADQXHxa/2h+ugUNUBsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGFT4NlmkuZbQqFOwKDBRQBAgEBAQEBAQIDhjUBAQEDI1YQCxgCAiYCAlc?=
 =?us-ascii?q?GDQYCAQG4Zm6CJ4UAg3eCCgEBAQEBAQEDAQEBAQEjgQ+DaoNsgWgpDIJ5gy8Eh?=
 =?us-ascii?q?QaCZQWkKwmCTJMwlD6YDIE8NoFzTYM7hHh3jVEBAQE?=
X-IPAS-Result: =?us-ascii?q?A2HYAADQXHxa/2h+ugUNUBsBAQEBAwEBAQkBAQGFT4Nlmku?=
 =?us-ascii?q?ZbQqFOwKDBRQBAgEBAQEBAQIDhjUBAQEDI1YQCxgCAiYCAlcGDQYCAQG4Zm6CJ?=
 =?us-ascii?q?4UAg3eCCgEBAQEBAQEDAQEBAQEjgQ+DaoNsgWgpDIJ5gy8EhQaCZQWkKwmCTJM?=
 =?us-ascii?q?wlD6YDIE8NoFzTYM7hHh3jVEBAQE?=
X-IronPort-AV: E=Sophos;i="5.46,479,1511823600";
   d="scan'208";a="3030768"
Subject: Re: [PATCH] ARM: dts: ls1021a: add quadspi node
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
 <20180205080323.GP31354@dragon>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
Date: Thu, 8 Feb 2018 15:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205080323.GP31354@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-05 09:03, Shawn Guo wrote:
> On Fri, Jan 26, 2018 at 03:20:14PM +0100, Rasmus Villemoes wrote:
>> Add a node to device tree repesenting the QuadSPI controller present on
>> LS1021a. Driver support has been present since e8c034b2fbe5 (mtd:
>> spi-nor: fsl-quadspi: add support for ls1021a).
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> Applied, thanks.
> 

Sorry, I didn't know you already had a similar patch queued for 4.16
(85f8ee78ab ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC),
so I have to ask you to unapply (or do you want me to send a revert?) -
the ls1021a.dtsi in your imx/dt branch now has two almost-identical
qspi: nodes.

Rasmus
