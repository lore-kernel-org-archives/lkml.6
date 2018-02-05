Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBEGNh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753087AbeBEGNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:13:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BE021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 14:12:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] ARM: dts: imx7s: add temperature monitor support
Message-ID: <20180205061237.GE31354@dragon>
References: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 04:09:39PM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> no changes since V1.
>  .../devicetree/bindings/thermal/imx-thermal.txt      |  5 +++--

The bindings doc should be a separate patch or part of related
imx-thermal driver patch ...

>  arch/arm/boot/dts/imx7s.dtsi                         | 20 ++++++++++++++++++++

..., and shouldn't be mixed with dts changes.

Shawn
