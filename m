Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeDZIrr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:47:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50610 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeDZIrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:47:41 -0400
X-Google-Smtp-Source: AIpwx48tJm1hiAcbRS/Ksvc8gHM0w/DEJxVEY7pQ22a6KzNNq2LSUC6vS1hqH5+b51mwW4XqqPH3Qg==
Subject: Re: [PATCH 4/7] clk: meson: add axg audio sclk divider driver
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-5-jbrunet@baylibre.com>
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
Message-ID: <d0435ffb-1101-6f1b-b2de-1dc74f6a9543@baylibre.com>
Date: Thu, 26 Apr 2018 10:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425163304.10852-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 18:33, Jerome Brunet wrote:
> Add a driver to control the clock divider found in the sample clock
> generator of the axg audio clock controller.
> 
> The sclk divider accumulates specific features which make the generic
> divider unsuitable to control it:
> - zero based divider (div = val + 1), but zero value gates the clock,
>   so minimum divider value is 2.
> - lrclk variant may adjust the duty cycle depending the divider value
>   and the 'hi' value.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Makefile     |   2 +-
>  drivers/clk/meson/clkc-audio.h |   8 ++
>  drivers/clk/meson/sclk-div.c   | 243 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 252 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/sclk-div.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 64bb917fe1f0..f51b4754c31b 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
> index 286ff1201258..0a7c157ebf81 100644
> --- a/drivers/clk/meson/clkc-audio.h
> +++ b/drivers/clk/meson/clkc-audio.h
> @@ -15,6 +15,14 @@ struct meson_clk_triphase_data {
>  	struct parm ph2;
>  };
>  
> +struct meson_sclk_div_data {
> +	struct parm div;
> +	struct parm hi;
> +	unsigned int cached_div;
> +	struct clk_duty cached_duty;
> +};
> +
>  extern const struct clk_ops meson_clk_triphase_ops;
> +extern const struct clk_ops meson_sclk_div_ops;
>  
>  #endif /* __MESON_CLKC_AUDIO_H */
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> new file mode 100644
> index 000000000000..8c0bc914a6d7
> --- /dev/null
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Sample clock generator divider:
> + * This HW divider gates with value 0 but is otherwise a zero based divider:
> + *
> + * val >= 1
> + * divider = val + 1
> + *
> + * The duty cycle may also be set for the LR clock variant. The duty cycle
> + * ratio is:
> + *
> + * hi = [0 - val]
> + * duty_cycle = (1 + hi) / (1 + val)
> + */
> +
> +#include "clkc-audio.h"
> +
> +static inline struct meson_sclk_div_data *
> +meson_sclk_div_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_sclk_div_data *)clk->data;
> +}
> +
> +static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
> +{
> +	return (1 << sclk->div.width) - 1;
> +}
> +
> +static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
> +{
> +	return sclk_div_maxval(sclk) + 1;
> +}
> +
> +static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
> +			   unsigned long prate, int maxdiv)
> +{
> +	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
> +
> +	return clamp(div, 2, maxdiv);
> +}
> +
> +static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long *prate,
> +			    struct meson_sclk_div_data *sclk)
> +{
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	int bestdiv = 0, i;
> +	unsigned long maxdiv, now, parent_now;
> +	unsigned long best = 0, best_parent = 0;
> +
> +	if (!rate)
> +		rate = 1;
> +
> +	maxdiv = sclk_div_maxdiv(sclk);
> +
> +	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT))
> +		return sclk_div_getdiv(hw, rate, *prate, maxdiv);
> +
> +	/*
> +	 * The maximum divider we can use without overflowing
> +	 * unsigned long in rate * i below
> +	 */
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (i = 2; i <= maxdiv; i++) {
> +		/*
> +		 * It's the most ideal case if the requested rate can be
> +		 * divided from parent clock without needing to change
> +		 * parent rate, so return the divider immediately.
> +		 */
> +		if (rate * i == *prate)
> +			return i;
> +
> +		parent_now = clk_hw_round_rate(parent, rate * i);
> +		now = DIV_ROUND_UP_ULL((u64)parent_now, i);
> +
> +		if (abs(rate - now) < abs(rate - best)) {
> +			bestdiv = i;
> +			best = now;
> +			best_parent = parent_now;
> +		}
> +	}
> +
> +	if (!bestdiv)
> +		bestdiv = sclk_div_maxdiv(sclk);
> +	else
> +		*prate = best_parent;
> +
> +	return bestdiv;
> +}
> +
> +static long sclk_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *prate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	int div;
> +
> +	div = sclk_div_bestdiv(hw, rate, prate, sclk);
> +
> +	return DIV_ROUND_UP_ULL((u64)*prate, div);
> +}
> +
> +static void sclk_apply_ratio(struct clk_regmap *clk,
> +			     struct meson_sclk_div_data *sclk)
> +{
> +	unsigned int hi = DIV_ROUND_CLOSEST(sclk->cached_div *
> +					    sclk->cached_duty.num,
> +					    sclk->cached_duty.den);
> +
> +	if (hi)
> +		hi -= 1;
> +
> +	meson_parm_write(clk->map, &sclk->hi, hi);
> +}
> +
> +static int sclk_div_set_duty_cycle(struct clk_hw *hw,
> +				   struct clk_duty *duty)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +
> +	if (MESON_PARM_APPLICABLE(&sclk->hi)) {
> +		memcpy(&sclk->cached_duty, duty, sizeof(*duty));
> +		sclk_apply_ratio(clk, sclk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sclk_div_get_duty_cycle(struct clk_hw *hw,
> +				   struct clk_duty *duty)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	int hi;
> +
> +	if (!MESON_PARM_APPLICABLE(&sclk->hi)) {
> +		duty->num = 1;
> +		duty->den = 2;
> +		return 0;
> +	}
> +
> +	hi = meson_parm_read(clk->map, &sclk->hi);
> +	duty->num = hi + 1;
> +	duty->den = sclk->cached_div;
> +	return 0;
> +}
> +
> +static void sclk_apply_divider(struct clk_regmap *clk,
> +			       struct meson_sclk_div_data *sclk)
> +{
> +	if (MESON_PARM_APPLICABLE(&sclk->hi))
> +		sclk_apply_ratio(clk, sclk);
> +
> +	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
> +}
> +
> +static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long prate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	unsigned long maxdiv = sclk_div_maxdiv(sclk);
> +
> +	sclk->cached_div = sclk_div_getdiv(hw, rate, prate, maxdiv);
> +
> +	if (clk_hw_is_enabled(hw))
> +		sclk_apply_divider(clk, sclk);
> +
> +	return 0;
> +}
> +
> +static unsigned long sclk_div_recalc_rate(struct clk_hw *hw,
> +					  unsigned long prate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +
> +	return DIV_ROUND_UP_ULL((u64)prate, sclk->cached_div);
> +}
> +
> +static int sclk_div_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +
> +	sclk_apply_divider(clk, sclk);
> +
> +	return 0;
> +}
> +
> +static void sclk_div_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +
> +	meson_parm_write(clk->map, &sclk->div, 0);
> +}
> +
> +static int sclk_div_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +
> +	if (meson_parm_read(clk->map, &sclk->div))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void sclk_div_init(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	unsigned int val;
> +
> +	val = meson_parm_read(clk->map, &sclk->div);
> +
> +	/* if the divider is initially disabled, assume max */
> +	if (!val)
> +		sclk->cached_div = sclk_div_maxdiv(sclk);
> +	else
> +		sclk->cached_div = val + 1;
> +
> +	sclk_div_get_duty_cycle(hw, &sclk->cached_duty);
> +}
> +
> +const struct clk_ops meson_sclk_div_ops = {
> +	.recalc_rate	= sclk_div_recalc_rate,
> +	.round_rate	= sclk_div_round_rate,
> +	.set_rate	= sclk_div_set_rate,
> +	.enable		= sclk_div_enable,
> +	.disable	= sclk_div_disable,
> +	.is_enabled	= sclk_div_is_enabled,
> +	.get_duty_cycle	= sclk_div_get_duty_cycle,
> +	.set_duty_cycle = sclk_div_set_duty_cycle,
> +	.init		= sclk_div_init,
> +};
> +EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
