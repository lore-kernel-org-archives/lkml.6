Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFVfF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeDFVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:35:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42933217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180326173905.22313-4-manivannan.sadhasivam@linaro.org>
Cc: devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        manivannanece23@gmail.com, viresh.kumar@linaro.org,
        bdong@ucrobotics.com, liuwei@actions-semi.com,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org, hzhang@ucrobotics.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com, mchehab@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
References: <20180326173905.22313-1-manivannan.sadhasivam@linaro.org>
 <20180326173905.22313-4-manivannan.sadhasivam@linaro.org>
Message-ID: <152305050159.94378.3150410564930488271@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 03/11] clk: actions: Add common clock driver support
Date: Fri, 06 Apr 2018 14:35:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-03-26 10:38:57)
> Add support for Actions Semi common clock driver with generic structures
> and interface functions.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
