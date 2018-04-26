Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbeDZIqO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:46:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40815 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbeDZIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:46:04 -0400
X-Google-Smtp-Source: AIpwx48/+bBel63k8zRYWZH4rxO72y1t3XjR7HYzUK0YpO+q+oZO2GBtXeErhq2YX4nB38tbjnCDsw==
Subject: Re: [PATCH 1/7] clk: meson: clean-up meson clock configuration
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180425163304.10852-1-jbrunet@baylibre.com>
 <20180425163304.10852-2-jbrunet@baylibre.com>
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
Message-ID: <d643c87a-d364-1587-100d-119f8b417f11@baylibre.com>
Date: Thu, 26 Apr 2018 10:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425163304.10852-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 18:32, Jerome Brunet wrote:
> Clean the dependencies in meson clock Kconfig.
> CLK_AMLOGIC should actually select CLK_REGMAP_MESON which it uses. Also,
> each platform should select CLK_AMLOGIC, so everything is properly turned
> on when the platform Kconfig enable each configuration flag
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Kconfig | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index d5cbec522aec..87d69573e172 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -1,7 +1,7 @@
>  config COMMON_CLK_AMLOGIC
>  	bool
> -	depends on OF
>  	depends on ARCH_MESON || COMPILE_TEST
> +	select COMMON_CLK_REGMAP_MESON
>  
>  config COMMON_CLK_REGMAP_MESON
>  	bool
> @@ -9,9 +9,8 @@ config COMMON_CLK_REGMAP_MESON
>  
>  config COMMON_CLK_MESON8B
>  	bool
> -	depends on COMMON_CLK_AMLOGIC
> +	select COMMON_CLK_AMLOGIC
>  	select RESET_CONTROLLER
> -	select COMMON_CLK_REGMAP_MESON
>  	help
>  	  Support for the clock controller on AmLogic S802 (Meson8),
>  	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
> @@ -19,9 +18,8 @@ config COMMON_CLK_MESON8B
>  
>  config COMMON_CLK_GXBB
>  	bool
> -	depends on COMMON_CLK_AMLOGIC
> +	select COMMON_CLK_AMLOGIC
>  	select RESET_CONTROLLER
> -	select COMMON_CLK_REGMAP_MESON
>  	select MFD_SYSCON
>  	help
>  	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
> @@ -29,9 +27,8 @@ config COMMON_CLK_GXBB
>  
>  config COMMON_CLK_AXG
>  	bool
> -	depends on COMMON_CLK_AMLOGIC
> +	select COMMON_CLK_AMLOGIC
>  	select RESET_CONTROLLER
> -	select COMMON_CLK_REGMAP_MESON
>  	select MFD_SYSCON
>  	help
>  	  Support for the clock controller on AmLogic A113D devices, aka axg.
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
