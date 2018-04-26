Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeDZIqX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:46:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754819AbeDZIqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:46:15 -0400
X-Google-Smtp-Source: AB8JxZql0iVaozg8M2PK3M64oUIwojqkxvYHYxWC/aeWQ7OawP/J0BEH5OEv3QsXtjFA6/nRUTKzyQ==
Subject: Re: [PATCH 2/7] clk: meson: add clk-phase clock driver
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-3-jbrunet@baylibre.com>
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
Message-ID: <86b8e8f5-fb69-3249-fc1e-b4f2213284db@baylibre.com>
Date: Thu, 26 Apr 2018 10:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425163304.10852-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 18:32, Jerome Brunet wrote:
> Add a driver based meson clk-regmap to control clock phase on
> amlogic SoCs
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Makefile    |  1 +
>  drivers/clk/meson/clk-phase.c | 63 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/clkc.h      |  8 ++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 drivers/clk/meson/clk-phase.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index ffee82e60b7a..352fb848c406 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
> diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
> new file mode 100644
> index 000000000000..96e70497ef1b
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +#define phase_step(_width) (360 / (1 << (_width)))
> +
> +static inline struct meson_clk_phase_data *
> +meson_clk_phase_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_clk_phase_data *)clk->data;
> +}
> +
> +int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
> +{
> +	return phase_step(width) * val;
> +}
> +EXPORT_SYMBOL_GPL(meson_clk_degrees_from_val);
> +
> +unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
> +{
> +	unsigned int val = DIV_ROUND_CLOSEST(degrees, phase_step(width));
> +
> +	/*
> +	 * This last calculation is here for cases when degrees is rounded
> +	 * to 360, in which case val == (1 << width).
> +	 */
> +	return val % (1 << width);
> +}
> +EXPORT_SYMBOL_GPL(meson_clk_degrees_to_val);
> +
> +static int meson_clk_phase_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_data *phase = meson_clk_phase_data(clk);
> +	unsigned int val;
> +
> +	val = meson_parm_read(clk->map, &phase->ph);
> +
> +	return meson_clk_degrees_from_val(val, phase->ph.width);
> +}
> +
> +static int meson_clk_phase_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_data *phase = meson_clk_phase_data(clk);
> +	unsigned int val;
> +
> +	val = meson_clk_degrees_to_val(degrees, phase->ph.width);
> +	meson_parm_write(clk->map, &phase->ph, val);
> +
> +	return 0;
> +}
> +
> +const struct clk_ops meson_clk_phase_ops = {
> +	.get_phase	= meson_clk_phase_get_phase,
> +	.set_phase	= meson_clk_phase_set_phase,
> +};
> +EXPORT_SYMBOL_GPL(meson_clk_phase_ops);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 8fe73c4edca8..9a17d6705e0a 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -104,6 +104,13 @@ struct meson_clk_audio_div_data {
>  	u8 flags;
>  };
>  
> +struct meson_clk_phase_data {
> +	struct parm ph;
> +};
> +
> +int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
> +unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
> +
>  #define MESON_GATE(_name, _reg, _bit)					\
>  struct clk_regmap _name = {						\
>  	.data = &(struct clk_regmap_gate_data){				\
> @@ -127,5 +134,6 @@ extern const struct clk_ops meson_clk_mpll_ro_ops;
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_audio_divider_ro_ops;
>  extern const struct clk_ops meson_clk_audio_divider_ops;
> +extern const struct clk_ops meson_clk_phase_ops;
>  
>  #endif /* __CLKC_H */
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
