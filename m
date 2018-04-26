Return-Path: <narmstrong@baylibre.com>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524731893-2-9508313711474034478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_SOFTFAIL 0.665, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.67', Host='mail-wm0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: narmstrong@baylibre.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524731893; b=UfYBxvPbY3VzOoLPGh85ux+M9gXXtIVOeK9k23daS8A9bZYom8
    5uB7J+/BDFB1jTM8oMKfKs7DASjJcZtlHJ7DaKXodIhuZcLVsbxZynpi52lAnfjR
    hhekkLRVN4VBnoWI9lzKYJUjNYnEmitL412zgmQxUnNFunuH2wjeHEoPpK4OT/lk
    Atits/lt9mNuJlVDEQwNO4ebKJPepk7ytxIDDHyhJxfSyj9+3paq/pdiuas1wB9u
    dz0jhCr0cSai3CW4IgAnI/pAMa0fVSKsH/N1zfSLezmRD/sahEdbKjnP0CYrMkMU
    rkv2aSTOaEaAp8QVHz4aqaG1Ph3POPq0/OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=fm2; t=1524731893; bh=wX+FczbFXZTh
    oP8P4HPCyBn8qm9Y4PuyEqCq7yITfqU=; b=sedrxaAJNdwL9qw1+gIZX80MGq+P
    oKqluU8a3sWNXnoTx4G3G1Wkq4rNaYKIQPY0BfLaZjmZBw++7iHbH+4n4URHo/CD
    7UWQXs4sCTkmZUE3oySM3TqdYPvPqUMSpnkmJzlLSK9PlW4TTb4zVdq8H6cJQSY3
    5dogcMOCZomdxWxm2w83iJkv/FoNZ/K6ZqORXCFvx1W7/CxVEPfDfNHPbTPyN5K3
    O+Zo0GyYu9AvZfHkcc/9GeMSTD4jv1ZW0XLI1Qh0Qmy1nSu1jikjv8zngKeMKqcZ
    f3nmZQDHPnXE+HexUjYdNtsoSvaBBbagPReesWYQmC2vYrzxCK5dAuZj5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=yrDJgoXB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=74.125.82.67 (mail-wm0-f67.google.com);
    spf=softfail smtp.mailfrom=narmstrong@baylibre.com smtp.helo=mail-wm0-f67.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d6BHwAd8;
    x-ptr=pass x-ptr-helo=mail-wm0-f67.google.com x-ptr-lookup=mail-wm0-f67.google.com;
    x-return-mx=pass smtp.domain=baylibre.com smtp.result=pass smtp_is_org_domain=yes header.domain=baylibre.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=yrDJgoXB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=74.125.82.67 (mail-wm0-f67.google.com);
    spf=softfail smtp.mailfrom=narmstrong@baylibre.com smtp.helo=mail-wm0-f67.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d6BHwAd8;
    x-ptr=pass x-ptr-helo=mail-wm0-f67.google.com x-ptr-lookup=mail-wm0-f67.google.com;
    x-return-mx=pass smtp.domain=baylibre.com smtp.result=pass smtp_is_org_domain=yes header.domain=baylibre.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB6tbXq0uzh1BO6MEcaQb9jxzLKnqtDVHKIC24Eh+2nI2xLfnvmoLbLgfe1qmHyj0q/ZhJGnNTRRSh/Q/WyAfxj66jJq95UwsPWhkGmp5GW9a5YvS97y
    PegJSIAEtIvtxubhLC0Gg2K4MwkqehWygCiQmXbbkUSATcQbhNf/aViZKBsyVfQ5eUbCNXqVr0hWgAz/2OHm6M0t8Cdx1C+DetU=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=vqBIgXISwHERwelLxCqUnA==:117
    a=i/xWKLl66V/CsLvh0Gvtsg==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=YHyaUnCU2EIxKUCL1dIA:9 a=QEXdDO2ut3YA:10
    a=IawgGOuG5U0WyFbmm1f5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx496R5jawwu9m1e/gR0YN4Z//8B2tCeLzzhGYrhAxmVXrnVTOP82Cs1ZETpxryvMdaQPAOfoLw==
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic
 Meson GX SoCs
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
 <3b17d17b-cf3d-be54-2462-191e4f2af653@baylibre.com>
 <20180419082751.GA23187@kroah.com>
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
Message-ID: <8766c753-bc2c-0e54-0ac0-73acaa0e11d8@baylibre.com>
Date: Thu, 26 Apr 2018 10:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419082751.GA23187@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 19/04/2018 10:27, Greg KH wrote:
> On Thu, Apr 19, 2018 at 10:18:35AM +0200, Neil Armstrong wrote:
>> Hi Greg,
>>
>> On 23/02/2018 12:44, Neil Armstrong wrote:
>>> The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
>>> identified needing this workaround.
>>> This patch adds the corresponding version to enable a single iteration for
>>> this specific version.
>>>
>>> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> This patch is now present in linux master as commit 9c305eb442f3b371fc722ade827bbf673514123e
>> Could it be selected for 4.14 ?
>> The patch has been reworked to apply for 4.17 as indicated in the commit log, but the original patch will apply over 4.14.
> 
> I don't have any "original" patch here, I just tried applying it to
> 4.16.y and 4.14.y and it did not work.  Can you please provide a working
> backport?

I sent a backported version last week, any news of it ?

Message-Id: <1524128048-11086-1-git-send-email-narmstrong@baylibre.com>

Thanks,
Neil

> 
> thanks,
> 
> greg k-h
> 
