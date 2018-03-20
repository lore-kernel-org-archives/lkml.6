Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeCTREJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeCTREA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:04:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A88B2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-11-git-send-email-david@lechnology.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-11-git-send-email-david@lechnology.com>
Message-ID: <152156543978.183971.1705082607591158848@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 10/42] clk: davinci: New driver for davinci PSC clocks
Date: Tue, 20 Mar 2018 10:03:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:26)
> This adds a new driver for mach-davinci PSC clocks. This is porting the
> code from arch/arm/mach-davinci/psc.c to the common clock framework and
> is converting it to use regmap to simplify the code. Additionally, it
> adds device tree support for these clocks.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the keystone
> driver makes the assumption that there is only one PSC per SoC and uses
> global variables, but here we have two controllers per SoC.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
