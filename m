Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeBRXWS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:22:18 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41053 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeBRXWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:22:16 -0500
X-Google-Smtp-Source: AH8x226oAzqqCiUwKtCYVVfiMoqVCLzBOCMgafHWlfuZ8cxU2jkqCrgY0ICLnXl++IIMkcCvgOV6vA==
Date: Sun, 18 Feb 2018 17:22:14 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] dt-bindings/display/panel: Add support for
 Raydium rm68200 dsi panel
Message-ID: <20180218232214.xxjgw3yszfntwf2q@rob-hp-laptop>
References: <20180208143026.23009-1-philippe.cornu@st.com>
 <20180208143026.23009-2-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208143026.23009-2-philippe.cornu@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 03:30:25PM +0100, Philippe Cornu wrote:
> The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
> TFT LCD panel connected using a MIPI-DSI video interface.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  .../bindings/display/panel/raydium,rm68200.txt     | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt

Reviewed-by: Rob Herring <robh@kernel.org>
