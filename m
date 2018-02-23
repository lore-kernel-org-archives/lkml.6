Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x224vQiwBVAqF3w8NWpkuyVLZuZw1be1OfsWdFVOOMhJBc8eKby32q3Z6AQeyXmim+8aijnm7
ARC-Seal: i=1; a=rsa-sha256; t=1519379001; cv=none;
        d=google.com; s=arc-20160816;
        b=tR1BfG1GFW2tjeck4HfZuYOgmKXSJc71h9EcLQXTKRoJGWDzRdZ9UYCvudlQbR4bmu
         349ipya2wIw/ho3gYcPoZ1rCbCG1lGApzDZrRw32+xIdKDtIKYgOrqftUOIXtciv7QTh
         ycev/XJB2JWzjd11pb6Ao+mRy+n/t/TmpTYlNZ5tHaHvxU5gOIiZgkbii3wi97HsxenG
         LESKXbf0OcDhu57ZOLcv0P3lgc4OoQ4xDOc+eue4TmXSqfVCrqtdnRLljohOpcL9fhZm
         CCTHLBCYDDf9NSWma02BTkC8Ghw73BFSRXnXFykm58oC3wU8Z6dW66/pfnirQ6ql8RjO
         BQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=Xi3209J08PySORmQSzh9QgHZIUl6aEM+t2jIS+MQFDI=;
        b=nwOQSixeY0uIjKOBonPsVQDpUY9WuIxP5QO4m269btS+/q5RZAd7cCdKHqjj5eB14f
         EUoDUnEgVURQepwXwJTRMdtd1OBz++K1ABr2w5AJ8qe2FVOO4sPKX8dxfW0VCjkP8YdL
         cedP8gyOaYMgZ51hbY1b7fdfOoF0AbKDVHh351kiFJzVSQITf7CnNOBdM3HsYIKZWTxM
         /3ROvzOh/ldiZN9ftbc4rKgKrnaAiUqKLd+lT/lONykUha2E6iPMSNEi32ItLC18o5jE
         ULiNeevStEyuBTPLLEa4I3jjIsmJo71kmd9hCXRciZwDlpMoomD8XMc9pIMBBQHtDCqI
         wZ+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.29 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.29 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <8eda361e1991ef3428f827f14bd35d03>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A8FE22A.1070709@rock-chips.com>
Date: Fri, 23 Feb 2018 17:43:06 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
CC: linux-kernel@vger.kernel.org, briannorris@google.com,
 dtor@google.com, dianders@google.com, Arnd Bergmann <arnd@arndb.de>,
 Joseph Lo <josephl@nvidia.com>,
 Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 linux-rockchip@lists.infradead.org,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event
 action
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com> <1541427.8RRpDbxO4f@diego>
In-Reply-To: <1541427.8RRpDbxO4f@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012039137400382?=
X-GMAIL-MSGID: =?utf-8?q?1593184356755380790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Heiko,

Thanks for your reply :)

On 02/14/2018 09:39 PM, Heiko Stübner wrote:
> Hi Jeffy,
>
> Am Samstag, 10. Februar 2018, 12:09:04 CET schrieb Jeffy Chen:
>> On chromebook kevin, we are using gpio-keys for pen insert event. But
>> we only want it to wakeup the system when ejecting the pen.
>>
>> So we may need to change the interrupt trigger type during suspending.
>>
>> Changes in v2:
>> Specify wakeup event action instead of irq trigger type as Brian
>> suggested.
>>
>> Jeffy Chen (3):
>>    Input: gpio-keys - add support for wakeup event action
>>    Input: gpio-keys - allow setting wakeup event action in DT
>>    arm64: dts: rockchip: Avoid wakeup when inserting the pen
>
> The recipient-selection for the mail thread seems to be a bit off and
> I only got the cover-letter and patch 3/3.
> Therefore I won't really see if and when the Input-changes get
> accepted. So please ping me once that has happened so I can pick up
> the rockchip dts change for it.
oops, sorry, i'll add you to the CC list in the next version :)

>
>
> Thanks
> Heiko
>
>
>
