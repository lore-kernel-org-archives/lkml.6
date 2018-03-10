Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933690AbeCJAlr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932906AbeCJAlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:41:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B9220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        eajames@linux.vnet.ibm.com, mine260309@gmail.com,
        ryan_chen@aspeedtech.com
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <152064250369.205167.5918389143946901453@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/2] clk: aspeed: Fix is_enabled and prevent reset if clock
 enabled
Date: Fri, 09 Mar 2018 16:41:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2018-03-08 12:57:18)
> Here are two fixes for the Aspeed clock driver. The first fixes the is_enabled
> clock function to account for different clock gates getting disabled with
> either 0s or 1s. The second patch addresses some issue found with the LPC
> controller clock if it gets reset while the clock is enabled, which it is by
> default. Thanks to Lei Yu for tracking down the LPC issue.
> 

Can you please add some "Fixes:" tags to these patches? Or just indicate
the tags and I can pick them up. If it doesn't happen, I'll just apply
these early next week.
