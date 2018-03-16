Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeCPWx5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCPWxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:53:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135E920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Chunyan Zhang <zhang.lyra@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1518169691-14870-1-git-send-email-zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
References: <1518169691-14870-1-git-send-email-zhang.lyra@gmail.com>
Message-ID: <152124083452.242365.3231918073179861035@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clocks: add APB RTC gate for SC9860
Date: Fri, 16 Mar 2018 15:53:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2018-02-09 01:48:10)
> From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> 
> Added index of RTC gate clocks which are used by some devices on aon
> area of SC9860, for example the Watchdog timer.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---

Applied to clk-next
