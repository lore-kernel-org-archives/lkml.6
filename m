Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeFATWN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeFATWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:22:10 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180524213735.12121-1-bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180524213735.12121-1-bjorn.andersson@linaro.org>
Message-ID: <152788092933.225090.134215386081948476@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gcc-msm8996: Disable halt check on UFS clocks
Date: Fri, 01 Jun 2018 12:22:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JMxeX027206

Quoting Bjorn Andersson (2018-05-24 14:37:35)
> The halt check of the UFS symbol clocks always fails, as such probing
> UFS after clk_disable_unused always fails. This makes it impossible to
> boot a system with the UFS phy or UFS HCD drivers compiled as modules.
> 
> Follow SDM845 and disable the halt check on these clocks.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next
