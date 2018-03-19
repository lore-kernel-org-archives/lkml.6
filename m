Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031414AbeCSUlR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966390AbeCSUlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:41:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F9521737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d768a69e47bef843ae324801dca22a66289c959f.1520327262.git.ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <d768a69e47bef843ae324801dca22a66289c959f.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149207219.242365.5264361651929075521@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/6] clk: mediatek: update missing clock data for MT7622 audsys
Date: Mon, 19 Mar 2018 13:41:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-03-06 01:09:26)
> Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next
