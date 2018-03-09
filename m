Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCIXyH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:54:07 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:37787 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCIXyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:54:05 -0500
X-Google-Smtp-Source: AG47ELsoj1PUnf/MNDBgG7M+Uz8kElh91Pbv3b3A2P4abot1STDo7IsyLExJTNOvb4A0kIH9p28kzQ==
Date: Fri, 9 Mar 2018 17:53:56 -0600
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: sboyd@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        olivier.bideau@st.com, Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Message-ID: <20180309235356.qd2wx6teeuxkwwjz@rob-hp-laptop>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520528045-18330-2-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:53:54PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> The RCC block is responsible of the management of the clock and reset
> generation for the complete circuit.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
