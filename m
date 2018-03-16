Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeCPWhv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbeCPWht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:37:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1A204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        srinivas.kandagatla@linaro.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20171207105922.31986-1-srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20171207105922.31986-1-srinivas.kandagatla@linaro.org>
Message-ID: <152123986829.242365.11910441932575486140@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gcc-msm8996: Mark aggre0 noc clks as critical
Date: Fri, 16 Mar 2018 15:37:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting srinivas.kandagatla@linaro.org (2017-12-07 02:59:22)
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> aggre0 bus clks are not associated with any of the drivers, so its
> important that these clks are always on to get peripherals on this
> bus working. So mark them as critical.
> 
> Eventually when we have a proper bus driver these clks can be marked
> appropriately.
> 
> Without this patch pcie on db820c is not functional.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Applied to clk-next
