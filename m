Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeCTRDp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCTRDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:03:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21D5217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-4-git-send-email-david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-4-git-send-email-david@lechnology.com>
Message-ID: <152156541915.183971.14091978105809098516@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 03/42] clk: davinci: Add platform information for TI DA830 PLL
Date: Tue, 20 Mar 2018 10:03:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:19)
> This adds platform-specific declarations for the PLL clocks on TI DA830/
> OMAP-L137/AM17XX SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
