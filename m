Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeEUJC3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:02:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55297 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbeEUJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:02:25 -0400
X-Google-Smtp-Source: AB8JxZrSQ+kEAPZ1jZvblO2FYUb1Gjss3IyGCqRMqeXs0XmE0tVYbPm97CA0yGgBjujCFUezSfomtQ==
Subject: Re: [PATCH v2 0/5] Add ChromeOS EC CEC Support
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Hans Verkuil <hans.verkuil@cisco.com>,
        Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>,
        Sean Paul <seanpaul@google.com>, sadolfsson@google.com,
        Felix Ekblom <felixe@google.com>, Benson Leung <bleung@google.com>,
        darekm@google.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1526648704-16873-1-git-send-email-narmstrong@baylibre.com>
 <CAFqH_52JvXExvk6ToJ6_7kHVE+EDjc3NBngkexktx1ReOS1KuQ@mail.gmail.com>
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
Message-ID: <9783145b-7126-9f8e-bd23-61da6adf7a7d@baylibre.com>
Date: Mon, 21 May 2018 11:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFqH_52JvXExvk6ToJ6_7kHVE+EDjc3NBngkexktx1ReOS1KuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2018 16:04, Enric Balletbo Serra wrote:
> Hi Neil,
> 
> 2018-05-18 15:04 GMT+02:00 Neil Armstrong <narmstrong@baylibre.com>:
>> Hi All,
>>
>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
>> with it and get the CEC Physical Address from the correct HDMI Connector, the
>> following must be added/changed:
>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
>> - Add the CEC related commands and events definitions into the EC MFD driver
>> - Add a way to get a CEC notifier with it's (optional) connector name
>> - Add the CEC notifier to the i915 HDMI driver
>> - Add the proper ChromeOS EC CEC Driver
>>
>> The CEC notifier with the connector name is the tricky point, since even on
>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
>> connectors from the same DRM driver. The solution I implemented is pretty
>> simple and only adds an optional connector name to eventually distinguish
>> an HDMI connector notifier from another if they share the same device.
>>
>> Feel free to comment this patchset !
>>
>> Changes since v2:
>>  - Add i915 port_identifier() and use this stable name as cec_notifier conn name
>>  - Fixed and cleaned up the CEC commands and events handling
>>  - Rebased the CEC sub-device registration on top of Enric's serie
>>  - Fixed comments typo on cec driver
>>  - Protected the DMI match only with PCI and DMI Kconfigs
>>
> 
> Just because I got confused when I saw two v2 in my inbox. This is v3, right?

Yes, sorry it's v3... next will be v4.

> 
>> Changes since v1:
>>  - Added cec_notifier_put to intel_hdmi
>>  - Fixed all small reported issues on the EC CEC driver
>>  - Moved the cec_notifier_get out of the #if .. #else .. #endif
>>
>> Changes since RFC:
>>  - Moved CEC sub-device registration after CEC commands and events definitions patch
>>  - Removed get_notifier_get_byname
>>  - Added CEC_CORE select into i915 Kconfig
>>  - Removed CEC driver fallback if notifier is not configured on HW, added explicit warn
>>  - Fixed CEC core return type on error
>>  - Moved to cros-ec-cec media platform directory
>>  - Use bus_find_device() to find the pci i915 device instead of get_notifier_get_byname()
>>  - Fix Logical Address setup
>>  - Added comment about HW support
>>  - Removed memset of msg structures
>>
>> Neil Armstrong (5):
>>   media: cec-notifier: Get notifier by device and connector name
>>   drm/i915: hdmi: add CEC notifier to intel_hdmi
>>   mfd: cros-ec: Introduce CEC commands and events definitions.
>>   mfd: cros_ec_dev: Add CEC sub-device registration
>>   media: platform: Add Chrome OS EC CEC driver
>>
>>  drivers/gpu/drm/i915/Kconfig                     |   1 +
>>  drivers/gpu/drm/i915/intel_display.h             |  20 ++
>>  drivers/gpu/drm/i915/intel_drv.h                 |   2 +
>>  drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
>>  drivers/media/cec/cec-notifier.c                 |  11 +-
>>  drivers/media/platform/Kconfig                   |  11 +
>>  drivers/media/platform/Makefile                  |   2 +
>>  drivers/media/platform/cros-ec-cec/Makefile      |   1 +
>>  drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
>>  drivers/mfd/cros_ec_dev.c                        |  16 ++
>>  drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
>>  include/linux/mfd/cros_ec.h                      |   2 +-
>>  include/linux/mfd/cros_ec_commands.h             |  80 ++++++
>>  include/media/cec-notifier.h                     |  27 +-
>>  14 files changed, 557 insertions(+), 16 deletions(-)
>>  create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
>>  create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
>>
>> --
>> 2.7.4
>>
