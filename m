Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeBEIDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeBEIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:03:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFDC2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 16:03:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add quadspi node
Message-ID: <20180205080323.GP31354@dragon>
References: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 03:20:14PM +0100, Rasmus Villemoes wrote:
> Add a node to device tree repesenting the QuadSPI controller present on
> LS1021a. Driver support has been present since e8c034b2fbe5 (mtd:
> spi-nor: fsl-quadspi: add support for ls1021a).
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied, thanks.
