Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeEJL6Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:58:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46629 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757152AbeEJL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:58:24 -0400
X-ME-Sender: <xms:3zP0WvGjTQr7JpqEJnEcZDOdjHog7V4bA42wnfxRlTA3r_RIDBrQAw>
Date: Thu, 10 May 2018 14:58:21 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jiri@mellanox.com, idosch@mellanox.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core: Fix an error handling path in
 'mlxsw_core_bus_device_register()'
Message-ID: <20180510115821.GA10270@splinter.mtl.com>
References: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510112616.20508-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:26:16PM +0200, Christophe JAILLET wrote:
> Resources are not freed in the reverse order of the allocation.
> Labels are also mixed-up.
> 
> Fix it and reorder code and labels in the error handling path of
> 'mlxsw_core_bus_device_register()'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

For net:

Fixes: ef3116e5403e ("mlxsw: spectrum: Register KVD resources with devlink")
Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Next time, please indicate the tree you're targeting as explained here:
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

And include a Fixes line as explained here:
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

Thanks!
