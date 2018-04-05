Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDETLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:11:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43303 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeDETLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:11:40 -0400
X-Google-Smtp-Source: AIpwx49RnVfLayxFTqu/RNt2TMXtVrA/VRDbT23Osr6THmhljP0kifHCyvm+nWo5PtrUaWFp4FNDKA==
Date: Thu, 5 Apr 2018 21:11:37 +0200
From: Niklas Cassel <niklas.cassel@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2] ARM: dts: qcom: Add apq8064 Dragon Board 600c support
Message-ID: <20180405191137.GA17656@localhost.localdomain>
References: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:54:36PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add support to DB600c board, which is another
> 96boards based on Qualcomm APQ8064 SoC.
> 
> Support for USB, HDMI, PCIe, I2C, SPI, eMMC, microSD card, LEDs
> device tree nodes is added in this patch.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> 	- added chosen node with stdout, suggested by Stephen Boyd
> 	- removed spi flash node and gpio22 pinconf, as its not required in this patch.
> 	- removed extra comment lines and fix a node name, spotted by Stephen Boyd.
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/qcom-apq8064-db600c.dts | 530 ++++++++++++++++++++++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-db600c.dts

Hello Srini (I hope you had a nice vacation!)


Running checkpatch on this patch gives a few of these warnings:

WARNING: line over 80 characters

These can probably be ignored, since they exist for most
arch/arm/boot/dts/qcom-*.dts files.


However, it also gives a few of these errors:

ERROR: trailing whitespace

These should probably be fixed, since the are errors and not warnings.


Kind regards,
Niklas
