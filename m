Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeEOVE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeEOVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:04:24 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <93ee0d94-81aa-db81-2bff-87f5f91bc9d3@samsung.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
 <CGME20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804@epcas1p2.samsung.com>
 <93ee0d94-81aa-db81-2bff-87f5f91bc9d3@samsung.com>
Message-ID: <152641826350.237094.15477833672849994762@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 05/61] clk: samsung: simplify getting .drvdata
Date: Tue, 15 May 2018 14:04:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FL4Wso025235

Quoting Sylwester Nawrocki (2018-05-15 02:32:12)
> On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> It seems to be the only clk/samsung patch in the v4.18 queue, please
> feel free to apply it directly.

Ok. I'll pick it up.
