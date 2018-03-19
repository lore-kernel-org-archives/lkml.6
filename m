Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030827AbeCSUrM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935028AbeCSUqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:46:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0314621737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, patrice.chotard@st.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520845447-10279-1-git-send-email-patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@st.com>
References: <1520845447-10279-1-git-send-email-patrice.chotard@st.com>
Message-ID: <152149239740.242365.14969514277401903715@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND PATCH] clk: stm32: Add clk entry for SDMMC2 on stm32F769
Date: Mon, 19 Mar 2018 13:46:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrice.chotard@st.com (2018-03-12 02:04:07)
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> STM32F769 has 2 SDMMC port, add clock entry for the second one.
> 
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next
