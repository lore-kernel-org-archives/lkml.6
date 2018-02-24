Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBXHsV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 02:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbeBXHsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 02:48:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206B21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 24 Feb 2018 15:48:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ken Lin <yungching0725@gmail.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] ARM: dts: imx: Add support for Advantech DMS-BA16
Message-ID: <20180224074803.GG3217@dragon>
References: <20180209215515.31136-1-yungching0725@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209215515.31136-1-yungching0725@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 05:55:15AM +0800, Ken Lin wrote:
> Add support for Advantech DMS-BA16 board, which uses
> the Advantech BA-16 module.
> 
> Signed-off-by: Ken Lin <yungching0725@gmail.com>

Applied, thanks.
