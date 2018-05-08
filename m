Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeEHBOr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753818AbeEHBOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:14:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525690220-26525-4-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525690220-26525-1-git-send-email-anischal@codeaurora.org>
 <1525690220-26525-4-git-send-email-anischal@codeaurora.org>
Message-ID: <152574208368.138124.673130853127341411@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 3/3] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM845
Date: Mon, 07 May 2018 18:14:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w481EqhV003053

Quoting Amit Nischal (2018-05-07 03:50:20)
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add support for the global clock controller found on SDM845
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next
