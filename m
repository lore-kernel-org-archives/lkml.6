Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCCKky (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 05:40:54 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:37486 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeCCKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 05:40:52 -0500
X-Google-Smtp-Source: AG47ELuAvNG1WZN1A/cAYBdmMEej3ea0jqO7B6JL6eF7nJU0wimTS6amMl7sQL48ZdG6JO1RpS/4tG1zRU+zcJL0C24=
MIME-Version: 1.0
In-Reply-To: <20180303103429.3063-1-jezz@sysmic.org>
References: <20180303103429.3063-1-jezz@sysmic.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 3 Mar 2018 11:40:50 +0100
Message-ID: <CAOf5uw=M8ew-j9XccOkviFZ-bLVDziBjWX2g1n_nF=vq0UM=Zg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl: Fix typo in Engicam i.CoreM6
 DualLite/Solo RQS
To: =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jezz@sysmic.org>
Cc: devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w23AexaV020243

Hi

On Sat, Mar 3, 2018 at 11:34 AM, Jérôme Pouiller <jezz@sysmic.org> wrote:
> Obviously "Engicam i.CoreM6 DualLite/Solo RQS" include an imx6dl, not
> an imx6q.
>
> Signed-off-by: Jérôme Pouiller <jezz@sysmic.org>
> ---
>  arch/arm/boot/dts/imx6dl-icore-rqs.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
> index cf42c2f5cdc7..1281bc39b7ab 100644
> --- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
> +++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
> @@ -42,7 +42,7 @@
>

Already fixed and queued

Michael

>  /dts-v1/;
>
> -#include "imx6q.dtsi"
> +#include "imx6dl.dtsi"
>  #include "imx6qdl-icore-rqs.dtsi"
>
>  / {
> --
> 2.11.0
>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
