Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBBAoi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbeBBAo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:44:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4A2217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 08:44:21 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, van.freenix@gmail.com
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: enable OP-TEE
Message-ID: <20180202004420.GB20833@dragon>
References: <1515145235-12062-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515145235-12062-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2018 at 05:40:35PM +0800, Peng Fan wrote:
> This patch enables configs for Trusted Execution Environment(TEE) and
> Open Portable Trusted Execution Environment(OP-TEE).
> 
> With Linux running in Trustzone non-secure world, OP-TEE OS runs in
> secure world, linux could use secure services provided by OP-TEE.
> With TEE/OP-TEE options selected, use the bindings
> in Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> to let the driver probe work.
> 
> On i.MX6/7, now the bootflow is U-Boot->OP-TEE->Linux, OP-TEE will
> automatically create that node.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
