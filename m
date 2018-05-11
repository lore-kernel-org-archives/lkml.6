Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEKP5S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:57:18 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47286 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:57:15 -0400
Date: Fri, 11 May 2018 11:57:13 -0400 (EDT)
Message-Id: <20180511.115713.2289767709982338990.davem@davemloft.net>
To: idosch@idosch.org
Cc: christophe.jaillet@wanadoo.fr, jiri@mellanox.com, idosch@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core: Fix an error handling path in
 'mlxsw_core_bus_device_register()'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180510115821.GA10270@splinter.mtl.com>
References: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
        <20180510115821.GA10270@splinter.mtl.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 10 May 2018 14:58:21 +0300

> On Thu, May 10, 2018 at 01:26:16PM +0200, Christophe JAILLET wrote:
>> Resources are not freed in the reverse order of the allocation.
>> Labels are also mixed-up.
>> 
>> Fix it and reorder code and labels in the error handling path of
>> 'mlxsw_core_bus_device_register()'
>> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> For net:
> 
> Fixes: ef3116e5403e ("mlxsw: spectrum: Register KVD resources with devlink")
> Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Applied and queued up for -stable, thanks.
