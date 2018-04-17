Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeDQMfO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:35:14 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752974AbeDQMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:35:13 -0400
X-UUID: e1e012b193514423ac6be488c594c450-20180417
Message-ID: <1523968505.23886.2.camel@mtkswgap22>
Subject: Re: [PATCH] clk: mediatek: correct the clocks for MT2701 HDMI PHY
 module
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        chunhui dai <chunhui.dai@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Tue, 17 Apr 2018 20:35:05 +0800
In-Reply-To: <152389649546.51482.15378110712126175925@swboyd.mtv.corp.google.com>
References: <f3248cc94349000b2587d9c6102d56323acba9e0.1523844642.git.ryder.lee@mediatek.com>
         <152389649546.51482.15378110712126175925@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 09:34 -0700, Stephen Boyd wrote:
> Quoting Ryder Lee (2018-04-15 19:31:58)
> > The hdmitx_dig_cts clock signal is not a child of clk26m,
> > and the actual output of the PLL block is derived from
> > the tvdpll via a configurable PLL post-divider.
> > 
> > It is used as the PLL reference input to the HDMI PHY module.
> > 
> > Signed-off-by: Chunhui Dai <chunhui.dai@mediatek.com>
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Any sort of Fixes: tag here?
> 

Yes, I've already sent a new one.

Thanks
