Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCIRan (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:30:43 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42815 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCIRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:30:40 -0500
X-Google-Smtp-Source: AG47ELt8HSBisAZeyLo4ow3Xhh8gV3YQalVjoTDfOWkRjokwHNhtltAAUIWAdLzV7AMOdZ/gAJjMlg==
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car V3M
 Eagle
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
 <1520603500-15218-4-git-send-email-jacopo+renesas@jmondi.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e0ff40be-f134-5a86-6d00-9506d9829364@cogentembedded.com>
Date: Fri, 9 Mar 2018 20:30:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1520603500-15218-4-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 04:51 PM, Jacopo Mondi wrote:

> The R-Car V3M Eagle board includes a transparent LVDS decoder, connected
> to the on-chip LVDS encoder output on one side and to HDMI encoder
> ADV7511w on the other one.
> 
> As the decoder does not need any configuration it has been so-far
> omitted from DTS. Now that a driver for transparent LVDS decoder is
> available, describe it in DT as well.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 31 ++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> index c0fd144..0a95c20 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -42,6 +42,33 @@
>  			};
>  		};
>  	};
> +
> +	lvds,decoder {

   I said hyphen (-), not comma (,)! :-)

[...]

MBR, Sergei
