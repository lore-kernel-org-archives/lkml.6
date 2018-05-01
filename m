Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeEAWKF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeEAWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:10:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, olivier.bideau@st.com,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
References: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152521260300.138124.15551649788620481848@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
Date: Tue, 01 May 2018 15:10:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2018-04-24 00:58:43)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Don't disable the dbg clock if was set by bootloader.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Is this a critical fix for this merge window? Please add "Fixes:" tag.
