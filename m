Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDPRjS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeDPRjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:39:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683C21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1523673401-21611-2-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1523673401-21611-1-git-send-email-tdas@codeaurora.org>
 <1523673401-21611-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152390035549.51482.14663987553632487490@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Mon, 16 Apr 2018 10:39:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-13 19:36:40)
> Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
> devices would be used for communicating resource state requests to control
> the clocks managed by RPMh.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

Is Amit the author? Needs a "From: Amit .." then.

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
