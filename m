Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbeCGU3K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:29:10 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39364 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeCGU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:29:08 -0500
X-Google-Smtp-Source: AG47ELun0QwRvHPOShDAXLfwgh47Bjju7+CzWEa2CI+j1mJaU1GqlJCCYH3MsVj2NeuvYtciWiXB9w==
Date: Wed, 7 Mar 2018 14:29:06 -0600
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
Message-ID: <20180307202906.nn2y47f3yzply35s@rob-hp-laptop>
References: <1520002585-13113-1-git-send-email-amelie.delaunay@st.com>
 <1520002585-13113-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520002585-13113-2-git-send-email-amelie.delaunay@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:56:24PM +0100, Amelie Delaunay wrote:
> This patch adds the device tree bindings description for STM32 USBPHYC
> (USB PHY Controller).
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
