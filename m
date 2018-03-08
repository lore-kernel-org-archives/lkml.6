Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvZYuOZ2h8X6o3CwLN1ioBI/1sFOqn5IKq+jXswXyobsLrIIJ1GLM1yauB+zg+aQI/W0Jko
ARC-Seal: i=1; a=rsa-sha256; t=1520494350; cv=none;
        d=google.com; s=arc-20160816;
        b=WzbCOGfxrDXknCdaJxQKrudpE0K5K996DXAT2iXiw8FdEbrqLL5z1GDm/1zHy9u/U7
         aHgfqxdmBEO5cqIE4VTKKhwKlQl8ToXaryvHL8z2lA115teeML8RUC9moaEfO2DIuWeL
         3HFnxXH4k+2tjd3iqHNXRWwvnNxhV9i++OMSCUeq4mKfKjIWfv4Xxk5z4psTDTTLjKfc
         ICjCDafvjhmOvUmSv+4VT6db+DddHD1JDKBLWoAvxVj3S9LO7EUY6gLlxK2ErKGERmu9
         eyWeLrCIn3EKgzURv5h3QrL6VqLX2RzhAEsuuNZFxkPuADxYhRd23ns/kHYhAOQdn6RV
         MKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=7LUzLsA8MTiXnIfWP5Xp14RtbL6THbgcdV1FEnYxA2Q=;
        b=udw8dP1bwA1ToC9brrKzz9JSJbyjgd2qvfLvzEZ2pZrfX5GYjqCcetWNWDpu+m2TGN
         j5KRqNSoMKX9G/PBlQbFlRe3hwrAEm1TTcJYVRRaTVgI23jfY5wsZNUMrUbFezLum2pm
         jwyA7RtKyG251U1IrnfqmxCNfX3hu2bY2ckbzwUCaDVg7Treb3iRSy8LyDLOnulHZ+Iq
         vpcXniWvjbTOy4gBFHTxVsjPbTMxh011VyCdiHkVvTWHP0DEs9y7Lt2CbPYQerAi8C/o
         PlnsztU/+R2gI0nNisNTLzoMub4yzlEAhZBHRj5l3EhqEQtc9DZMQLGupCNWADk3K2o/
         FdJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: andy.shevchenko@gmail.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <e34225f46210b61ae2ef52b8b29e3902>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AA0E6F9.6060704@rock-chips.com>
Date: Thu, 08 Mar 2018 15:32:09 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 briannorris@google.com, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?=
 <heiko@sntech.de>, Dmitry Torokhov <dtor@google.com>,
 Douglas Anderson <dianders@google.com>,
 devicetree <devicetree@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>,
 stephen lu <lumotuwe@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input <linux-input@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: gpio-keys - add support for wakeup event
 action
References: <20180306074418.8879-1-jeffy.chen@rock-chips.com> <20180306074418.8879-2-jeffy.chen@rock-chips.com> <CAHp75VcmbHbnD8FnTHXAqGajhs10wA7Z7U_D6SY9=j=y+GLLPA@mail.gmail.com>
In-Reply-To: <CAHp75VcmbHbnD8FnTHXAqGajhs10wA7Z7U_D6SY9=j=y+GLLPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594353884356754078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

Thanks for your reply.

On 03/07/2018 07:57 PM, Andy Shevchenko wrote:
> On Tue, Mar 6, 2018 at 9:44 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Add support for specifying event actions to trigger wakeup when using
>> the gpio-keys input device as a wakeup source.
>>
>> This would allow the device to configure when to wakeup the system. For
>> example a gpio-keys input device for pen insert, may only want to wakeup
>> the system when ejecting the pen.
>
>> +       bool wakeup_enabled;
>
>> +                       if (bdata->wakeup_enabled) {
>
> This is redundant. IRQ core keeps track on this information already.
>
> Check below as an example
> aef3ad103a68 ("serial: core: remove unneeded irq_wake flag")
>
right, that make sense.
>
