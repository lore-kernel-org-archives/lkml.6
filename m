Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCRMuS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:50:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43974 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754270AbeCRMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:49:54 -0400
X-Google-Smtp-Source: AG47ELtHmLqv9rMT8XbcuHTlC248bSN98y2I3tZkxy5837eOLM9cv+0Dbajv4oThn479SEIEEsDc1w==
Date: Sun, 18 Mar 2018 07:49:51 -0500
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gabriel.fernandez.st@gmail.com,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: add STM32MP1 resets
Message-ID: <20180318124951.4ayn7iadpmube5f7@rob-hp-laptop>
References: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
 <1521045001-30788-2-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521045001-30788-2-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:30:00PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the reset binding entry for STM32MP1
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 ++
>  include/dt-bindings/reset/stm32mp1-resets.h        | 108 +++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
>  create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

Reviewed-by: Rob Herring <robh@kernel.org>
