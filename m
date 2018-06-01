Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeFATIs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbeFATIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:08:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525865551-20489-3-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
References: <1525865551-20489-1-git-send-email-anischal@codeaurora.org>
 <1525865551-20489-3-git-send-email-anischal@codeaurora.org>
Message-ID: <152788012392.144038.11663060475709608609@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] clk: qcom: Add video clock controller driver for SDM845
Date: Fri, 01 Jun 2018 12:08:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51J8rPW027072

Quoting Amit Nischal (2018-05-09 04:32:31)
> Add support for the video clock controller found on SDM845
> based devices. This would allow video drivers to probe and
> control their clocks.
> 
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next
