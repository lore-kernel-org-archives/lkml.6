Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AIpwx49B3y6klfj52dddVSC8Kr99EwMoGDEnckY+rrn0vLDGzP3zl2/MxCEtNKlUv6+3s5ILogO3
ARC-Seal: i=1; a=rsa-sha256; t=1521715207; cv=none;
        d=google.com; s=arc-20160816;
        b=Z9BlFmRDIIhLuyKc/MRMPNvDGdtaH8hL8xrkKd8dvlzVRFTsw0tXtBrYgHATFsU7KY
         QtIdC7XaDjp92hCNFclH8McHK8U7g8kb4jMobX7gUBzr2VzIGhosUVoLhlUEEIwWVd8G
         rrB+AP5fbDyllRZTErdm9LGmF2FQxKNYqF1au/QqOuTsigByfFeOcn2uF6FNVrm4JVGO
         HLdrRiYK8u+hR+DUCUdZt2S89o45ts8swq0FDW4F1ZcQHff0beBlUhieyEom7nj01Shs
         Ljs7OPwIHl/lUw+eaB20ol/lbdo6nGqzSlLhqHwv6dl3x0YJCD+aMSBhdzqgv3p4zorI
         c3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=zWtDNQskgUcpW+VBMwry0/vgZqUqEPPsNgXP+L1WmrI=;
        b=cDXxuKg2HuG/q+Pd9dJjoGwZJJIYrFsHmGkbys0e5l7Z4wEBNamxPnVOaUcCm3PHFQ
         6GcDenhGJrdPWuUYHNriDogWri0rJOF3fCnwemcAGaEJBTn1DmCgWfBUse3lY9m0//1i
         NvsCUXwNckxAogxwoDN/trc0oohidOSOSWPTwWqKQwEWmqpwH1/zZP6DHGaK7bjFyMWa
         2cRFKM4G1mUQvjLVhKqZtDdCKQ58cC1coIrE3LpMsATSeygf0qJrkFllXBVXrc9mQ+aR
         DGIgg7TMRg7IqZA9NxntD5VtbJ3Nq4YA9ff6TqPjmPc9AyrQI19uIVWSo/0O0E0AwWji
         Qe7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.4 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.4 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSXUzTYBiF/dau64BqGVv2OUHjIhoxG8xpKBo
  DGi92pUgMGDRqgcIWR1nWEYdXEAPKDDCDSjb/QAQikAADwwB/kQwR428U5YJoQIIwgQjRC5C4
  rkGwV0+/c877nosXR2QLYhXO2G2MlaXNaiwEPdlVp9cgF9vT4yZ7tdT52haM8vdXiShHUxdKf
  fSViaj33Tcwaq6sD1B36osRaqzmpYga7LElSQ2exlLMcGvgiOHxzWaJoW3aKzLMPPqAGbp+F0
  oMc56NyZJ0sYnNyLOfFhs7+kcwSwNhfzqaVQichAOE4DKyDsCytqvAAaQ4RlKw8vkXjBfkZL0
  IjkyPB38QcgrAzgsLQVcEmQr/TLeIeZaTaXDxoUsi8B44c30G4Rklo6HnshPjmSCTYe2sXyKs
  Gwbw2+ySiBekZBJ803gvOBSQUXC+qCkYRkglHB67HfRAkoR3H7xGBFbA76NLYoE3wc5fCxKBE
  +HUyDTqAHiAY2F5ESc862DjtSeowPGwot2L8BaE3A5bumOFTZvhlUtfJULNcDjgGkOdQOleVc
  K9knCvSrhXJaoB2ggSMqymHKMtlzaZNbq4OI1Op9foNTvjErT0OQ2tZfI1mQxrs9IBVUuf5bR
  cQW6mOUvLMjYPCJzAmsDnBc5euhesx0VqBfFzwpMuW5uRl1VgpDnjKWu+meF6QSSOqyFRW9Ke
  Lgu3MjmMPdtkDtzRsgzxMLWciOFlgrPQuZwpR5BeAD3+aWKqBME76v0liAxl81hGpSQaeCvJW
  4357L9Byzf5DkSpIggQqCYLszDWXJPtf30SKHGgjiC8/JQwE2v7t28yUEUUqHLG1cpXsdErkq
  oQcFeJRJ9+SCkfSL2f0rXt17rxoUPZio0H3sbvlz8LrVYVtFtCS30FKc3DUnQvEl4n5zKlYeX
  boxYV+xy7LRW7DJ/lx3Wp14/dOnHIvyX7xyuf4+DRedfhqjQWbFX4e3T7B5P7IluLQlN2tFp+
  O+crsEc10VdqyOhixLtBUTlQpUY5I62LQawc/Rc7CXUqjgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-223.messagelabs.com!1521715203!616515!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "Hans de
 Goede" <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v5 4/5] typec: tcpm: Represent source supply through
 power_supply
Thread-Topic: [PATCH v5 4/5] typec: tcpm: Represent source supply through
 power_supply
Thread-Index: AQHTwFh0VGOBBYP06UyoQdAV+SCwnaPbpmOAgABr6JA=
Date: Thu, 22 Mar 2018 10:40:01 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <510c0897961f234daca295b273bf4e5047498c55.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
In-Reply-To: <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 22/03/2018 04:27:00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467553265971470?=
X-GMAIL-MSGID: =?utf-8?q?1595634046124126815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMjIgTWFyY2ggMjAxOCAwNDowOSwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgaW50IHRjcG1fcHN5X3NldF9wcm9wKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwNCj4gPiAr
CQkJICAgICBlbnVtIHBvd2VyX3N1cHBseV9wcm9wZXJ0eSBwc3AsDQo+ID4gKwkJCSAgICAgY29u
c3QgdW5pb24gcG93ZXJfc3VwcGx5X3Byb3B2YWwgKnZhbCkNCj4gPiArew0KPiA+ICsJc3RydWN0
IHRjcG1fcG9ydCAqcG9ydCA9IHBvd2VyX3N1cHBseV9nZXRfZHJ2ZGF0YShwc3kpOw0KPiA+ICsJ
aW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChwc3ApIHsNCj4gPiArCWNhc2UgUE9X
RVJfU1VQUExZX1BST1BfT05MSU5FOg0KPiA+ICsJCXJldCA9IHRjcG1fcHN5X3NldF9vbmxpbmUo
cG9ydCwgdmFsKTsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgUE9XRVJfU1VQUExZX1BST1Bf
Vk9MVEFHRV9OT1c6DQo+ID4gKwkJaWYgKCh2YWwtPmludHZhbCA8IChwb3J0LT5wcHNfZGF0YS5t
aW5fdm9sdCAqIDEwMDApKSB8fA0KPiA+ICsJCSAgICAodmFsLT5pbnR2YWwgPiAocG9ydC0+cHBz
X2RhdGEubWF4X3ZvbHQgKiAxMDAwKSkpDQo+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJ
ZWxzZQ0KPiA+ICsJCQlyZXQgPSB0Y3BtX3Bwc19zZXRfb3V0X3ZvbHQocG9ydCwgKHZhbC0+aW50
dmFsIC8gMTAwMCkpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBQT1dFUl9TVVBQTFlfUFJP
UF9DVVJSRU5UX05PVzoNCj4gPiArCQlpZiAodmFsLT5pbnR2YWwgPiAocG9ydC0+cHBzX2RhdGEu
bWF4X2N1cnIgKiAxMDAwKSkNCj4gPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiArCQllbHNlDQo+
ID4gKwkJCXJldCA9IHRjcG1fcHBzX3NldF9vcF9jdXJyKHBvcnQsICh2YWwtPmludHZhbCAvIDEw
MDApKTsNCj4gDQo+IEkgYW0gcmVhbGx5IG5vdCBhIGZyaWVuZCBvZiBleGNlc3NpdmUgKCApLg0K
DQpZZXMsIEkgZ290IHRoYXQuIDopIEkgYW0gb2YgdGhlIG9waW5pb24gdGhhdCB0aGV5IHNob3Vs
ZCBiZSB1c2VkIHRvIGVuZm9yY2UNCnByZWNlZGVuY2UuIFRoaXMgdG8gbWUgaXMgZ29vZCBjb2Rp
bmcgcHJhY3RpY2UgYW5kIG1ha2VzIGl0IHVuYW1iaWd1b3VzIGZvciB0aGUNCnJlYWRlci4gVGhh
dCdzIHdoeSBJIHVzZSB0aGVtIGFzIGFib3ZlLiBEbyB5b3UgdGhpbmsgdGhlIGFib3ZlIHVzZXMg
bWFrZSBpdA0KaGFyZGVyIHRvIHVuZGVyc3RhbmQgb3IgbW9yZSBkaWZmaWN1bHQgdG8gbWFpbnRh
aW4/DQo=
