Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeEBNWb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbeEBNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:22:28 -0400
Date: Wed, 2 May 2018 21:22:18 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] ARM: dts: imx53-ppd: Use IRQ_TYPE_* constants
Message-ID: <20180502132216.GL3443@dragon>
References: <20180420154553.18070-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420154553.18070-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 05:45:53PM +0200, Sebastian Reichel wrote:
> Replace magic numbers with IRQ_TYPE_* constants to improve
> DT readability.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applied, thanks.
