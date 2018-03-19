Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032354AbeCSVlb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965255AbeCSVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:41:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A57021737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, srinivas.kandagatla@linaro.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180318144401.21904-1-srinivas.kandagatla@linaro.org>
Cc: david.brown@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20180318144401.21904-1-srinivas.kandagatla@linaro.org>
Message-ID: <152149568591.242365.10167530411419851285@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: qcom: rpmcc: Add support to XO buffered clocks
Date: Mon, 19 Mar 2018 14:41:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting srinivas.kandagatla@linaro.org (2018-03-18 07:44:01)
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> XO is onchip buffer clock to generate 19.2MHz.
> 
> This patch adds support to 5 XO buffer clocks found on PMIC8921,
> these buffer clocks can be controlled from external pin or in
> manual mode.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Applied to clk-next
