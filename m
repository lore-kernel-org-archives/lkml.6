Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeEPH6I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbeEPH6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:58:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Gabriel Fernandez <gabriel.fernandez@st.com>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152645748426.210890.16830780218653883415@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Date: Wed, 16 May 2018 00:58:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G7wCK8017501

Quoting gabriel.fernandez@st.com (2018-05-02 23:40:09)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Clock driver is mandatory if the machine is selected.
> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
> with the machine(s).
> 
> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> ---

Applied to clk-fixes
