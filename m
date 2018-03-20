Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCTHXj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeCTHXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:23:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF9A21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521526068.13313.8.camel@mtksdaap41>
Cc: Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <1521526068.13313.8.camel@mtksdaap41>
Message-ID: <152153061465.254778.3061562183948751301@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support
Date: Tue, 20 Mar 2018 00:23:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-03-19 23:07:48)
> On Mon, 2018-03-12 at 15:03 +0800, Weiyi Lu wrote:
> > This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
> > Basically, all changes are for the ECO design change of MT2712.
> > 
> > changes since v1:
> > - Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.
> > 
> Hi Matthias & Stephen,
> 
> Sorry to bother. Just saw patch 1/2 are already pushed to v4.16-next-soc
> and patch 3/5 are applied onto clk-next. What about the patch 4(arm64:
> dts: add clock device nodes of MT2712). Does there any problem remain or
> it cause some problems? Many thanks.

Patch 4 can go via arm-soc? I'm not planning to apply that patch.
