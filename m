Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971546AbeCSUuP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968764AbeCSUt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:49:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC00921737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180312093248.27512-1-benjamin.gaignard@st.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180312093248.27512-1-benjamin.gaignard@st.com>
Message-ID: <152149259615.242365.15902281411022279273@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3] clk: stm32: add configuration flags for each of the stm32
 drivers
Date: Mon, 19 Mar 2018 13:49:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Benjamin Gaignard (2018-03-12 02:32:48)
> Add two configuration flags to be able to not compile all the time
> stm32f and stm32h7 drivers when ARCH_STM32 is set.
> That help to save some space on those small platforms.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
