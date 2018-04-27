Return-Path: <SZ.Lin@moxa.com>
X-Google-Smtp-Source: AB8JxZoU/wAGxwRzZZXmmUhqEfX+BfSs9eWSKMgZjsYBEAyuouHxIAcGXTyHIrTBgnJEpFmsa0e5
ARC-Seal: i=1; a=rsa-sha256; t=1524795297; cv=none;
        d=google.com; s=arc-20160816;
        b=gYYnxs+imAKT53HWjf3XA4Wvkj/jFg7Zwxp6AhE0VaYbXL3F17/uBhwwx0JGb/RYnX
         Qcuc61cmxY9QZt93AIoibuwn/Ts7nnT7+hpTYiPPK0BypJIfGNXHu3NO6+fchdVlrjN3
         z7o4NyvXq708kyKHb2kCnKshZPqfsCN6Y81NusdUfqQMAlw2N+7EjwMEc91i4HIVbpOd
         pYGnPhmCZcIRxP2e0HmKT8ue2TJ5yH/PHQsoJImw8dBAGfmQpwPr77cz00sh5E+HvJjE
         00bPf+iTD29mroVfGDdREcZ92rU1b9WLspaJaBZi10FrFBRxsxTnfnlcr/NZKNr1fPtG
         ER0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=GQ4P/DA0tF/y7kTOD+ftbJQasYHEmTXDiFbbFiWmxxY=;
        b=KrA4009J0ICrGpRccsef/qbb9u0NFlgf/0Ld+/lfmp+/zq/x6L/2SlXtJBl0C11mb4
         Dso9c9NGS2JNyCmBHVW0825o8R9JAJiJ1a4HWofX7SediNydhrrE0QApjm0M0yKI0Fhi
         FA0scsN1HFHp/hOr54BGdf1/TSc1eJGZsIOScawNywjQyZqHhWhhWRCCxA86CS4e8GVw
         y57RWcp6eubmNmSyl/RhRsyqk7ZC+L/n0VvBACxxBZcXpu2haX9z760s7Tp8VwW7ksPZ
         x8R0ldbm0FOjmEuJyGJFamFAMDUlvfHx7aInhHbcmZ5vIoACQtvEzMh/BxrazUWraR99
         lwkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sz.lin@moxa.com designates 59.124.42.188 as permitted sender) smtp.mailfrom=SZ.Lin@moxa.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sz.lin@moxa.com designates 59.124.42.188 as permitted sender) smtp.mailfrom=SZ.Lin@moxa.com
From: =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>
To: Dan Williams <dcbw@redhat.com>, Johan Hovold <johan@kernel.org>, "Lars
 Melin" <larsm17@gmail.com>
CC: =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>, stable
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB: serial: option: adding support for ublox R410M
Thread-Topic: [PATCH] USB: serial: option: adding support for ublox R410M
Thread-Index: AQHT3VBqImFl/xbkMUuPvnRM0u//G6QSZbMAgAAAZACAAEvqAIAAAseAgAAB8ICAAC2YAIAA+j8Q
Date: Fri, 27 Apr 2018 02:14:55 +0000
Message-ID: <5942081F7727964D830FC876E62CA856014CC36A3F@MHQMBX02.moxa.com>
References: <20180426062831.320-1-sz.lin@moxa.com>
	 <20180426070927.GT4615@localhost>
	 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
	 <20180426081403.GA335@localhost> <87r2n25i6i.fsf@miraculix.mork.no>
	 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
	 <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
	 <20180426161228.GW4615@localhost>
	 <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
	 <20180426162921.GB335@localhost>
 <5fb0b88573985caeb5ce2732ae217f60fbcfe965.camel@redhat.com>
In-Reply-To: <5fb0b88573985caeb5ce2732ae217f60fbcfe965.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.4.141]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598789137647329265?=
X-GMAIL-MSGID: =?utf-8?q?1598863753881246699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PHNuaXA+DQoNCj4gDQo+IE9wdGlvbiBpcyBsaWtlbHkgdGhlIHJpZ2h0IGRyaXZlciBmb3IgdGhp
cyBkZXZpY2UuDQo+IA0KPiBxY2F1eCB3YXMgbWFpbmx5IGZvciBtb2JpbGUgcGhvbmVzIHRoYXQg
aGF2ZSBhIFRUWSAob2Z0ZW4gY2RjLWFjbSkgYXMgdGhlIG1vZGVtIHBvcnQNCj4gYW5kIGEgc2Vj
b25kYXJ5IERJQUcvRE0gcG9ydCBkcml2ZW4gYnkgcWNhdXguICBUaGUgRE0gcG9ydCBkb2Vzbid0
IGhhdmUgYW4gaW50ZXJydXB0DQo+IGVuZHBvaW50IHRodXMgaXQncyBub3QgYSBub3JtYWwgbW9k
ZW0gcG9ydCByZXF1aXJpbmcgdGhlIGxhcmdlciBidWZmZXJzIG9mIG9wdGlvbiBhbmQgaXRzDQo+
IGNvbnRyb2wgc2lnbmFsaW5nLg0KPiANCj4gcWNzZXJpYWwgKGFzIEJqb3JuIG1lbnRpb25lZCkg
aXMgb25seSBmb3IgYWN0dWFsIEdvYmktdHlwZSBkZXZpY2VzIHdpdGggdGhlIHNwZWNpZmljIGxh
eW91dHMNCj4gYW5kIHRoZSBmaXJtd2FyZSBsb2FkaW5nIHJlcXVpcmVtZW50IHdoZXJlIHRoZSAx
SyBhbmQgMksgZGV2aWNlcyBzdGFydCBpbiBhIHNwZWNpYWwNCj4gMS1wb3J0IG1vZGUgd2FpdGlu
ZyBmb3IgZmlybXdhcmUgYW5kIHRoZW4gYmVjb21lIDQtcG9ydCBkZXZpY2VzIG9uIGZpcm13YXJl
IHJlYm9vdC4NCj4gDQo+IERhbg0KDQpUaGFuayB5b3UgYWxsLiBJIGJlbGlldmUgdGhhdCBtYW55
IHBlb3BsZSBhcmUgY29uZnVzZWQgaW4gc2VsZWN0aW5nIHNlcmlhbCBkcml2ZXIgKG9wdGlvbiBh
bmQgcWNzZXJpYWwpIA0KZm9yIFFVQUxDT01NIGJhc2VkIG1vZHVsZS4gVGhpcyB0aHJlYWQgaGFz
IHByb3ZpZGVkIGNsZWFybHkgYW5kIHByb3Blcmx5IHByZXNlbnRlZCB0aGUgZGlmZmVyZW50DQpi
ZXR3ZWVuIHRoZW0uDQoNClNaDQo=
