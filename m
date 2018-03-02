Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425650AbeCBJWp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:22:45 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36899 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425128AbeCBJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:21:51 -0500
X-Google-Smtp-Source: AG47ELudPKIIolaIj0lS8GhNFHqeoZSOSIgtriOEvVp+Z4JIYD1eqWROGL5fl+D1fenQ2HUiaZY2cA==
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: net: Add bindings for National
 Instruments XGE netdev
To: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net
References: <20180301191547.2816-1-mdf@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d776cc09-5374-d92c-0e95-62ca4afd30ad@cogentembedded.com>
Date: Fri, 2 Mar 2018 12:21:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301191547.2816-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2018 10:15 PM, Moritz Fischer wrote:

> This adds bindings for the NI XGE 1G/10G network device.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes from v3:
> - Added Rob's Reviewed-by
> 
> Changes from v2:
> - Addressed Rob's comments w.r.t to IRQ names and typo
> 
> Changes from v1:
> - Corrected from nixge -> nixge.txt
> ---
>   Documentation/devicetree/bindings/net/nixge.txt | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/nixge.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
> new file mode 100644
> index 000000000000..e55af7f0881a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nixge.txt
> @@ -0,0 +1,32 @@
> +* NI XGE Ethernet controller
> +
> +Required properties:
> +- compatible: Should be "ni,xge-enet-2.00"
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain tx and rx interrupt

     Maybe rx and tx, looking below:

> +- interrupt-names: Should be "rx" and "tx"
> +- phy-mode: See ethernet.txt file in the same directory.
> +- phy-handle: See ethernet.txt file in the same directory.
> +- nvmem-cells: Phandle of nvmem cell containing the MAC address
> +- nvmem-cell-names: Should be "address"
[...]

MBR, Sergei
