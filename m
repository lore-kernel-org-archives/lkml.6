Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755617AbeDZXke convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeDZXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:40:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF088217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524572599-5425-2-git-send-email-tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1524572599-5425-1-git-send-email-tdas@codeaurora.org>
 <1524572599-5425-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152478603012.46528.7044842716089842149@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [v4 1/2] dt-bindings: clock: Introduce QCOM RPMh clock bindings
Date: Thu, 26 Apr 2018 16:40:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-24 05:23:18)
> Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
> devices would be used for communicating resource state requests to control
> the clocks managed by RPMh.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
