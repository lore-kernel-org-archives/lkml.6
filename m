Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeEECz2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeEECz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:55:27 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Stefan Agner <stefan@agner.ch>, kernel@pengutronix.de,
        shawnguo@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180418125254.4397-1-stefan@agner.ch>
Cc: fabio.estevam@nxp.com, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
References: <20180418125254.4397-1-stefan@agner.ch>
Message-ID: <152548892600.138124.3143140012763491118@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6ul: fix periph clk2 clock mux selection
Date: Fri, 04 May 2018 19:55:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w452tX2a003021

Quoting Stefan Agner (2018-04-18 05:52:54)
> According to the data sheet the 3rd choice is the bypass clock
> of pll2. This should not have any effect in practice as this
> selection is not used currently.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Applied to clk-next
