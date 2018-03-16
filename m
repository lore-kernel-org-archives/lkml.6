Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeCPWyC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752678AbeCPWx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:53:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA3021742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Chunyan Zhang <zhang.lyra@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1518170109-15216-1-git-send-email-zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
References: <1518169691-14870-2-git-send-email-zhang.lyra@gmail.com>
 <1518170109-15216-1-git-send-email-zhang.lyra@gmail.com>
Message-ID: <152124083804.242365.2908934110735507785@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: sprd: add RTC gate for SC9860
Date: Fri, 16 Mar 2018 15:53:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2018-02-09 01:55:09)
> From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> 
> Add a few gate clocks which are used for gating RTC for some
> devices on AON area of SC9860.
> 
> This patch has been tested on SC9860, with this patch and proper DT
> configurations, the watchdog can be initialized and work well.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---

Applied to clk-next
