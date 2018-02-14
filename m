Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935435AbeBNUeK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:34:10 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:58638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935209AbeBNUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:34:08 -0500
Date: Wed, 14 Feb 2018 15:34:06 -0500 (EST)
Message-Id: <20180214.153406.64641691836057523.davem@davemloft.net>
To: d.schultz@phytec.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        w.egorov@phytec.de
Subject: Re: [PATCH v3 2/2] net: phy: dp83867: Add documentation for
 CLK_OUT pin muxing
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518624432-15110-2-git-send-email-d.schultz@phytec.de>
References: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
        <1518624432-15110-2-git-send-email-d.schultz@phytec.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Schultz <d.schultz@phytec.de>
Date: Wed, 14 Feb 2018 17:07:12 +0100

> From: Wadim Egorov <w.egorov@phytec.de>
> 
> Add documentation of ti,clk-output-sel which can be used to select
> a specific clock for CLK_OUT.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
> 	v2:
> 	  -
> 	v3:
> 	  Fixed indentation.

Also applied to net-next, thanks.
