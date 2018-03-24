Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx4/Pcw/xO49KflE85TQSLV9/SJParf8w38jl/5MXskKj0RySL0GverFOFcDw21gfThsny+OF
ARC-Seal: i=1; a=rsa-sha256; t=1521891592; cv=none;
        d=google.com; s=arc-20160816;
        b=PYbsDggRNmmvc0zXu1dLC3tVeWe7Z4Cbv6RH/gWyIX5po0zp+BBSiQlPKAp8tRIWm1
         hwO07a0AUoiF6tFbdenTvJ/Y475pumICPoJ3Gcm4eQlQMxCnBd+AY/mmkBvIbzEbuL27
         WYacyRvDQs6Qm9aTVHt+0p3fVVOdnjdbbDbjXZLhS4BjX6b7m80TtNM7nkjvRPOTT+Jq
         eWgZxY427lJkb92ptEsrV18oUuXJ3BGO2USt79stGpH7YvUhdqrVeg1c6419AxUJ8KGe
         Arso8z70ngMKaxNf+TGTMnHth5YX1DsF/OZlkrAW9CB2avXClBEmXg48l8NSLtqjgjDm
         7aBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=tNVrm1F6GaPlvSreYYimkZiQ2T7FMvEwW8ZvVX4leDE=;
        b=FxXQIvfgSSBxAqXL9lDl2MQW8DDoGsGqt3xZxrvsFzUbA/TEDvDbdG8W1e7l0b0+fk
         7Oxuzcf1eiG7/iLQoXRI3oeWn3iA7KoUsMa+UEMSDeqMtCGafRbPybsuTGAMF/ehCXyl
         qY/JutRwRjSVwouC+Oc/GPK5JKnfWzkdlLKCUMJN9mKlJVPPuHgZzsW1CS/ZmIHhvT0f
         kHx50+I+bZnVTY6p3QL1gXHsxuRxLl2LBrNauaW6UbuQ0jLWqQ0iRGgOGDLTdNKCcPDy
         tNUGDnss/SYHkBkjYkT9LBf9X8/CHNUCZVlDTpdHPEgmH76rtdrX/S5kBHFwPXs3AmkU
         cM7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.187 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "akpm@linux-foundation.org"
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
Subject: Re: [PATCH 3/7] Disable instrumentation for some code
Thread-Topic: [PATCH 3/7] Disable instrumentation for some code
Thread-Index: AdPDY1d/xMIMdVxbRVmFMrs9R52bIA==
Date: Sat, 24 Mar 2018 11:39:15 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C007748D@dggemm510-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281348586667199?=
X-GMAIL-MSGID: =?utf-8?q?1595818998003385049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMTkvMDMvMjAxOCAxNjozOCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPllvdSBuZWVkIHRvIGV4
dGVuZCB0aGlzIGF0IGxlYXN0IHRvIGFyY2gvYXJtL2t2bS9oeXAvTWFrZWZpbGUsIGFzIHRoZQ0K
PktBU0FOIHNoYWRvdyByZWdpb24gd29uJ3QgYmUgbWFwcGVkIGluIEhZUC4gU2VlIGNvbW1pdCBh
NmNkZjFjMDhjYmZlIGZvcg0KPm1vcmUgZGV0YWlscyAoYWxsIHRoZSBhcm02NCBjb21tZW50cyBp
biB0aGlzIHBhdGNoIGFwcGx5IHRvIDMyYml0IGFzIHdlbGwpLg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldy4NCkkgd2lsbCBkaXNhYmxlIHRoZSBpbnN0cnVtZW50YXRpb24gb2YgYXJjaC9hcm0va3Zt
L2h5cCBpbiB0aGUgbmV4dCB2ZXJzaW9uLiANCkp1c3QgbGlrZSB0aGlzOg0KbGl1d2VubGlhbmdA
bGludXg6L2hvbWUvc29mdF9kaXNrL3lvY3RvL2xpbnV4LWdpdC9saW51eD4gZ2l0IGRpZmYNCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9rdm0vaHlwL01ha2VmaWxlIGIvYXJjaC9hcm0va3ZtL2h5cC9N
YWtlZmlsZQ0KaW5kZXggNjNkNmI0MC4uMGE4YjUwMCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2t2
bS9oeXAvTWFrZWZpbGUNCisrKyBiL2FyY2gvYXJtL2t2bS9oeXAvTWFrZWZpbGUNCkBAIC0yNCwz
ICsyNCw3IEBAIG9iai0kKENPTkZJR19LVk1fQVJNX0hPU1QpICs9IGh5cC1lbnRyeS5vDQogb2Jq
LSQoQ09ORklHX0tWTV9BUk1fSE9TVCkgKz0gc3dpdGNoLm8NCiBDRkxBR1Nfc3dpdGNoLm8gICAg
ICAgICAgICAgICAgICAgKz0gJChDRkxBR1NfQVJNVjdWRSkNCiBvYmotJChDT05GSUdfS1ZNX0FS
TV9IT1NUKSArPSBzMi1zZXR1cC5vDQorDQorR0NPVl9QUk9GSUxFCTo9IG4NCitLQVNBTl9TQU5J
VElaRQk6PSBuDQorVUJTQU5fU0FOSVRJWkUJOj0gbg0K
