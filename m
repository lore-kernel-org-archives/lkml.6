Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeCONif (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:38:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37770 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeCONib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:38:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180315133829euoutp02ed5c08d358429649c6ae64653d9953ab~cG5ccYGo01333013330euoutp02K
X-AuditID: cbfec7f2-1dbff70000011644-9c-5aaa7753371f
Subject: Re: [PATCH v4 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car
 V3M Eagle
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <186a9adc-f5b8-cbd9-218c-5a0c48dbc9aa@samsung.com>
Date: Thu, 15 Mar 2018 14:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521111391-3515-4-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf73kvnvw6rN9izIkwlcz4bZKX2fW0tWazYfcHjp5V9LZ7elEZ
        p0ZXZGRJ56UYw51kx+UlMYnbLR29oMIuFqU5rXJIebmnh+m/z8v3+/19PtuPI1U/6EAuMSVd
        1KfoktSML1XzePhpyPoss3bRq4IJuNjpIHCe0U3jigYnjds8/Qz+0FlH4HybB2D7SBWLC4+e
        Z3HrnVMMtn38TOAui5vBF142E9h+/DCN99c1sPiJuZNdNUm4cuYKEFoPFxNCV+lvQrhtesMK
        J43ltPC7/R0pWM2FjFD/0AiEm1+7aMF10E4IPa3fGOHU8FdKGLLOWMdrfSPixKTETFEfFrnV
        N2HkXA9Ic/vtaqm2sAZgmFAEfDgEl6BK1z2iCPhyKngJIOPrcqCQLwB92l/DKmTIS9pL6H8r
        HTW9pGJcBMhle0vJhgq6Aap8MVfGk+EG9PN6z9j2FFhFIEf/d0omJMwDqMWRT8pTDJzvnepg
        igDH8TASDVvWyjIF56CPg1fHjk6Fm9DZ0vdAxjz0R47y7jHdB0YjS62LkDEJZ6J820lSwQGo
        s7tirBCClzlkHypgldhrkdN1gFLwZNRnv/FXn44ajx36q+eijt48Slk2equNFDCKsRw9tDfT
        clDSG7r6TpgMEVyBCqslBfqhdre/EsEPldSUkYrMI+MBlXJjFnI12UgFB6ALzzzMETDbNK6Y
        aVwZ07gypv/PVgLKDALEDCk5XpTCU8SsUEmXLGWkxIduT022Au+PbPxlH7wFPC3b6gHkgHoi
        3z77slZF6zKl7OR6gDhSPYWPSTNrVXycLjtH1Kdu0WckiVI9mMZR6gB+87w9WhWM16WLO0Ux
        TdT/cwnOJ9AAgoTF1KqgmNim5o3Ze6MbV4YNVWmCqfQc98/T0bVRK42rt2uW3c9cvlCDQWJR
        tfNBqbMhotx5UMU7onZYK65V2J8PPgrpKuFnta2wVp7YZ7l1l8vVFP/idAbD7uCWNZq086NB
        fbHZO8iB0Ni6AXWsORJ/lpY2jT6KYXeVeQpH1JSUoAtfQOol3R+dIHnsjQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd3A8lVRBu07WC16z51ksmjqeMtq
        Mf/IOVaLK1/fs1k8u7WXyaJ561dGi+O/17JbdE5cwm5xedccNoutL98xWTxY/ZbNYun1i0wW
        x6f1sVq07j3CbnFm1S12B36PNfPWMHpc7utl8ngw9T+Tx85Zd9k9ZnfMZPX4f+MRs8emVZ1s
        HocOdzB6bP/2gNXjfvdxJo/nl7+zecz5+Y3F4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M34ueMxa85au4tH41ewNjA3cXIyeHhICJ
        xM1tL5i7GLk4hASWMkrsmL+DCSIhLrF7/ltmCFtY4s+1LjaIoteMEktnHgUrEhYIkzh6/SZY
        t4jAWiaJJ0cWgDnMAk2MEhNmf2KCaLnNKHFm/xawWWwCmhJ/N98EmsXBwStgJ/FztQtImEVA
        VeLlp3UsILaoQIRE58r5YDavgKDEyZlPwGxOAU+J1bvvg21mFlCX+DPvEjOELS/RvHU2lC0u
        cevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQmhm3H
        fm7ewXhpY/AhRgEORiUe3hvKK6OEWBPLiitzDzFKcDArifD6FKyKEuJNSaysSi3Kjy8qzUkt
        PsRoCvTcRGYp0eR8YNLKK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TB
        KdXA2OT9dIGWakdO+/EfdsyPFs+YkZclb7NU5JxhtfHPn+oMrI2XZvvq1zh7nP1XY5eslByv
        dKFX/vjTpxKOl6/cYD57ZlLBrb5/btKW1zgfMu2WzDvo2/Ah6Yhr9eeUWevPBHx7EFG++avV
        xmpH5RAjp6t6OnPfcYuovmZgXvv1oPnG9GlCa088V2Ipzkg01GIuKk4EAJJoQQwiAwAA
X-CMS-MailID: 20180315133826eucas1p24179f1dc7b18f7dccdeef399a8d34d22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180315133826eucas1p24179f1dc7b18f7dccdeef399a8d34d22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180315112823epcas5p3e8d475cddae340ce0625267f30d4b06a
X-RootMTR: 20180315112823epcas5p3e8d475cddae340ce0625267f30d4b06a
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180315112823epcas5p3e8d475cddae340ce0625267f30d4b06a@epcas5p3.samsung.com>
        <1521111391-3515-4-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 11:56, Jacopo Mondi wrote:
> The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
> decoder, connected to the on-chip LVDS encoder output on one side
> and to HDMI encoder ADV7511w on the other one.
>
> As the decoder does not need any configuration it has been so-far
> omitted from DTS. Now that a driver is available, describe it in DT
> as well.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 33 +++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> index c0fd144..69f43b8 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -42,6 +42,33 @@
>  			};
>  		};
>  	};
> +
> +	thc63lvd1024: lvds-decoder {
> +		compatible = "thine,thc63lvd1024";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				thc63lvd1024_in_0: endpoint {
> +					remote-endpoint = <&lvds0_out>;
> +				};
> +			};
> +
> +			port@2{
> +				reg = <2>;
> +
> +				thc63lvd1024_out_2: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +
> +			};
> +
> +		};
> +	};
>  };
>  
>  &avb {
> @@ -98,7 +125,7 @@
>  			port@0 {
>  				reg = <0>;
>  				adv7511_in: endpoint {
> -					remote-endpoint = <&lvds0_out>;
> +					remote-endpoint = <&thc63lvd1024_out_2>;
>  				};
>  			};
>  
> @@ -152,8 +179,8 @@
>  
>  	ports {
>  		port@1 {
> -			endpoint {
> -				remote-endpoint = <&adv7511_in>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&thc63lvd1024_in_0>;
>  			};
>  		};
>  	};
