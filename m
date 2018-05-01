Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeEAVlV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeEAVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:41:19 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524576771-31096-3-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1524576771-31096-1-git-send-email-anischal@codeaurora.org>
 <1524576771-31096-3-git-send-email-anischal@codeaurora.org>
Message-ID: <152521087780.138124.7623601052057968460@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: Add video clock controller driver for SDM845
Date: Tue, 01 May 2018 14:41:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-04-24 06:32:51)
> Add support for the video clock controller found on SDM845
> based devices. This would allow video drivers to probe and
> control their clocks.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

Driver looks small and good. Only concern is that there aren't resets
defined, but the binding says there are resets. Will you add them?

I'm going to wait for the respin on the dts binding anyway.
