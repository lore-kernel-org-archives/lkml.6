Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDFUpA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeDFUop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:44:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3643F20CAA
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
In-Reply-To: <1522996773-24129-7-git-send-email-gabriel.fernandez@st.com>
Cc: devicetree@vger.kernel.org,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, olivier.bideau@st.com,
        linux-kernel@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
 <1522996773-24129-7-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152304748362.94378.13779011954440917162@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/6] clk: stm32mp1: remove ck_apb_dbg clock
Date: Fri, 06 Apr 2018 13:44:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2018-04-05 23:39:33)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> It's recommended to use only clk_sys_dbg clock instead to activate
> debug IP.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
