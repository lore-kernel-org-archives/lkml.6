Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbeEAMjw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:39:52 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46696 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754970AbeEAMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:39:50 -0400
X-Google-Smtp-Source: AB8JxZqbkNuPuMn5wqnAEGvxRX4cbzizzvIY1u+tKbIHrb+0tcMjwdY4LSDJmrvanvMx3k7FtwCWrg==
Date: Tue, 1 May 2018 07:39:48 -0500
From: Rob Herring <robh@kernel.org>
To: Amit Nischal <anischal@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] clk: qcom: Add Global Clock controller (GCC)
 driver for SDM845
Message-ID: <20180501123948.GA28494@rob-hp-laptop>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-4-git-send-email-anischal@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525105210-8689-4-git-send-email-anischal@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 09:50:10PM +0530, Amit Nischal wrote:
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add support for the global clock controller found on SDM845
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
>  drivers/clk/qcom/Kconfig                           |   10 +-
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-sdm845.c                      | 3480 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  239 ++
>  5 files changed, 3727 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clk/qcom/gcc-sdm845.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm845.h

For the DT bits:

Reviewed-by: Rob Herring <robh@kernel.org>

In the future please split bindings and binding headers to separate 
patch.

Rob
