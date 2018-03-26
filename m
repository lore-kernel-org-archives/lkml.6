Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeCZWXc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:23:32 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:47033 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeCZWX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:23:29 -0400
X-Google-Smtp-Source: AIpwx4+zM6RTPSQiRbWmMSjJGoHYWsJHr+u9ytvjPJS6tCwmHD74AHnDMcHRUxDMoaa2vSJinYwHHA==
Date: Mon, 26 Mar 2018 17:23:27 -0500
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mark.rutland@arm.com, linux@armlinux.org.uk, shengjiu.wang@nxp.com,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx7d-pinfunc: update sai select input value
Message-ID: <20180326055217.bieahycbplgyashh@rob-hp-laptop>
References: <1521511720-17598-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521511720-17598-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:08:40AM +0800, Anson Huang wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Update SAI select input daisy chain value according to
> Reference Manual.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7d-pinfunc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
