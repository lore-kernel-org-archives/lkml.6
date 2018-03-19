Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELsrVYhwxv1c7KrirLvIWqIZ4/XKJ+yjtrUzCvwXMTaoj22lbQmrakq/BwKkt1QPl6AC/Dea
ARC-Seal: i=1; a=rsa-sha256; t=1521422443; cv=none;
        d=google.com; s=arc-20160816;
        b=gX/fhunMEpLgcIYnjGB7lhpnCyjjvwNEun0sXHSA9NVLo1uXhpr3oIKdpUUPap2VES
         LNLUZ4KzjmWru7PlDexFI5XJ3v75aWN5mha0qwfMdvZS+JrOPyBYFz0qzgZ45Wr7qRmz
         nsxDjckby9uj8ySe9P1A+2qCQc+4SdcqoBgqmKa282GSVYuLVL+MOnTks7Xl/iHsdOoT
         U5tjHT3VUCKoIBmewQpCay7ZyFwqZlEX//vxRHoyStsQPPMIKJ9ABPyOToj7hRuWFoxC
         QqQA5w3s1m0B3X2VhNweYiiZfBksZXLo0j4vAgnlcKJPCvL8ybxVd6M4zWvcto1Vugoz
         fJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=fQqXCXICNWBk+CtDKpmQR2tND7L/hWXQDPbALb0EBAY=;
        b=yAwwe9OFtrTulvUJ9Pb9lQCSgfvOhm7ThqmgtkAWTKXwVVF/nDl9+pfKCy72hTxI0l
         JWWyTy0h8t6QWeXKjfsJZXcMqoTetkBJF9tPowtb1tADHfYhFIfuXdKXvfoL9PSUIqkM
         t4RPnphAvSx6dDI8UH4f3MnfinEK+c3SfY6FDFJoiwb7cRZrmjFdzUNc/xsGkDLWt8EI
         hZda8hIZRjIPakqBmX2/wTHwCb66psTmCyaS/AYyzest/rgOlAnxtJGGfTxbRhfNE5u/
         RTzIOdpMCTpU3jjUMD+J1aUhSV4V355SB7JA6C92/XQaz/EIFyv6N/tJLUl5ccMMu9bZ
         Ru+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
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
Thread-Index: AdO/IDOD+ORs3G0UQaCCnVLjXXbm1A==
Date: Mon, 19 Mar 2018 01:20:35 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0076FBE@dggemm510-mbs.china.huawei.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595327059822650053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>Thanks for posting these patches! Just FWIW, you cannot quite add
>someone's Tested-by for a patch series that was just resubmitted given
>the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>and it looks like test_kasan.ko is passing, great job!

I'm sorry.
Thanks for your testing very much!
I forget to add Tested-by in cover letter patch file. But I have alreadly a=
dded
Tested-by in some of following patch.=20
In the next version I am going to add Tested-by in all patches.
