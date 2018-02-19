Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeBSC5b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:57:31 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40796 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeBSC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:57:29 -0500
X-Google-Smtp-Source: AH8x226ihz2S2Tg+jnBTFOs0rsG+iO3fUqDTciExJwnW066QhYU4XuddM67TRH7wI7m5M4tBe3OdWg==
Date: Sun, 18 Feb 2018 20:57:27 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] pinctrl: sh-pfc: Initial R-Car M3-N support
Message-ID: <20180219025727.6yexb4iqmvlt2luq@rob-hp-laptop>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45:51AM +0100, Jacopo Mondi wrote:
> Add initial PFC support for R-Car M3-N (r8a77965) SoC.
> No groups or functions defined, just pin and registers enumeration.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
>  drivers/pinctrl/sh-pfc/Makefile                    |    1 +
>  drivers/pinctrl/sh-pfc/core.c                      |    6 +
>  drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 2728 ++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
>  6 files changed, 2742 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77965.c
