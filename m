Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeEPSNg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:13:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43334 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeEPSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:13:33 -0400
Date: Wed, 16 May 2018 14:13:32 -0400 (EDT)
Message-Id: <20180516.141332.138841350079205530.davem@davemloft.net>
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180515233725.11882-1-grygorii.strashko@ti.com>
References: <20180515233725.11882-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 15 May 2018 18:37:25 -0500

> This fixes klockworks warnings: Pointer 'dev' returned from call to
> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
> at line 181.
> 
>     cpsw-phy-sel.c:179: 'dev' is assigned the return value from function 'bus_find_device'.
>     bus.c:342: 'bus_find_device' explicitly returns a NULL value.
>     cpsw-phy-sel.c:181: 'dev' is dereferenced by passing argument 1 to function 'dev_get_drvdata'.
>     device.h:1024: 'dev' is passed to function 'dev_get_drvdata'.
>     device.h:1026: 'dev' is explicitly dereferenced.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> [nsekhar@ti.com: add an error message, fix return path]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2: use %pOF

Applied, thank you.
