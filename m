Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeDPOvk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDPOvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:51:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E6621776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 16 Apr 2018 22:51:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: imx_v6_v7_defconfig: add RN5T618 PMIC family
 support
Message-ID: <20180416145105.GL25429@dragon>
References: <20180318201510.13086-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318201510.13086-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 09:15:08PM +0100, Stefan Agner wrote:
> This allows to successfully boot Colibri iMX7 which is using
> the Ricoh RN5T567 PMIC.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied all, thanks.
