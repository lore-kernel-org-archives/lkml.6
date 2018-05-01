Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755805AbeEAObT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:31:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41238 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbeEAObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:31:17 -0400
X-Google-Smtp-Source: AB8JxZqxNYXImTO/U2hsoZe92aEccMIQcW4alaCQo5buoM+/dnufmFIh+ONRbGZ1WI8RgqNNEAEhCg==
Date: Tue, 1 May 2018 09:31:15 -0500
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] clk: meson: axg: export audio clock controller id
 bindings
Message-ID: <20180501143115.GA17513@rob-hp-laptop>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-6-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425163304.10852-6-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 06:33:02PM +0200, Jerome Brunet wrote:
> export the clock ids dt-bindings usable by the consumers of the axg
> audio clock controller

Capitalization and punctuation would be nice.

> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/clock/axg-audio-clkc.h | 94 ++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h

This can be combined with the next patch. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
> new file mode 100644
> index 000000000000..4426ae655858
> --- /dev/null
> +++ b/include/dt-bindings/clock/axg-audio-clkc.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2018 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#ifndef __AXG_AUDIO_CLKC_BINDINGS_H
> +#define __AXG_AUDIO_CLKC_BINDINGS_H
> +
> +#define AUD_CLKID_SLV_SCLK0		9
> +#define AUD_CLKID_SLV_SCLK1		10
> +#define AUD_CLKID_SLV_SCLK2		11
> +#define AUD_CLKID_SLV_SCLK3		12
> +#define AUD_CLKID_SLV_SCLK4		13
> +#define AUD_CLKID_SLV_SCLK5		14
> +#define AUD_CLKID_SLV_SCLK6		15
> +#define AUD_CLKID_SLV_SCLK7		16
> +#define AUD_CLKID_SLV_SCLK8		17
> +#define AUD_CLKID_SLV_SCLK9		18
> +#define AUD_CLKID_SLV_LRCLK0		19
> +#define AUD_CLKID_SLV_LRCLK1		20
> +#define AUD_CLKID_SLV_LRCLK2		21
> +#define AUD_CLKID_SLV_LRCLK3		22
> +#define AUD_CLKID_SLV_LRCLK4		23
> +#define AUD_CLKID_SLV_LRCLK5		24
> +#define AUD_CLKID_SLV_LRCLK6		25
> +#define AUD_CLKID_SLV_LRCLK7		26
> +#define AUD_CLKID_SLV_LRCLK8		27
> +#define AUD_CLKID_SLV_LRCLK9		28
> +#define AUD_CLKID_DDR_ARB		29
> +#define AUD_CLKID_PDM			30
> +#define AUD_CLKID_TDMIN_A		31
> +#define AUD_CLKID_TDMIN_B		32
> +#define AUD_CLKID_TDMIN_C		33
> +#define AUD_CLKID_TDMIN_LB		34
> +#define AUD_CLKID_TDMOUT_A		35
> +#define AUD_CLKID_TDMOUT_B		36
> +#define AUD_CLKID_TDMOUT_C		37
> +#define AUD_CLKID_FRDDR_A		38
> +#define AUD_CLKID_FRDDR_B		39
> +#define AUD_CLKID_FRDDR_C		40
> +#define AUD_CLKID_TODDR_A		41
> +#define AUD_CLKID_TODDR_B		42
> +#define AUD_CLKID_TODDR_C		43
> +#define AUD_CLKID_LOOPBACK		44
> +#define AUD_CLKID_SPDIFIN		45
> +#define AUD_CLKID_SPDIFOUT		46
> +#define AUD_CLKID_RESAMPLE		47
> +#define AUD_CLKID_POWER_DETECT		48
> +#define AUD_CLKID_MST_A_MCLK		49
> +#define AUD_CLKID_MST_B_MCLK		50
> +#define AUD_CLKID_MST_C_MCLK		51
> +#define AUD_CLKID_MST_D_MCLK		52
> +#define AUD_CLKID_MST_E_MCLK		53
> +#define AUD_CLKID_MST_F_MCLK		54
> +#define AUD_CLKID_SPDIFOUT_CLK		55
> +#define AUD_CLKID_SPDIFIN_CLK		56
> +#define AUD_CLKID_PDM_DCLK		57
> +#define AUD_CLKID_PDM_SYSCLK		58
> +#define AUD_CLKID_MST_A_SCLK		79
> +#define AUD_CLKID_MST_B_SCLK		80
> +#define AUD_CLKID_MST_C_SCLK		81
> +#define AUD_CLKID_MST_D_SCLK		82
> +#define AUD_CLKID_MST_E_SCLK		83
> +#define AUD_CLKID_MST_F_SCLK		84
> +#define AUD_CLKID_MST_A_LRCLK		86
> +#define AUD_CLKID_MST_B_LRCLK		87
> +#define AUD_CLKID_MST_C_LRCLK		88
> +#define AUD_CLKID_MST_D_LRCLK		89
> +#define AUD_CLKID_MST_E_LRCLK		90
> +#define AUD_CLKID_MST_F_LRCLK		91
> +#define AUD_CLKID_TDMIN_A_SCLK_SEL	116
> +#define AUD_CLKID_TDMIN_B_SCLK_SEL	117
> +#define AUD_CLKID_TDMIN_C_SCLK_SEL	118
> +#define AUD_CLKID_TDMIN_LB_SCLK_SEL	119
> +#define AUD_CLKID_TDMOUT_A_SCLK_SEL	120
> +#define AUD_CLKID_TDMOUT_B_SCLK_SEL	121
> +#define AUD_CLKID_TDMOUT_C_SCLK_SEL	122
> +#define AUD_CLKID_TDMIN_A_SCLK		123
> +#define AUD_CLKID_TDMIN_B_SCLK		124
> +#define AUD_CLKID_TDMIN_C_SCLK		125
> +#define AUD_CLKID_TDMIN_LB_SCLK		126
> +#define AUD_CLKID_TDMOUT_A_SCLK		127
> +#define AUD_CLKID_TDMOUT_B_SCLK		128
> +#define AUD_CLKID_TDMOUT_C_SCLK		129
> +#define AUD_CLKID_TDMIN_A_LRCLK		130
> +#define AUD_CLKID_TDMIN_B_LRCLK		131
> +#define AUD_CLKID_TDMIN_C_LRCLK		132
> +#define AUD_CLKID_TDMIN_LB_LRCLK	133
> +#define AUD_CLKID_TDMOUT_A_LRCLK	134
> +#define AUD_CLKID_TDMOUT_B_LRCLK	135
> +#define AUD_CLKID_TDMOUT_C_LRCLK	136
> +
> +#endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
