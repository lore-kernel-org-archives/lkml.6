Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AH8x225y7wt0e0934Cf6Z6/kgcc5V0qcc1RUznqgg+Lx3GcgxG4ESOFwH7lW0P3nDZ4PXXz2J4yp
ARC-Seal: i=1; a=rsa-sha256; t=1517474636; cv=none;
        d=google.com; s=arc-20160816;
        b=kfNSg1AubUnb0P4woys3x9Sn+SlcUi2KuURkWVktLuK5nqcYKjyr3zFJHlng5t4ydm
         3Chy5Q9O6+VuqOOVjaNNjteBHtE27QWC397nMjZnNd1SI7mBtond3MlaSoMcjKeHa3hd
         R3dVg3auNzUvnN6ugQie13Tv+dRzuaTBdDlsWWRfgyEE1axVOo7vvV0LtZvznLZwfbWi
         zmVmh70c5SP77CIoCq8qG0cSnl2bnrhBcbfgWQNkZi4bM9RIU5AKv/BMBdtR0Y2GCB0q
         PMgP6HyurJDOI7/WqDIAIIf8jbJ4EcFfaplmn8QfHS3RDX0RCHVXctRsdTwJ2+XKgBk4
         QchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=63pc7vuTlm2awss5TlQ/d5tkEJCKc4G1X4fM8nQ+N8w=;
        b=vzhI9UWkRkAkDQtwbuMsRSM4ib9OmIaToUuoD0ix3X7OGsmHpBIgZ1bkkEyXZ80YM9
         DNEzEGzpiC+zC0/iRKGT21zh5oT9H79cf3TLKIDdIQkKOfvairP5zSnIyNhxAyfc4DqG
         1q+13Dqa5Gt9cFTdveuY9M3BrFRqw+4D1qw0EZgldFMBD8SmoozLRWUOKnc76uRIV7Br
         5LJGfG1VlwZ569Fg5U4QpeFnxE0U/SrS18GR2iSiJHom2tJ4jVPlpTMnR7oeGBLoVmgw
         e4OYXBRVS9+mIi0H+JRdeiaxlz/LN30A0fOy2QQq/fiDZtQ9rTVaDTcACGqGSapb4w+c
         w9Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37E8217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
MIME-Version: 1.0
In-Reply-To: <6581962f-3552-2891-e6b3-b2f7c0018c93@samsung.com>
References: <CGME20180131155734eucas1p1c7988ce46f3164329a39d2358d9fada9@eucas1p1.samsung.com>
 <20180131155718.5237-1-a.hajda@samsung.com> <20180131155718.5237-3-a.hajda@samsung.com>
 <CAJKOXPewrA38bxiCKa=pjhVKXys2KRstV2w=+MP3TVi9kkN1kw@mail.gmail.com> <6581962f-3552-2891-e6b3-b2f7c0018c93@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 1 Feb 2018 09:43:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfs7Es4S5EdOg_en+WPFV6hcNf-0rZO-+7uNiNS96DcVg@mail.gmail.com>
Message-ID: <CAJKOXPfs7Es4S5EdOg_en+WPFV6hcNf-0rZO-+7uNiNS96DcVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: add OF graph between USB-PHY and MUIC
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591124177095890222?=
X-GMAIL-MSGID: =?utf-8?q?1591187484588703931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 9:19 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 01.02.2018 08:50, Krzysztof Kozlowski wrote:
>> On Wed, Jan 31, 2018 at 4:57 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>> OF graph describes USB data lanes between USB-PHY and respective MUIC.
>>> Since graph is present and DWC driver can use it to get extcon, obsolete
>>> extcon property can be removed.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>>> index 427ff861b441..b20b42659206 100644
>>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>>> @@ -828,6 +828,17 @@
>>>                                         };
>>>                                 };
>>>                         };
>>> +
>>> +                       ports {
>>> +                               #address-cells = <1>;
>>> +                               #size-cells = <0>;
>>> +
>>> +                               port@0 {
>>> +                                       reg = <0>;
>>> +                                       muic_to_usb: endpoint {
>>> +                                               remote-endpoint = <&usb_to_muic>;
>>> +                                       };
>>> +                               };
>>>                         };
>>>                 };
>>>
>>> @@ -1242,12 +1253,17 @@
>>>
>>>  &usbdrd_dwc3 {
>>>         dr_mode = "otg";
>>> -       extcon = <&muic>;
>> Look ok for me.
>>
>> Does this depend on #1 patch for DWC?
>
> Yes, it depends. #1 adds code to find extcon using graph, without it
> dwc3 won't be able to work in dual-role mode.
> Alternatively, I could split this patch into two parts:
> 2a. adding graph bindings.
> 2b. removing extcon property.
> In such case only 2b depends on #1.

Without splitting, this patch would have to wait till #1 gets into
mainline (so probably till v4.17-rc1 because we are in merge window
already). I am fine with this split-approach so only the cleanup patch
would get postponed. Up to you.

Best regards,
Krzysztof
