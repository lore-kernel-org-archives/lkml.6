Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeBEGLu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:11:50 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45220 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeBEGJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:19 -0500
X-Google-Smtp-Source: AH8x22460mPpXRvVHKTN7UHyHlOv5vBZ1rI8mbZlQKKnDgrM1xkCOcnFUrdn4TdqW8skzFWOahrcNw==
Date: Mon, 5 Feb 2018 00:09:16 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm-stm32-lp: add #pwm-cells
Message-ID: <20180205060916.4djyij3ximpwsfag@rob-hp-laptop>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
 <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:44:36PM +0100, Fabrice Gasnier wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> STM32 Low-Power Timer supports generic 3 cells pwm to encode
> PWM number, period and polarity.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
