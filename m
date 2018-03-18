Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeCRMva (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:51:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34584 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeCRMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:49:22 -0400
X-Google-Smtp-Source: AG47ELv/71YSCjsrvjilEGuunZo/HLvpuobs1xVvuMxEQf+8xhipP/ELCUVTalnvwkRZ3D3GTbMVkg==
Date: Sun, 18 Mar 2018 07:49:19 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Add Mali node
Message-ID: <20180318000635.vy64qrzkmqkl7gbj@rob-hp-laptop>
References: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:16:45AM +0100, Giulio Benetti wrote:
> The H3 has an ARM Mali 400 GPU, so add binding to our DT.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  1 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    | 27 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
