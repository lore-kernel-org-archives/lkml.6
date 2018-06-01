Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeFATqj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:46:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753185AbeFATqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:46:36 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180524052341.12422-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <20180524052341.12422-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <152788239546.225090.5366434047539311619@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mvebu: use correct bit for 98DX3236 NAND
Date: Fri, 01 Jun 2018 12:46:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JkghR027325

Quoting Chris Packham (2018-05-23 22:23:41)
> The correct fieldbit value for the NAND PLL reload trigger is 27.
> 
> Fixes: commit e120c17a70e5 ("clk: mvebu: support for 98DX3236 SoC")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Applied to clk-next
