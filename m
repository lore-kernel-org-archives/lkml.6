Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtypWJ9G3fNQY5KU1uCbznK3/7BnWMfKUlg5lCvpfJ0zNf3x4jhoJbSTrU4cBBo7GFdU+cL
ARC-Seal: i=1; a=rsa-sha256; t=1520848076; cv=none;
        d=google.com; s=arc-20160816;
        b=NKnqiXeSNSlrXIb7h5dMp96TQGzkUfwV6SaC3yTH3u013lej+k5Adu94PNyoPLCCU+
         iVC+rE9FIKLR1jQVv0xqu8araFXK3ZxiAmeiNatm1x4rZkulJ9QxAoPgVlg5sC03Z2bv
         Bot+k2r2HULpPs07ouYsQ2d1qmWRTyI52BsHXUW4CGhy2v1f1YkpgKqpEH145kQDgOXC
         ba0P8ZvkwesdPlksZ1zKXXbUB+W3N3ICFbboDcv6zIyj9MRAhERrZZuuqDzAbViI0/8I
         BrZUlom+W+EtvIKwsu4iAwMlZnOimHFKKUdpWmxDgY8VnYL1APCpqUtpPUUsCAuvY3CU
         bUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=vVMQxvTWlPuHnIaKCHfMe/g9e5WMsYc3aktkj60YO9c=;
        b=CHgfDE0kbp7w/HoH1/VuOfMBUdwVa81tGIqpT8CXOmjJww0wpJc6HNUJ3dDXx0XQiN
         Hj3PyqOJqMfcfdF2AdWXjw9gXvwI6OQ/+hmsvkFsi/yglhdpcYtXAmEdT/jVb4aCNN1X
         NN5bYRLBLHSFrSg4Cq714naJY4/kI8N2spKOzmKPjEzAX/lwkVUKM/LuVScXFu2yelPY
         Q+nn3pe/1h6x69R+En4eXjjk5rUB6i4SWUGYpC0CKqF3U8TZOJoNBdLEecpvU+Bscxs/
         xf8YBfe0q60AfFFPafWuNsKpgSrRTfZoYO/kDetEw1Q9HpLYGCDcI/d4eYLW/4Y6nS+i
         VpxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: lee.jones@linaro.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1508f39f3d2efddc6c7cd22256954ccd>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AA64CA2.1080309@rock-chips.com>
Date: Mon, 12 Mar 2018 17:47:14 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-kernel@vger.kernel.org, broonie@kernel.org,
 alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>,
 Arnd Bergmann <arnd@arndb.de>,
 Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>,
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
Subject: Re: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com> <20180309084351.32009-2-jeffy.chen@rock-chips.com> <20180312091214.f6dwq6q3eqqblfnf@dell>
In-Reply-To: <20180312091214.f6dwq6q3eqqblfnf@dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449087814408748?=
X-GMAIL-MSGID: =?utf-8?q?1594724792612999147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Lee,

On 03/12/2018 05:12 PM, Lee Jones wrote:
> On Fri, 09 Mar 2018, Jeffy Chen wrote:
>
>> >We are now allowing to register debugfs without a valid device, and not
>> >having a valid name will end up using "dummy*" to create debugfs dir.
>> >
>> >Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>
>> >---
>> >
>> >Changes in v4: None
>> >Changes in v3:
>> >Modify commit message.
>> >
>> >  drivers/mfd/syscon.c | 1 +
>> >  1 file changed, 1 insertion(+)
> Is this the RESEND I requested?  I can still only see this patch.
>
oops, sorry, i was using patman, and i force it to CC everyone in the 
cover letter's CC list, but that doesn't contain your mail address..i'll 
try another way :)
