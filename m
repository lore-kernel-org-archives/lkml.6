Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDPUp2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:45:28 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32836 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:45:25 -0400
X-Google-Smtp-Source: AIpwx4+XwFFdqV3InoUW9LPjS8EBYmNbYDpD3ntjQ9/R5Piv6xM9wnBPP8YicrwkncpRXH/0QGFEtA==
Date: Mon, 16 Apr 2018 15:45:23 -0500
From: Rob Herring <robh@kernel.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM RPMh clock
 bindings
Message-ID: <20180416204523.onak3fxtfsqskspc@rob-hp-laptop>
References: <1523673401-21611-1-git-send-email-tdas@codeaurora.org>
 <1523673401-21611-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523673401-21611-2-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 08:06:40AM +0530, Taniya Das wrote:
> Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
> devices would be used for communicating resource state requests to control
> the clocks managed by RPMh.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,rpmh-clk.txt    | 22 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmh.h              | 24 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
>  create mode 100644 include/dt-bindings/clock/qcom,rpmh.h

Reviewed-by: Rob Herring <robh@kernel.org>
