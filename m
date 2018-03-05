Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeCERxP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:53:15 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55468 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCERxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:53:12 -0500
Date: Mon, 05 Mar 2018 12:53:10 -0500 (EST)
Message-Id: <20180305.125310.1977914248766873754.davem@davemloft.net>
To: j.neuschaefer@gmx.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: core: dst_cache_set_ip6: Rename 'addr'
 parameter to 'saddr' for consistency
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180304022953.4508-2-j.neuschaefer@gmx.net>
References: <20180304022953.4508-1-j.neuschaefer@gmx.net>
        <20180304022953.4508-2-j.neuschaefer@gmx.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Sun,  4 Mar 2018 03:29:52 +0100

> The other dst_cache_{get,set}_ip{4,6} functions, and the doc comment for
> dst_cache_set_ip6 use 'saddr' for their source address parameter. Rename
> the parameter to increase consistency.
> 
> This fixes the following kernel-doc warnings:
> 
> ./include/net/dst_cache.h:58: warning: Function parameter or member 'addr' not described in 'dst_cache_set_ip6'
> ./include/net/dst_cache.h:58: warning: Excess function parameter 'saddr' description in 'dst_cache_set_ip6'
> 
> Fixes: 911362c70df5 ("net: add dst_cache support")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to net-next.
