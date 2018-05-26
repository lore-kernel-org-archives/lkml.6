Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031358AbeEZIh4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:37:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50403 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031299AbeEZIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:37:52 -0400
X-Google-Smtp-Source: ADUXVKKTPiXzBciX2K8EKA4+WF/KF3nns6Euj9yW2xu9PAG1jQbaaU5yWkf4OgNmQ9cAcVC1cluEXQ==
Subject: Re: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
To: Olof Johansson <olof@lixom.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        chris.redpath@arm.com, linux-amlogic@lists.infradead.org,
        ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
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
Message-ID: <9f9cc086-6069-afbc-d3c6-46608ff35b79@baylibre.com>
Date: Sat, 26 May 2018 10:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525211025.c73zdcdtyuvlewng@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/2018 23:10, Olof Johansson wrote:
> On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
>> The cooling device properties, like "#cooling-cells" and
>> "dynamic-power-coefficient", should either be present for all the CPUs
>> of a cluster or none. If these are present only for a subset of CPUs of
>> a cluster then things will start falling apart as soon as the CPUs are
>> brought online in a different order. For example, this will happen
>> because the operating system looks for such properties in the CPU node
>> it is trying to bring up, so that it can register a cooling device.
>>
>> Add such missing properties.
> 
> This seems awkward compared to just having one cooling-cells in the /cpus node
> instead.
> 
> What's it used for? I don't see any properties in the device nodes on meson-gxm
> that have any cooling-foo cells in them? So why should #cooling-cells be
> needed?


There is no reason to have the cooling-cells on these other CPUs, the DVFS is
controlled on the first CPU of each cluster, here cpu0 and cpu4 and only
cpu0 and cpu4 are used as cooling-cells.

Neil

> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
