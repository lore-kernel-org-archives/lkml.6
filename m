Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeDZIkO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:40:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45629 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbeDZIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:40:07 -0400
X-Google-Smtp-Source: AIpwx4+j9z5NHEsXhw2IpSHWYecdg9EATB871GbukwPGjneP9fV4FEL47Sh6p/As9umtLNfj1tzGeg==
Subject: Re: [PATCH 2/2] clk: meson: axg: let mpll clocks round closest
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180420095603.29964-1-jbrunet@baylibre.com>
 <20180420095603.29964-3-jbrunet@baylibre.com>
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
Message-ID: <7c6068d6-299d-698f-dec7-13cdf6b85f6e@baylibre.com>
Date: Thu, 26 Apr 2018 10:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420095603.29964-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 11:56, Jerome Brunet wrote:
> Let the mpll dividers achieve the closest rate possible, even if
> it means rounding the requested rate up.
> 
> This is done to improve the accuracy of the rates provided by these
> plls to the audio subsystem
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 5f5d468c1efe..bd4dbc696b88 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -461,6 +461,7 @@ static struct clk_regmap axg_mpll0_div = {
>  			.width	 = 1,
>  		},
>  		.lock = &meson_clk_lock,
> +		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll0_div",
> @@ -507,6 +508,7 @@ static struct clk_regmap axg_mpll1_div = {
>  			.width	 = 1,
>  		},
>  		.lock = &meson_clk_lock,
> +		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll1_div",
> @@ -553,6 +555,7 @@ static struct clk_regmap axg_mpll2_div = {
>  			.width	 = 1,
>  		},
>  		.lock = &meson_clk_lock,
> +		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll2_div",
> @@ -599,6 +602,7 @@ static struct clk_regmap axg_mpll3_div = {
>  			.width	 = 1,
>  		},
>  		.lock = &meson_clk_lock,
> +		.flags = CLK_MESON_MPLL_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll3_div",
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
