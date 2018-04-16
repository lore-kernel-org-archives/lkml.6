Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeDPIfF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753541AbeDPIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:35:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250522170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 16 Apr 2018 16:34:27 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Robin Gong <yibin.gong@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        kernel@pengutronix.de, fabio.estevam@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1] ARM: dts: imx6qdl-sabreauto: add ecspi dts for
 sabreauto board
Message-ID: <20180416083426.GF25429@dragon>
References: <1521627768-942-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521627768-942-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 06:22:48PM +0800, Robin Gong wrote:
> DIN pin of SPI-NOR muxed with I2C3_SDA which connected to one gpio expand
> chip, thus have to disable all those module which compacted by those gpios
> if enable SPI-NOR support on Sabreauto board.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

I'm not in the position to maintain a bunch of dts files for a single
board with different device multiplexing options.

Shawn
