Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeCHIhM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755148AbeCHIhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:37:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A00206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 8 Mar 2018 16:36:28 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: leonard.crestez@nxp.com, rui.zhang@intel.com, edubezval@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 1/2] ARM: dts: imx7s: add temperature monitor support
Message-ID: <20180308083627.GV3217@dragon>
References: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 09:59:29AM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied this dts patch, thanks.
