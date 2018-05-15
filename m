Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeEOWWj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752442AbeEOWWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:22:32 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: mark.rutland@arm.com, matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@codeaurora.org,
        sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <caf1cbbd0758cbb9c25c081f4d8fdb9f64769a44.1524816502.git.sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <caf1cbbd0758cbb9c25c081f4d8fdb9f64769a44.1524816502.git.sean.wang@mediatek.com>
Message-ID: <152642295077.237094.11444975143729338122@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 5/6] clk: mediatek: add g3dsys support for MT2701 and MT7623
Date: Tue, 15 May 2018 15:22:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FMMiF6029255

Quoting sean.wang@mediatek.com (2018-04-27 01:14:46)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add clock driver support for g3dsys on MT2701 and MT7623, which is
> providing essential clock gate and reset controller to Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next
