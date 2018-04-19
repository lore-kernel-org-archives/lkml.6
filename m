Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDSDSi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752504AbeDSDSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:18:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F3821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: airlied@linux.ie, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com, robh+dt@kernel.org,
        sean.wang@mediatek.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
Message-ID: <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
Date: Wed, 18 Apr 2018 20:18:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting sean.wang@mediatek.com (2018-04-18 03:24:54)
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add bindings to g3dsys providing necessary clock and reset control to
> Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++

Why isn't this under bindings/clock/ ?
