Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeCFCiJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:38:09 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:45807 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeCFCiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:38:07 -0500
X-Google-Smtp-Source: AG47ELslYG61Dgw/p/tXIt7oaR1wngPQtjz8izykd/5efh+lTocOcV9NegWHgWqlXZinrAlm0hhBcQ==
Date: Mon, 5 Mar 2018 20:38:06 -0600
From: Rob Herring <robh@kernel.org>
To: patrice.chotard@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v2 5/6] dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
Message-ID: <20180306023806.rhmpp7lwftgb74un@rob-hp-laptop>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:53:42AM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> STM32F769 SoC provides 2 SDMMC instances, add missing
> RCC SDMMC2 entry for it.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>                                 
