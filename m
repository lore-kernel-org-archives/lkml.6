Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx4/mLT/QUOUMzyYZtD0GelBRBcpPTob5eLuTigDzrFDC4LeH/gi1cR6M2RVFNny2Ap6orpJM
ARC-Seal: i=1; a=rsa-sha256; t=1523151493; cv=none;
        d=google.com; s=arc-20160816;
        b=KGjq7Tb64tpTfhZRUFd60CgMnD82Da2DEMzBF8VbTJ2bqAHnU9DGTIE5F/DhRd2MxT
         W+1wA3L5zSnb2yvfxe0cY0/sJdoS7e2GItwgPqcjq09HxTqNtYFNkNdfcBbWL2ph0YrJ
         +aOiT4IGUF07xQ/XCGY/+CdiP5agmrheS5PP4AEx6Nhviwzwk+7BRsa0eJ6zfO1/CNWF
         ZWO6ocQiAKyvytmpoupVvCpGCJzuuajmIhbrzHXvJsaDldGngye3jwdhlC5of4mOSIMB
         QmtGq68vQG1w8Sn4cVMk28qLAtWYemjTWmzYD/faSW8ORJU1DBZHLSCMI1Of7/mMLOR4
         /BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=9n1ZbKbiJUxCpxzVPRvP29jTs9tMxqbpTwHZP3G8sSA=;
        b=q+5PsZqoGny+xNyptYTeh3FefxRpi7RzVeXE/o5aDbluCrFKBOF5NyCyFJxHsHP17f
         yyaXcx03zrCvTbUx2yWTulXUSxfh8fVOhPeLh6HARXpC+C5A5yWmRa5OOST2XjOc8Bpt
         gaKyxiiOCOTnJW/ccy6nMpaUGS4rJlr+cjIbigQmttDsvD6fYYJvzx21HJFgBkccyO29
         QnEoyjCEPs57d5I5Oi9HSDfQRCGSsL+Mqbko6EWDacV21OxBdzYDCe3E9eQhb10iryRg
         XbkUbQ05HU8IK7gge3A+4grl3ZR8/fvCf4oyTES2kgk0Gx7Vu5De9yYTSKhY406Eb3mR
         b80w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.189 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.189 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Marc Zyngier
	<marc.zyngier@arm.com>
CC: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"christoffer.dall@linaro.org" <christoffer.dall@linaro.org>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"alexander.levin@verizon.com" <alexander.levin@verizon.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org"
	<tixy@linaro.org>, "julien.thierry@arm.com" <julien.thierry@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "zhichao.huang@linaro.org" <zhichao.huang@linaro.org>,
	"jinb.park7@gmail.com" <jinb.park7@gmail.com>, "labbott@redhat.com"
	<labbott@redhat.com>, "philip@cog.systems" <philip@cog.systems>,
	"grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "opendmb@gmail.com"
	<opendmb@gmail.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/6] Disable instrumentation for some code
Thread-Topic: [PATCH v3 2/6] Disable instrumentation for some code
Thread-Index: AdPO2H1EyaF2RQgNRJ+Bd/2a+vC9Qg==
Date: Sun, 8 Apr 2018 01:38:05 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0077F5D@dggemm510-mbs.china.huawei.com>
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
X-GMAIL-THRID: =?utf-8?q?1596637215509017214?=
X-GMAIL-MSGID: =?utf-8?q?1597140100547366347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 19:39, Russell King - ARM Linux:
>On Tue, Apr 03, 2018 at 12:30:42PM +0100, Marc Zyngier wrote:
>> On 02/04/18 13:04, Abbott Liu wrote:
>> > From: Andrey Ryabinin <a.ryabinin@samsung.com>
>> >=20
>> > Disable instrumentation for arch/arm/boot/compressed/*
>> > ,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
>> > code won't linkd with kernel image.
>> >=20
>> > Disable kasan check in the function unwind_pop_register
>> > because it doesn't matter that kasan checks failed when
>> > unwind_pop_register read stack memory of task.
>> >=20
>> > Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
>> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>=20
>> Just because I replied to this patch doesn't mean you can stick my
>> Reviewed-by tag on it. Please drop this tag until I explicitly say that
>> you can add it (see Documentation/process/submitting-patches.rst,
>> section 11).
>>=20
>> Same goes for patch 1.
>
>Same goes for that reviewed-by line for me.  From my records, I never
>even looked at patch 2 from the first posting, and I don't appear to
>have the second posting in my mailbox (it's probably been classed as
>spam by dspam.)  So these reviewed-by lines seem to be totally
>misleading.

Thank Marc Zyngier and Russell King.
I have read Documentation/process/submitting-patches.rst and understand
it now. I will change it in the next version.
