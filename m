Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbeCPWbr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbeCPWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:31:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900C121742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Brian Starkey <brian.starkey@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1510586871-27478-1-git-send-email-brian.starkey@arm.com>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, sudeep.holla@arm.com
References: <1510586871-27478-1-git-send-email-brian.starkey@arm.com>
Message-ID: <152123950398.242365.1602988149994517949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: versatile: Remove WARNs in ->round_rate()
Date: Fri, 16 Mar 2018 15:31:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Starkey (2017-11-13 07:27:51)
> clk_round_rate() is intended to be used to round a given clock rate to
> the closest one achievable by the actual clock. This implies that the
> input to clk_round_rate() is expected to be unachievable - and such
> cases shouldn't be treated as exceptional.
> 
> To reflect this, remove the WARN_ONs which trigger when an unachievable
> clock rate is passed to vexpress_osc_round_rate().
> 
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Applied to clk-next
