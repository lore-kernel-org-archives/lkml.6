Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeEOUh7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeEOUh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:37:57 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
Message-ID: <152641667642.237094.1285725983406005947@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: stm32mp1: Fix a memory leak in
 'clk_stm32_register_gate_ops()'
Date: Tue, 15 May 2018 13:37:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FKc507021688

Quoting Christophe JAILLET (2018-05-13 04:17:04)
> We allocate some memory which is neither used, nor referenced by anything.
> So axe it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
