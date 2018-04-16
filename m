Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755366AbeDPOR6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:17:58 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeDPOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:17:57 -0400
Date: Mon, 16 Apr 2018 10:17:55 -0400 (EDT)
Message-Id: <20180416.101755.99677892602830691.davem@davemloft.net>
To: jacopo+renesas@jmondi.org
Cc: sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a77965 SoC
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523886917-14491-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523886917-14491-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Mon, 16 Apr 2018 15:55:17 +0200

> Add documentation for r8a77965 compatible string to renesas ravb device
> tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> ---
> 
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.

Since this is purely a devicetree update, I'm assuming that it doesn't
go through my networking tree.
