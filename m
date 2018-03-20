Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeCTRI2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeCTRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:03:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7090217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-3-git-send-email-david@lechnology.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-3-git-send-email-david@lechnology.com>
Message-ID: <152156541626.183971.14116213325024297115@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 02/42] clk: davinci: New driver for davinci PLL clocks
Date: Tue, 20 Mar 2018 10:03:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:18)
> This adds a new driver for mach-davinci PLL clocks. This is porting the
> code from arch/arm/mach-davinci/clock.c to the common clock framework.
> Additionally, it adds device tree support for these clocks.
> 
> The ifeq ($(CONFIG_COMMON_CLK), y) in the Makefile is needed to prevent
> compile errors until the clock code in arch/arm/mach-davinci is removed.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the register
> layouts are a bit different, which would add even more if/else mess
> to the keystone clocks. And the keystone PLL driver doesn't support
> setting clock rates.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
