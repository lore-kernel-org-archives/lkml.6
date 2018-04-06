Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeDFUZx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeDFUZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:25:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D37021720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180327152518.31021-1-bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Imran Khan <kimran@codeaurora.org>,
        Joonwoo Park <joonwoop@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <20180327152518.31021-1-bjorn.andersson@linaro.org>
Message-ID: <152304634949.94378.7962656957799041629@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Add MSM8998 Global Clock Control (GCC) driver
Date: Fri, 06 Apr 2018 13:25:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-03-27 08:25:18)
> From: Joonwoo Park <joonwoop@codeaurora.org>
> 
> Add support for the global clock controller found on MSM8998
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> 
> Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
> Signed-off-by: Imran Khan <kimran@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> [bjorn: Specify regs for alpha_plls, fix white spaces and add binding]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

The patch looks fine to me. I will apply it for v4.17+ though.
