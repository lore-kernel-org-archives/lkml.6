Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDZIsx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:48:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38933 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754376AbeDZIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:48:47 -0400
X-Google-Smtp-Source: AIpwx4/A9Pgv+5babqadfanF4TvttBOaXdZJRljqRo5qL9oPUyIzkkauMubUCiAQWgzg4B1k+c/xYQ==
Subject: Re: [PATCH 5/7] clk: meson: axg: export audio clock controller id
 bindings
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-6-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <5a842562-eb68-334c-5c77-d785bd0178d0@baylibre.com>
Date: Thu, 26 Apr 2018 10:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425163304.10852-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 18:33, Jerome Brunet wrote:
> export the clock ids dt-bindings usable by the consumers of the axg
> audio clock controller
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/clock/axg-audio-clkc.h | 94 ++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
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
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
