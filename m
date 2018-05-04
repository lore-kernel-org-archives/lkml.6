Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEDQbI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeEDQbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:31:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525350925-16006-1-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525350925-16006-1-git-send-email-anischal@codeaurora.org>
Message-ID: <152545146453.138124.2471609033510400995@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 0/2] Add QCOM video clock controller driver
Date: Fri, 04 May 2018 09:31:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44GVCtj009956

Quoting Amit Nischal (2018-05-03 05:35:23)
> Changes in v1:
>    https://lkml.org/lkml/2018/4/24/545
> Addressed below review comments given by Rob
> - Change the compatible property as per '<vendor>,<soc>-<block>' format.
> - Add header definitions for resets and power-domain cells.

You didn't add any reset definitions though?
