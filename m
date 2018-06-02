Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeFBGYB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbeFBGX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:23:56 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180520163117.14125-6-paul@crapouillou.net>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
 <20180520163117.14125-6-paul@crapouillou.net>
Message-ID: <152792063369.225090.12451260873752761253@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/6] clk: ingenic: jz4770: Add 150us delay after enabling VPU
 clock
Date: Fri, 01 Jun 2018 23:23:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526O68M003988

Quoting Paul Cercueil (2018-05-20 09:31:17)
> This is required, as we must not use the AHB1 bus before it is stable.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
