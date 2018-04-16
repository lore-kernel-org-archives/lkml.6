Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDPQe5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeDPQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:34:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202E2217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Ryder Lee <ryder.lee@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f3248cc94349000b2587d9c6102d56323acba9e0.1523844642.git.ryder.lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        chunhui dai <chunhui.dai@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
References: <f3248cc94349000b2587d9c6102d56323acba9e0.1523844642.git.ryder.lee@mediatek.com>
Message-ID: <152389649546.51482.15378110712126175925@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mediatek: correct the clocks for MT2701 HDMI PHY module
Date: Mon, 16 Apr 2018 09:34:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-04-15 19:31:58)
> The hdmitx_dig_cts clock signal is not a child of clk26m,
> and the actual output of the PLL block is derived from
> the tvdpll via a configurable PLL post-divider.
> 
> It is used as the PLL reference input to the HDMI PHY module.
> 
> Signed-off-by: Chunhui Dai <chunhui.dai@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Any sort of Fixes: tag here?
