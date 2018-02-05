Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeBEHgM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeBEHgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:36:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C446217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 15:35:50 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: fix the at24 compatible string in imx6q-h100
Message-ID: <20180205073548.GN31354@dragon>
References: <20180124213148.4435-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124213148.4435-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 10:31:48PM +0100, Bartosz Golaszewski wrote:
> Using 'at24' as fallback is now deprecated - use the full
> 'atmel,<model>' string.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applied, thanks.
