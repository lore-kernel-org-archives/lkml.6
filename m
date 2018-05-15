Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeEOWW1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeEOWWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:22:25 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: mark.rutland@arm.com, matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@codeaurora.org,
        sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
Message-ID: <152642294413.237094.5984228407773602112@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: mediatek: add entry for Mali-450 node
 to refer
Date: Tue, 15 May 2018 15:22:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FMMXrd029244

Quoting sean.wang@mediatek.com (2018-04-27 01:14:44)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a required clock referenced by Mali-450 on MT7623
> or MT2701 SoC.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next
