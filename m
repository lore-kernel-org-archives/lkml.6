Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDMQhK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:37:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39160 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeDMQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:37:07 -0400
X-Google-Smtp-Source: AIpwx4+6gIRq/7ta2t/trDDTabE/GNzsP5zNknVHql2oIt6bWlWkbpTFKrc9zxYV6TTt6Vxg4YjuHw==
Date: Fri, 13 Apr 2018 11:37:05 -0500
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [[PATCH v2] 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Message-ID: <20180413163705.io4xbukerjkzjmri@rob-hp-laptop>
References: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
 <1523183533-23171-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523183533-23171-2-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 04:02:12PM +0530, Taniya Das wrote:
> From: Amit Nischal <anischal@codeaurora.org>
> 
> Add the RPMh clock driver to control the RPMh managed clock resources on
> some of the Qualcomm Technologies, Inc. SoCs.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/Kconfig              |   9 +
>  drivers/clk/qcom/Makefile             |   1 +
>  drivers/clk/qcom/clk-rpmh.c           | 394 ++++++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/qcom,rpmh.h |  25 +++

This goes with the binding patch which should come first in the series.

>  4 files changed, 429 insertions(+)
>  create mode 100644 drivers/clk/qcom/clk-rpmh.c
>  create mode 100644 include/dt-bindings/clock/qcom,rpmh.h
