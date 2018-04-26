Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeDZIgd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:36:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33700 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbeDZIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:36:31 -0400
X-Google-Smtp-Source: AB8JxZoBbEugIB4er5MNBPMgsmFnN8TWLa0uI4x+jNb3OrLKN9FVoPlsUQf2vaio1yvhFHqE99nXLg==
Subject: Re: [PATCH] ARM64: dts: meson-axg: add tdm pins
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180417064035.28776-1-jbrunet@baylibre.com>
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
Message-ID: <49f6e142-f958-c86a-e951-a3eb7aa4e720@baylibre.com>
Date: Thu, 26 Apr 2018 10:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417064035.28776-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2018 08:40, Jerome Brunet wrote:
> Add tdm pins to amlogic's A113 device tree
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 245 +++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b58808eb3cc8..74013965e86a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -660,6 +660,251 @@
>  						function = "uart_ao_b_z";
>  					};
>  				};
> +
> +				mclk_b_pins: mclk_b {
> +					mux {
> +						groups = "mclk_b";
> +						function = "mclk_b";
> +					};
> +				};
> +
> +				mclk_c_pins: mclk_c {
> +					mux {
> +						groups = "mclk_c";
> +						function = "mclk_c";
> +					};
> +				};
> +
> +				tdma_sclk_pins: tdma_sclk {
> +					mux {
> +						groups = "tdma_sclk";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_sclk_slv_pins: tdma_sclk_slv {
> +					mux {
> +						groups = "tdma_sclk_slv";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_fs_pins: tdma_fs {
> +					mux {
> +						groups = "tdma_fs";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_fs_slv_pins: tdma_fs_slv {
> +					mux {
> +						groups = "tdma_fs_slv";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_din0_pins: tdma_din0 {
> +					mux {
> +						groups = "tdma_din0";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout0_x14_pins: tdma_dout0_x14 {
> +					mux {
> +						groups = "tdma_dout0_x14";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout0_x15_pins: tdma_dout0_x15 {
> +					mux {
> +						groups = "tdma_dout0_x15";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_dout1_pins: tdma_dout1 {
> +					mux {
> +						groups = "tdma_dout1";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdma_din1_pins: tdma_din1 {
> +					mux {
> +						groups = "tdma_din1";
> +						function = "tdma";
> +					};
> +				};
> +
> +				tdmb_sclk_pins: tdmb_sclk {
> +					mux {
> +						groups = "tdmb_sclk";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_sclk_slv_pins: tdmb_sclk_slv {
> +					mux {
> +						groups = "tdmb_sclk_slv";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_fs_pins: tdmb_fs {
> +					mux {
> +						groups = "tdmb_fs";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_fs_slv_pins: tdmb_fs_slv {
> +					mux {
> +						groups = "tdmb_fs_slv";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din0_pins: tdmb_din0 {
> +					mux {
> +						groups = "tdmb_din0";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout0_pins: tdmb_dout0 {
> +					mux {
> +						groups = "tdmb_dout0";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din1_pins: tdmb_din1 {
> +					mux {
> +						groups = "tdmb_din1";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout1_pins: tdmb_dout1 {
> +					mux {
> +						groups = "tdmb_dout1";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din2_pins: tdmb_din2 {
> +					mux {
> +						groups = "tdmb_din2";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout2_pins: tdmb_dout2 {
> +					mux {
> +						groups = "tdmb_dout2";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_din3_pins: tdmb_din3 {
> +					mux {
> +						groups = "tdmb_din3";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmb_dout3_pins: tdmb_dout3 {
> +					mux {
> +						groups = "tdmb_dout3";
> +						function = "tdmb";
> +					};
> +				};
> +
> +				tdmc_sclk_pins: tdmc_sclk {
> +					mux {
> +						groups = "tdmc_sclk";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_sclk_slv_pins: tdmc_sclk_slv {
> +					mux {
> +						groups = "tdmc_sclk_slv";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_fs_pins: tdmc_fs {
> +					mux {
> +						groups = "tdmc_fs";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_fs_slv_pins: tdmc_fs_slv {
> +					mux {
> +						groups = "tdmc_fs_slv";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din0_pins: tdmc_din0 {
> +					mux {
> +						groups = "tdmc_din0";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout0_pins: tdmc_dout0 {
> +					mux {
> +						groups = "tdmc_dout0";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din1_pins: tdmc_din1 {
> +					mux {
> +						groups = "tdmc_din1";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout1_pins: tdmc_dout1 {
> +					mux {
> +						groups = "tdmc_dout1";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din2_pins: tdmc_din2 {
> +					mux {
> +						groups = "tdmc_din2";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout2_pins: tdmc_dout2 {
> +					mux {
> +						groups = "tdmc_dout2";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_din3_pins: tdmc_din3 {
> +					mux {
> +						groups = "tdmc_din3";
> +						function = "tdmc";
> +					};
> +				};
> +
> +				tdmc_dout3_pins: tdmc_dout3 {
> +					mux {
> +						groups = "tdmc_dout3";
> +						function = "tdmc";
> +					};
> +				};
>  			};
>  		};
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
