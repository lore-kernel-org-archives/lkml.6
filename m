Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeCLWzH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeCLWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:55:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BE1208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Thierry Reding <thierry.reding@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180312070430.GA23060@ulmo>
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com> <20180308144437.GJ3529@ulmo>
 <152061678678.13890.15810434310624804730@swboyd.mtv.corp.google.com>
 <20180312070430.GA23060@ulmo>
Message-ID: <152089530498.147033.16290802622553476545@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Date: Mon, 12 Mar 2018 15:55:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2018-03-12 00:04:30)
> On Fri, Mar 09, 2018 at 09:33:06AM -0800, Stephen Boyd wrote:
> > 
> > Are you going to send us a PR at some point?
> 
> Yes, I was going to let the patches cook a little in linux-next and send
> a PR by the end of the week. Does that sound okay?
> 

Perfect! Thanks.
