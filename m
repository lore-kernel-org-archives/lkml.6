Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeCFBbV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 20:31:21 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39857 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCFBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 20:31:19 -0500
X-Google-Smtp-Source: AG47ELsXylBRunn8okItTvXrhazlj2aLFZkWgaGyhbx6Le+5q45Vp1v5FpxP5uGn3N95BLmTMxjLnQ==
Date: Mon, 5 Mar 2018 19:31:17 -0600
From: Rob Herring <robh@kernel.org>
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V2 1/5] dt-bindings: mmc: document the stm32 sdmmc
 bindings
Message-ID: <20180306013117.lemo4fvugmrd3ji2@rob-hp-laptop>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
 <1519832844-28068-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519832844-28068-2-git-send-email-ludovic.Barre@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 04:47:20PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> Document the binding for stm32 sdmmc controller.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
