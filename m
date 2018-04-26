Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeDZIvG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:51:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35135 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeDZIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:51:02 -0400
X-Google-Smtp-Source: AIpwx4+CzPPuqeoMRLz6phjm/bnsycXn/weML2yb7p0YmvhO/YVZWRLuNT9bmcBVgppfPUBE2hEKag==
Subject: Re: [PATCH 3/7] clk: meson: add triple phase clock driver
From: Neil Armstrong <narmstrong@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-4-jbrunet@baylibre.com>
 <bc770c22-f0b9-ed1f-bba7-631b9cd42436@baylibre.com>
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
Message-ID: <1696abba-abc2-ebbb-0d57-9fe252411b4a@baylibre.com>
Date: Thu, 26 Apr 2018 10:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bc770c22-f0b9-ed1f-bba7-631b9cd42436@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2018 10:47, Neil Armstrong wrote:
> On 25/04/2018 18:33, Jerome Brunet wrote:
>> Add a driver to control the output of the sample clock generator found
>> in the axg audio clock controller.
>>
>> The goal of this driver is to coherently control the phase provided to
>> the different element using the sample clock generator. This simplify
>> the usage of the sample clock generator a lot, without comprising the
>> ability of the SoC.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/meson/Kconfig        |  5 +++
>>  drivers/clk/meson/Makefile       |  1 +
>>  drivers/clk/meson/clk-triphase.c | 68 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/clkc-audio.h   | 20 ++++++++++++
>>  4 files changed, 94 insertions(+)
>>  create mode 100644 drivers/clk/meson/clk-triphase.c
>>  create mode 100644 drivers/clk/meson/clkc-audio.h
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 87d69573e172..7f7fd6fb3809 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -3,6 +3,11 @@ config COMMON_CLK_AMLOGIC
>>  	depends on ARCH_MESON || COMPILE_TEST
>>  	select COMMON_CLK_REGMAP_MESON
>>  
>> +config COMMON_CLK_AMLOGIC_AUDIO
>> +	bool
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	select COMMON_CLK_AMLOGIC
>> +
>>  config COMMON_CLK_REGMAP_MESON
>>  	bool
>>  	select REGMAP
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 352fb848c406..64bb917fe1f0 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -4,6 +4,7 @@
>>  
>>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
>>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
>> +obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o
>>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
>> diff --git a/drivers/clk/meson/clk-triphase.c b/drivers/clk/meson/clk-triphase.c
>> new file mode 100644
>> index 000000000000..9508c03c73c1
>> --- /dev/null
>> +++ b/drivers/clk/meson/clk-triphase.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2018 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include "clkc-audio.h"
>> +
>> +/*
>> + * This is a special clock for the audio controller.
>> + * The phase of mst_sclk clock output can be controlled independently
>> + * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
>> + * Controlling these 3 phases as just one makes things simpler and
>> + * give the same clock view to all the element on the i2s bus.
>> + * If necessary, we can still control the phase in the tdm block
>> + * which makes these independent control redundant.
>> + */
>> +static inline struct meson_clk_triphase_data *
>> +meson_clk_triphase_data(struct clk_regmap *clk)
>> +{
>> +	return (struct meson_clk_triphase_data *)clk->data;
>> +}
>> +
>> +static void meson_clk_triphase_sync(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
>> +	unsigned int val;
>> +
>> +	/* Get phase 0 and sync it to phase 1 and 2 */
>> +	val = meson_parm_read(clk->map, &tph->ph0);
>> +	meson_parm_write(clk->map, &tph->ph1, val);
>> +	meson_parm_write(clk->map, &tph->ph2, val);
>> +}
>> +
>> +static int meson_clk_triphase_get_phase(struct clk_hw *hw)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
>> +	unsigned int val;
>> +
>> +	/* Phase are in sync, reading phase 0 is enough */
>> +	val = meson_parm_read(clk->map, &tph->ph0);
>> +
>> +	return meson_clk_degrees_from_val(val, tph->ph0.width);
>> +}
>> +
>> +static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
>> +{
>> +	struct clk_regmap *clk = to_clk_regmap(hw);
>> +	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
>> +	unsigned int val;
>> +
>> +	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
>> +	meson_parm_write(clk->map, &tph->ph0, val);
>> +	meson_parm_write(clk->map, &tph->ph1, val);
>> +	meson_parm_write(clk->map, &tph->ph2, val);
>> +
>> +	return 0;
>> +}
>> +
>> +const struct clk_ops meson_clk_triphase_ops = {
>> +	.init		= meson_clk_triphase_sync,
>> +	.get_phase	= meson_clk_triphase_get_phase,
>> +	.set_phase	= meson_clk_triphase_set_phase,
>> +};
>> +EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
>> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
>> new file mode 100644
>> index 000000000000..286ff1201258
>> --- /dev/null
>> +++ b/drivers/clk/meson/clkc-audio.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> Checkpatch should have warned about this !

My bad, I wasn't totally aware there is an exception in headers...

> 
>> +/*
>> + * Copyright (c) 2018 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#ifndef __MESON_CLKC_AUDIO_H
>> +#define __MESON_CLKC_AUDIO_H
>> +
>> +#include "clkc.h"
>> +
>> +struct meson_clk_triphase_data {
>> +	struct parm ph0;
>> +	struct parm ph1;
>> +	struct parm ph2;
>> +};
>> +
>> +extern const struct clk_ops meson_clk_triphase_ops;
>> +
>> +#endif /* __MESON_CLKC_AUDIO_H */
>>
> 
> Apart that :
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 
