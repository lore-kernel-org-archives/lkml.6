Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEOWWc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbeEOWW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:22:29 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: mark.rutland@arm.com, matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@codeaurora.org,
        sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d9f327fa30c987ac9cf3a349551bbaa037d1b24a.1524816502.git.sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <d9f327fa30c987ac9cf3a349551bbaa037d1b24a.1524816502.git.sean.wang@mediatek.com>
Message-ID: <152642294776.237094.18331050524697364110@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 4/6] dt-bindings: reset: mediatek: add entry for Mali-450 node
 to refer
Date: Tue, 15 May 2018 15:22:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FMMasO029249

Quoting sean.wang@mediatek.com (2018-04-27 01:14:45)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a required reset referenced by Mali-450 on MT7623
> or MT2701 SoC.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next
