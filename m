Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbeDZIdE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:33:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36866 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeDZIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:32:59 -0400
X-Google-Smtp-Source: AIpwx48jcVWPrxrxgv4RTBWXm+R8Ap1BDHjy6rgArc7ZhNyg2eBJyd1U1kkib2On8l9QsUWEreIngw==
Subject: Re: [PATCH] pinctrl: meson: axg: add tdm pins
To: Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180409145429.16619-1-jbrunet@baylibre.com>
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
Message-ID: <fc4e195e-095a-c04c-8ff8-37fadc22ab21@baylibre.com>
Date: Thu, 26 Apr 2018 10:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409145429.16619-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 16:54, Jerome Brunet wrote:
> Add the information related to the tdm pins of the A113D SoC
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-axg.c | 107 ++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 4b91ff74779b..11dc23fde6d5 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -312,6 +312,47 @@ static const unsigned int pdm_din1_pins[] = {GPIOA_16};
>  static const unsigned int pdm_din2_pins[] = {GPIOA_17};
>  static const unsigned int pdm_din3_pins[] = {GPIOA_18};
>  
> +/* mclk */
> +static const unsigned int mclk_c_pins[] = {GPIOA_0};
> +static const unsigned int mclk_b_pins[] = {GPIOA_1};
> +
> +/* tdm */
> +static const unsigned int tdma_sclk_pins[] = {GPIOX_12};
> +static const unsigned int tdma_sclk_slv_pins[] = {GPIOX_12};
> +static const unsigned int tdma_fs_pins[] = {GPIOX_13};
> +static const unsigned int tdma_fs_slv_pins[] = {GPIOX_13};
> +static const unsigned int tdma_din0_pins[] = {GPIOX_14};
> +static const unsigned int tdma_dout0_x14_pins[] = {GPIOX_14};
> +static const unsigned int tdma_dout0_x15_pins[] = {GPIOX_15};
> +static const unsigned int tdma_dout1_pins[] = {GPIOX_15};
> +static const unsigned int tdma_din1_pins[] = {GPIOX_15};
> +
> +static const unsigned int tdmc_sclk_pins[] = {GPIOA_2};
> +static const unsigned int tdmc_sclk_slv_pins[] = {GPIOA_2};
> +static const unsigned int tdmc_fs_pins[] = {GPIOA_3};
> +static const unsigned int tdmc_fs_slv_pins[] = {GPIOA_3};
> +static const unsigned int tdmc_din0_pins[] = {GPIOA_4};
> +static const unsigned int tdmc_dout0_pins[] = {GPIOA_4};
> +static const unsigned int tdmc_din1_pins[] = {GPIOA_5};
> +static const unsigned int tdmc_dout1_pins[] = {GPIOA_5};
> +static const unsigned int tdmc_din2_pins[] = {GPIOA_6};
> +static const unsigned int tdmc_dout2_pins[] = {GPIOA_6};
> +static const unsigned int tdmc_din3_pins[] = {GPIOA_7};
> +static const unsigned int tdmc_dout3_pins[] = {GPIOA_7};
> +
> +static const unsigned int tdmb_sclk_pins[] = {GPIOA_8};
> +static const unsigned int tdmb_sclk_slv_pins[] = {GPIOA_8};
> +static const unsigned int tdmb_fs_pins[] = {GPIOA_9};
> +static const unsigned int tdmb_fs_slv_pins[] = {GPIOA_9};
> +static const unsigned int tdmb_din0_pins[] = {GPIOA_10};
> +static const unsigned int tdmb_dout0_pins[] = {GPIOA_10};
> +static const unsigned int tdmb_din1_pins[] = {GPIOA_11};
> +static const unsigned int tdmb_dout1_pins[] = {GPIOA_11};
> +static const unsigned int tdmb_din2_pins[] = {GPIOA_12};
> +static const unsigned int tdmb_dout2_pins[] = {GPIOA_12};
> +static const unsigned int tdmb_din3_pins[] = {GPIOA_13};
> +static const unsigned int tdmb_dout3_pins[] = {GPIOA_13};
> +
>  static struct meson_pmx_group meson_axg_periphs_groups[] = {
>  	GPIO_GROUP(GPIOZ_0),
>  	GPIO_GROUP(GPIOZ_1),
> @@ -495,6 +536,15 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
>  	GROUP(eth_rx_dv_x, 4),
>  	GROUP(eth_mdio_x, 4),
>  	GROUP(eth_mdc_x, 4),
> +	GROUP(tdma_sclk, 1),
> +	GROUP(tdma_sclk_slv, 2),
> +	GROUP(tdma_fs, 1),
> +	GROUP(tdma_fs_slv, 2),
> +	GROUP(tdma_din0, 1),
> +	GROUP(tdma_dout0_x14, 2),
> +	GROUP(tdma_dout0_x15, 1),
> +	GROUP(tdma_dout1, 2),
> +	GROUP(tdma_din1, 3),
>  
>  	/* bank GPIOY */
>  	GROUP(eth_txd0_y, 1),
> @@ -544,6 +594,32 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
>  	GROUP(pdm_din1, 1),
>  	GROUP(pdm_din2, 1),
>  	GROUP(pdm_din3, 1),
> +	GROUP(mclk_c, 1),
> +	GROUP(mclk_b, 1),
> +	GROUP(tdmc_sclk, 1),
> +	GROUP(tdmc_sclk_slv, 2),
> +	GROUP(tdmc_fs, 1),
> +	GROUP(tdmc_fs_slv, 2),
> +	GROUP(tdmc_din0, 2),
> +	GROUP(tdmc_dout0, 1),
> +	GROUP(tdmc_din1, 2),
> +	GROUP(tdmc_dout1, 1),
> +	GROUP(tdmc_din2, 2),
> +	GROUP(tdmc_dout2, 1),
> +	GROUP(tdmc_din3, 2),
> +	GROUP(tdmc_dout3, 1),
> +	GROUP(tdmb_sclk, 1),
> +	GROUP(tdmb_sclk_slv, 2),
> +	GROUP(tdmb_fs, 1),
> +	GROUP(tdmb_fs_slv, 2),
> +	GROUP(tdmb_din0, 2),
> +	GROUP(tdmb_dout0, 1),
> +	GROUP(tdmb_din1, 2),
> +	GROUP(tdmb_dout1, 1),
> +	GROUP(tdmb_din2, 2),
> +	GROUP(tdmb_dout2, 1),
> +	GROUP(tdmb_din3, 2),
> +	GROUP(tdmb_dout3, 1),
>  };
>  
>  /* uart_ao_a */
> @@ -845,6 +921,32 @@ static const char * const jtag_ao_groups[] = {
>  	"jtag_ao_tdi", "jtag_ao_tdo", "jtag_ao_clk", "jtag_ao_tms",
>  };
>  
> +static const char * const mclk_c_groups[] = {
> +	"mclk_c",
> +};
> +
> +static const char * const mclk_b_groups[] = {
> +	"mclk_b",
> +};
> +
> +static const char * const tdma_groups[] = {
> +	"tdma_sclk", "tdma_sclk_slv", "tdma_fs", "tdma_fs_slv",
> +	"tdma_din0", "tdma_dout0_x14", "tdma_dout0_x15", "tdma_dout1",
> +	"tdma_din1",
> +};
> +
> +static const char * const tdmc_groups[] = {
> +	"tdmc_sclk", "tdmc_sclk_slv", "tdmc_fs", "tdmc_fs_slv",
> +	"tdmc_din0", "tdmc_dout0", "tdmc_din1",	"tdmc_dout1",
> +	"tdmc_din2", "tdmc_dout2", "tdmc_din3",	"tdmc_dout3",
> +};
> +
> +static const char * const tdmb_groups[] = {
> +	"tdmb_sclk", "tdmb_sclk_slv", "tdmb_fs", "tdmb_fs_slv",
> +	"tdmb_din0", "tdmb_dout0", "tdmb_din1",	"tdmb_dout1",
> +	"tdmb_din2", "tdmb_dout2", "tdmb_din3",	"tdmb_dout3",
> +};
> +
>  static struct meson_pmx_func meson_axg_periphs_functions[] = {
>  	FUNCTION(gpio_periphs),
>  	FUNCTION(emmc),
> @@ -870,6 +972,11 @@ static struct meson_pmx_func meson_axg_periphs_functions[] = {
>  	FUNCTION(spdif_in),
>  	FUNCTION(jtag_ee),
>  	FUNCTION(pdm),
> +	FUNCTION(mclk_b),
> +	FUNCTION(mclk_c),
> +	FUNCTION(tdma),
> +	FUNCTION(tdmb),
> +	FUNCTION(tdmc),
>  };
>  
>  static struct meson_pmx_func meson_axg_aobus_functions[] = {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
