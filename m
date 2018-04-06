Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDFVgf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbeDFVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:35:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350DC21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180326173905.22313-7-manivannan.sadhasivam@linaro.org>
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180326173905.22313-1-manivannan.sadhasivam@linaro.org>
 <20180326173905.22313-7-manivannan.sadhasivam@linaro.org>
Message-ID: <152305050964.94378.3237876684476125927@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 06/11] clk: actions: Add divider clock support
Date: Fri, 06 Apr 2018 14:35:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-03-26 10:39:00)
> Add support for Actions Semi divider clock together with
> helper functions to be used in composite clock.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
