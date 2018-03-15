Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeCOSO3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbeCOSO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:14:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A7A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520542640-9185-2-git-send-email-eajames@linux.vnet.ibm.com>
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        eajames@linux.vnet.ibm.com, mine260309@gmail.com,
        ryan_chen@aspeedtech.com
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520542640-9185-2-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <152113766641.111154.15925874974920514772@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] clk: aspeed: Fix is_enabled for certain clocks
Date: Thu, 15 Mar 2018 11:14:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2018-03-08 12:57:19)
> Some of the Aspeed clocks are disabled by setting the relevant bit in
> the "clock stop control" register to one, while others are disabled by
> setting their bit to zero. The driver already uses a flag per gate  to
> identify this behavior, but doesn't apply it in the clock is_enabled
> function.
> 
> Use the existing gate flag to correctly return whether or not a clock
> is enabled in the aspeed_clk_is_enabled function.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---

Applied to clk-fixes
