Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeCTRGj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeCTREE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:04:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C7C2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-12-git-send-email-david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-12-git-send-email-david@lechnology.com>
Message-ID: <152156544258.183971.6940417090158656198@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 11/42] clk: davinci: Add platform information for TI DA830 PSC
Date: Tue, 20 Mar 2018 10:04:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:27)
> This adds platform-specific declarations for the PSC clocks on TI DA830/
> OMAP-L137/AM17XX SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
