Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFBGXo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFBGXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:23:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Message-ID: <152792061833.225090.599214934282467838@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/6] clk: ingenic: Add support for clocks whose gate bit is
 inverted
Date: Fri, 01 Jun 2018 23:23:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526NnPp003975

Quoting Paul Cercueil (2018-05-20 09:31:12)
> Support the clocks which are gated when their gate bit is cleared
> instead of set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
