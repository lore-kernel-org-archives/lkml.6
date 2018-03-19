Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELse8hsLTHcCeIXpLLt7VNxQ/jW78Z7J9clqIYP2uHRFZ5NteLcxw3HB7xkyxg2fanGh67ED
ARC-Seal: i=1; a=rsa-sha256; t=1521424615; cv=none;
        d=google.com; s=arc-20160816;
        b=wQnxLkgWHUY5zFnbZc7BBRq8m8chSdDrdG5JPuW+bpKJZeK2JhiCFfPhMbtF9sl5+Q
         MIYCR4SSSlYSQthTwLftHg3cBLE9g9w6kPU8GVD2V3uNJ+FLkNiC0GBkhsbQ3r+SimOQ
         6JXeID7axypbbTeHapNarkXrXHUSM+KxrU/3x88r0e1cBy9esKDZzJXvfHXPHwIYuCeo
         eq/Ky1xU6HVgoi5lQB7KWvuqrndAfW654CI5kOcuUpHdKsdP2lgkH+8ZJG4d3XO4Y28n
         RB4pHzdokffM3Vjs1iOz+b7+4InXJ+gqTCWtl3Dln9Ts36JeAlf1FGyYjkP7zUXgEp/f
         QlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=P49nUDykx53BjpTLDmFNHNHpw1QyBjK5KTUAcbF9zh4=;
        b=dicwOF5SFe3531HjKb+xOGw7LWc1XFnWhDsNgKhyI2Vm5DpMPeDCzNlOqVwzeOKOji
         gl8ec8Q831KBNFR64ZhHrp4k2nSbqvJrug03Y5P9ODqHYPOmQsyeXiV9uZzAnF4D1Oyw
         +OuV20HpvUMbD5IZusH7c87CgGrG+Wm/817qMuOla+a5XEgLsniqE1iKQ59lx6QeX+3k
         8aR01C5hKr4BkbzAelSHB1SGQeFzJL44h6LfVzQGWNrfMKX+EoI2cpo2Xa8NfnHdr7oY
         GP4m07ESruH6xasJjnX6npObCv9jiCm2xpFZtONtJKVaBYUyOmJ/swIZs1DJQSz5cAR8
         ddQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "afzal.mohd.ma@gmail.com"
	<afzal.mohd.ma@gmail.com>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>
CC: "glider@google.com" <glider@google.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "christoffer.dall@linaro.org"
	<christoffer.dall@linaro.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org"
	<tixy@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "zhichao.huang@linaro.org"
	<zhichao.huang@linaro.org>, "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
	"labbott@redhat.com" <labbott@redhat.com>, "philip@cog.systems"
	<philip@cog.systems>, "grygorii.strashko@linaro.org"
	<grygorii.strashko@linaro.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/7] KASan for arm
Thread-Topic: [PATCH v2 0/7] KASan for arm
Thread-Index: AdO/JKHHDNKCIA+cTLe3DIc6tWMHXQ==
Date: Mon, 19 Mar 2018 01:56:52 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0076FFD@dggemm510-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595329337318563837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 09:23 AM, Florian Fainelli wrote:
>On 03/18/2018 06:20 PM, Liuwenliang (Abbott Liu) wrote:
>> On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>>> Thanks for posting these patches! Just FWIW, you cannot quite add
>>> someone's Tested-by for a patch series that was just resubmitted given
>>> the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>>> and it looks like test_kasan.ko is passing, great job!
>>=20
>> I'm sorry.
>> Thanks for your testing very much!
>> I forget to add Tested-by in cover letter patch file. But I have alreadl=
y added
>> Tested-by in some of following patch.=20
>> In the next version I am going to add Tested-by in all patches.
>
>This is not exactly what I meant. When you submit a v2 of your patches,
>you must wait for people to give you their test results. The Tested-by
>applied to v1, and so much has changed it is no longer valid for v2
>unless someone tells you they tested v2. Hope this is clearer.

Ok, I understand now. thank you for your explanation.
