Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755786AbeEaQtw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:49:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33619 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755595AbeEaQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:49:48 -0400
X-Google-Smtp-Source: ADUXVKJmJA9oOIV6rfF5+TJvox0+IU5n+iUbmN+z2q74oEIRY8NthlODQgWf9XTaZBJlHyxbEPCDpw==
Subject: Re: [PATCH v2 2/3] USB: DT probing support to ehci-npcm7xx
To: avifishman70@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc: tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, mathias.nyman@linux.intel.com,
        bjorn.andersson@linaro.org, jhogan@kernel.org, albeu@free.fr,
        chunfeng.yun@mediatek.com, tony@atomide.com, baolu.lu@linux.intel.com,
        elder@linaro.org, digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
References: <1527774046-7952-1-git-send-email-avifishman70@gmail.com>
 <1527774046-7952-3-git-send-email-avifishman70@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9fe0ca4a-c244-e909-ec27-07c3db89f941@cogentembedded.com>
Date: Thu, 31 May 2018 19:49:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1527774046-7952-3-git-send-email-avifishman70@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05/31/2018 04:40 PM, avifishman70@gmail.com wrote:

> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Device Tree documentation for Nuvoton npcm7xx EHCI.
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> new file mode 100644
> index 000000000000..dec67d4d4c30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
> @@ -0,0 +1,17 @@
> +Nuvoton NPCM7XX SoC USB controllers:
> +-----------------------------
> +
> +EHCI:
> +-----
> +
> +Required properties:
> +- compatible: "nuvoton,npcm750-ehci"
> +- interrupts: Should contain the EHCI interrupt
> +
> +Example:
> +
> +	ehci@e1800000 {

  The node should be named "usb@e1800000" as the DT spec. requires the generic
node names.

[...]

MBR, Sergei
