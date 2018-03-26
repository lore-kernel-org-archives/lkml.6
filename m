Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCZHcX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeCZHcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:32:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26261217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 26 Mar 2018 15:32:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>, arnd@arndb.de
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP
 SoCs
Message-ID: <20180326073214.GB8857@dragon>
References: <20180318203442.19759-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
> Since OTP values might be required by drivers required during
> boot, make sure the driver is built-in (e.g. i.MX thermal
> driver).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Arnd,

The series looks good to me.  In general, I keep myself away from
multi_v7_defconfig changes, but if you expect a pull-request from me, I
can do that.  Let me know how you want to apply the patches.

Shawn
