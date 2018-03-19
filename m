Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032023AbeCSUl6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030438AbeCSUlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:41:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6530D217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Rob Herring <robh+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9ff8a4ae99e50bc5f9f1ae6c7a454cb80451fd5b.1520327262.git.ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Garlic Tseng <garlic.tseng@mediatek.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <9ff8a4ae99e50bc5f9f1ae6c7a454cb80451fd5b.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149210481.242365.6023758294737799949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 5/6] dt-bindings: clock: mediatek: add audsys support for
 MT2701
Date: Mon, 19 Mar 2018 13:41:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryder Lee (2018-03-06 01:09:30)
> This patch adds a compatible string for MT2701.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next
