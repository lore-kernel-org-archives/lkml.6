Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeETNCf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeETNCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:02:32 -0400
Date: Sun, 20 May 2018 21:01:32 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx6sx: disable unnecessary clocks during clock
 initialization
Message-ID: <20180520130130.GA26863@dragon>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:00:47PM +0800, Anson Huang wrote:
> Disable those unnecessary clocks during kernel boot up to save power,
> those modules clock should be managed by modules driver in runtime.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
