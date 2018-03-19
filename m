Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032273AbeCSUpp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032133AbeCSUpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:45:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EBA21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
Cc: devicetree@vger.kernel.org,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, olivier.bideau@st.com,
        linux-kernel@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
 <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152149233843.242365.271342087460300826@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND 1/2] clk: stm32: END_PRIMARY_CLK should be declare after
 CLK_SYSCLK
Date: Mon, 19 Mar 2018 13:45:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2018-03-08 22:57:30)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Update of END_PRIMARY_CLK was missed, it should be after CLK_SYSCLK
> hsi and sysclk are overwritten by gpioa and gpiob.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Tested-by: Philippe Cornu <philippe.cornu@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
