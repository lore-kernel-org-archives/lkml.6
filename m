Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeCPWac convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbeCPWaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CB721742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAPKp9ubFmhRGaLvB5_Z-WCXiJZYH_W=V43e+Py1DWMk03rrMeg@mail.gmail.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <1510330017-32200-1-git-send-email-sudeep.holla@arm.com>
 <CAPKp9ubFmhRGaLvB5_Z-WCXiJZYH_W=V43e+Py1DWMk03rrMeg@mail.gmail.com>
Message-ID: <152123942933.242365.9527424154926596361@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: versatile: add min/max rate boundaries for vexpress osc
 clock
Date: Fri, 16 Mar 2018 15:30:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2018-02-19 07:55:37)
> On Fri, Nov 10, 2017 at 4:06 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Clock framework has a provider API(clk_hw_set_rate_range) to set the
> > min/max rate of a clock. Use the same to set the boundaries for the
> > vexpress osc clock.
> >
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/clk/versatile/clk-vexpress-osc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > Hi Stephen,
> >
> > Just a quick question, does the clk core ensure the round_rate request
> > to the clock provider is within this bounds ? A quick grep suggests it's
> > used after the call to round_rate in clk_calc_new_rates. I can't recall
> > the details from when you introduced clk_hw_set_rate_range.
> >
> 
> Ping !

Pong !
