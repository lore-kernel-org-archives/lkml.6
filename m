Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeETNAF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeETNAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:00:03 -0400
Date: Sun, 20 May 2018 20:59:03 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: cleanup eMMC node
Message-ID: <20180520125902.GZ26863@dragon>
References: <20180516065349.11160-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516065349.11160-1-nikita.yoush@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 09:53:49AM +0300, Nikita Yushchenko wrote:
> On RDU1, sdhc1 is used for eMMC, and that is 3.3V only.
> 
> Thus configure device node not to probe it as SD/SDIO and not try 1.8V.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied, thanks.
