Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeBIDBV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeBIDBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:01:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4482173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 9 Feb 2018 11:00:53 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Yung-Ching LIN <yungching0725@gmail.com>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [v3] ARM: dts: imx: Add support for Advantech DMS-BA16
Message-ID: <20180209030052.GK31910@dragon>
References: <20180206191704.7933-1-yungching0725@gmail.com>
 <20180208090345.GH31910@dragon>
 <CACGtqyz-Af6GijOrWYpAM9xvRjUfftA_M1aayf5q+xU1-x8kYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGtqyz-Af6GijOrWYpAM9xvRjUfftA_M1aayf5q+xU1-x8kYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 11:24:53AM -0800, Yung-Ching LIN wrote:
> Will correct the USB_OTG_ID pinmux setting in the v4.
> Do you mind if I redefine reg_usb_otg_vbus node since we just started
> using OTG host/device mode on this board ?

Not at all.  Feel free to change it.

Shawn
