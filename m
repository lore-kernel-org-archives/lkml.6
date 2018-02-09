Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBICqf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:46:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42935 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBICqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:46:34 -0500
X-Google-Smtp-Source: AH8x227jl6TosucjnCOvYcHfcJifz8kokVmj/07np0Nul48D9s+GCXeljN52eXi4nqplp6UwqGaMxw==
Date: Thu, 8 Feb 2018 20:46:31 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        mihai.serban@gmail.com, cosmin.samoila@nxp.com, linux-imx@nxp.com,
        fabio.estevam@nxp.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Message-ID: <20180209024631.u24yyesvdleakull@rob-hp-laptop>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
 <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 07:01:55PM +0200, Daniel Baluta wrote:
> Document the bindings for AK5558 ADC.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

Reviewed-by: Rob Herring <robh@kernel.org>
