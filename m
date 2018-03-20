Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeCTQW4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeCTQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:22:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690A82177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sudeep Holla <sudeep.holla@arm.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521547867-23808-1-git-send-email-sudeep.holla@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
 <1521547867-23808-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <152156297081.254778.8373273607540232473@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: scmi: use devm_of_clk_add_hw_provider() API and drop
 scmi_clocks_remove
Date: Tue, 20 Mar 2018 09:22:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2018-03-20 05:11:07)
> Commit aa795c41d9cd ("clk: Add devm_of_clk_add_hw_provider()/del_provider()
> APIs") adds devm_of_clk_add_hw_provider which takes care of deleting the
> clock provider when the clock providers device is removed.
> 
> This patch makes use of devm_of_clk_add_hw_provider() instead of
> of_clk_add_hw_provider() so that we can eliminate the need of explicit
> scmi_clocks_remove for just doing of_clk_del_provider()
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
