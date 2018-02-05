Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeBEGMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:12:22 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43117 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeBEGJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:15 -0500
X-Google-Smtp-Source: AH8x225a46yd2NFqozhFHrVhjxNAy8uinDzVf8f+YFW1V6Xlp2lBo1TS+D0VRNuAr1WwXoKprLiXcg==
Date: Mon, 5 Feb 2018 00:09:13 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: mediatek: add SCPSYS power domain driver for
 MediaTek MT7623A SoC
Message-ID: <20180205060913.ak62ammdposybdsf@rob-hp-laptop>
References: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
 <de07c071f968ae9da84543bb33cc5658ed184801.1517479588.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de07c071f968ae9da84543bb33cc5658ed184801.1517479588.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 06:12:48PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add SCPSYS power domain driver for MT7623A SoC. The MT7623A's power
> domains are the subset of MT7623 SoC's ones. As MT7623 SoC has full
> features whereas MT7623A is being designed just for router applications.
> Thus, MT7623A doesn't include those power domains multimedia function
> belongs to. In order to avoid certain errors undoubtedly happening at
> registering those power domains on MT7623A SoC using the existing MT7623
> SCPSYS driver, it's required to define another setup specifically for
> MT7623A SoC. Also, use a meaningful definition for bus_prot_mask instead
> of just hardcoded for it.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c         | 60 +++++++++++++++++++++++++++++--

>  include/dt-bindings/power/mt7623a-power.h | 10 ++++++

This belongs in the binding patch.

>  include/linux/soc/mediatek/infracfg.h     |  4 +++
>  3 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt7623a-power.h
> 
