Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeEHBN2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752835AbeEHBN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:13:26 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525690220-26525-3-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525690220-26525-1-git-send-email-anischal@codeaurora.org>
 <1525690220-26525-3-git-send-email-anischal@codeaurora.org>
Message-ID: <152574200540.138124.8462765928689837443@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/3] clk: qcom: Add DT bindings for SDM845 gcc clock controller
Date: Mon, 07 May 2018 18:13:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w481DVMc003037

Quoting Amit Nischal (2018-05-07 03:50:19)
> Add compatible string and the include file for gcc clock
> controller for SDM845.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
