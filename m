Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEOVQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbeEOVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:16:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180515021416.31760-1-suzuki.katsuhiro@socionext.com>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
References: <20180515021416.31760-1-suzuki.katsuhiro@socionext.com>
Message-ID: <152641900347.237094.18265233819644553080@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND] clk: uniphier: add LD11/LD20 stream demux system clock
Date: Tue, 15 May 2018 14:16:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLGrxn025339

Quoting Katsuhiro Suzuki (2018-05-14 19:14:16)
> Add clock for MPEG2 transport stream I/O and demux system (HSC) on
> UniPhier LD11/LD20 SoCs.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next
