Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeCPWaz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeCPWax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4622321742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1510330017-32200-1-git-send-email-sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
References: <1510330017-32200-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <152123945267.242365.14442807869805498253@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: versatile: add min/max rate boundaries for vexpress osc
 clock
Date: Fri, 16 Mar 2018 15:30:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2017-11-10 08:06:57)
> Clock framework has a provider API(clk_hw_set_rate_range) to set the
> min/max rate of a clock. Use the same to set the boundaries for the
> vexpress osc clock.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Applied to clk-next
