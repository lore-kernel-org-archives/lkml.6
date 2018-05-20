Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeETMk5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 08:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbeETMky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 08:40:54 -0400
Date: Sun, 20 May 2018 20:39:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx7d: correct cpu supply name for voltage
 scaling
Message-ID: <20180520123954.GV26863@dragon>
References: <1526437548-32372-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526437548-32372-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 10:25:48AM +0800, Anson Huang wrote:
> Correct CPU supply name to meet cpufreq-dt driver's
> requirement for voltage scaling.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
