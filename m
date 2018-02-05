Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeBEGK2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:10:28 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35442 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeBEGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:35 -0500
X-Google-Smtp-Source: AH8x2275stHMQCkJW0iz0s/VIbFItABjrr7obJna0dwb9nhzWwj872OKrXkeuHw7QbU5AUfhlC00VA==
Date: Mon, 5 Feb 2018 00:09:33 -0600
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        olivier.bideau@st.com
Subject: Re: [PATCH 02/14] dt-bindings: clock: add STM32MP1 clocks
Message-ID: <20180205042348.2f7ssmzkajeky5l7@rob-hp-laptop>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-3-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517580222-23301-3-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:03:30PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the clock binding entry for STM32MP1
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  include/dt-bindings/clock/stm32mp1-clks.h | 248 ++++++++++++++++++++++++++++++
>  1 file changed, 248 insertions(+)
>  create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

You can squash this into the previous patch.
