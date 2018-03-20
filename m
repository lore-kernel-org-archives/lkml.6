Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbeCTBGV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932939AbeCTBGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:06:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A514821736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180317100952.28538-8-manivannan.sadhasivam@linaro.org>
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-8-manivannan.sadhasivam@linaro.org>
Message-ID: <152150797816.254778.11387369821976295862@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 07/12] clk: actions: Add divider clock support
Date: Mon, 19 Mar 2018 18:06:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-03-17 03:09:47)
> Add support for Actions Semi divider clock together with
> helper functions to be used in composite clock.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Looks good. Please resend.
