Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeFATTl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeFATTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:19:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Lei YU <mine260309@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
In-Reply-To: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
Message-ID: <152788077869.225090.2191512799899111487@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] clk: aspeed: Add 24MHz fixed clock
Date: Fri, 01 Jun 2018 12:19:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JL8db027188

Quoting Lei YU (2018-05-18 01:57:02)
> Add a 24MHz fixed clock.
> This clock will be used for certain devices, e.g. pwm.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---

Applied to clk-next
