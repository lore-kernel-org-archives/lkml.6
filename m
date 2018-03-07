Return-Path: <patrice.chotard@st.com>
X-Google-Smtp-Source: AG47ELs7cZ8EKNHpREJqh68JhyLbbgXrmNzDqtlNfWuBd/l+PTnehsMuVji4fzLAxO71ql0hf0cF
ARC-Seal: i=1; a=rsa-sha256; t=1520409597; cv=none;
        d=google.com; s=arc-20160816;
        b=i48vN5wKRcwY4QHYyYEL22TYmUbs/u0Y0dMz3DuDjRcbeXUxrAcowtqMzWO1ocGHbL
         DgqjxfAXhUbGwJ/sFU/kCoCzYG2D5SuXfSgDrwFq9C1NUh03Rt3lde08Kv+5i4ifMV2P
         QgmNMXZOc1aFOS2s5PJUvm5nWEkQqQNaZRrNrqNviWHJyPkmDz6s4YAWtWswJbNn7mtm
         27PwihNNHjYIM/f3RNV0OvjtxyTPN4aPcUepVzY+cNBa1g4gFvZDkJ0cPp+S0bAe+9rR
         RHrts5ng23tXANwLPmg4a7ZJyRJKDmpATm3rMVxd+3a5EbgIZlNFHXABWMg5fQ38QxCf
         LB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:user-agent
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=ANLuNgCN+2nCkBuCtEiIw2+fvFi4VtIo9X4V6f2wWtU=;
        b=BSahkesgyC5vIku0M2Nb/RnYgAzwc9BiodW+GeKaXZvynVq66iDOirM31CWL7J0KfF
         iI4WQBNknSj0OTgx7dfEjkYagjJWmCjglwZiixddiwGEId4t9+eIkE0994AiZKO6aqUI
         gzqtmmBUXwaJPs46FS1cdqeSDrlLRtmFTVze9IkUuoJlEwprAHuyImjg3dsTwXgn+4VJ
         SKCW9MhzlpIOW+LepI3LAdIF6/tvs5J92KfuULT9nTWwFx9JLdGLMnjDfIkKF8thFlou
         kx7U+keLTFSQgzmXk9si6+GgCjWglPQTbxPmJvu8knExY56xA1ewjRycLOiP++RZnvsJ
         FnjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of patrice.chotard@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=patrice.chotard@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of patrice.chotard@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=patrice.chotard@st.com
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi
 boards
Thread-Topic: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi
 boards
Thread-Index: AQHTtSIwRAewgRpMC0CeJ4ZKQf7SW6PDImcAgAE3DIA=
Date: Wed, 7 Mar 2018 07:59:40 +0000
Message-ID: <0bac9e25-0d63-2f11-b54a-0d6282fe19d3@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
 <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
 <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25ACD39E009FC641B2CC558BEC751F24@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594174915380059291?=
X-GMAIL-MSGID: =?utf-8?q?1594265014039105055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUm9iDQoNCk9uIDAzLzA2LzIwMTggMDI6MjYgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBP
biBUdWUsIE1hciA2LCAyMDE4IGF0IDI6MDcgQU0sICA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4g
d3JvdGU6DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+Pg0KPj4gQXMgc2VyaWFsIGludGVyZmFjZSBpcyBhbHJlYWR5IHNwZWNpZmllZCBpbnRvIGJv
b3RhcmdzLA0KPj4gc3Rkb3V0LXBhdGggY2FuIGJlIHJlbW92ZWQuDQo+IA0KPiBXcm9uZyB3YXkg
YXJvdW5kLiBzdGRvdXQtcGF0aCBpcyBwcmVmZXJyZWQgb3ZlciB1c2luZyBjb25zb2xlIGluIGJv
b3RhcmdzLg0KDQpBaCBzb3JyeSwgaSBtaXN1bmRlcnN0b29kIHdoYXQgeW91IHByZXZpb3VzbHkg
c3VnZ2VzdGVkLiBJIHdpbGwgZml4IGl0Lg0KDQpUaGFua3MNCg0KUGF0cmljZQ0KDQo+IA0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNv
bT4NCj4+IC0tLQ0KPj4NCj4+IHYyOiBfIG5vbmUNCj4+DQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRz
L3N0aWg0MDctYjIxMjAuZHRzIHwgMSAtDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAt
YjIxMjAuZHRzIHwgMSAtDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTAtYjIyNjAuZHRz
IHwgMSAtDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0aWg0MTgtYjIxOTkuZHRzIHwgMSAtDQo+
PiAgIDQgZmlsZXMgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1iMjEyMC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9z
dGloNDA3LWIyMTIwLmR0cw0KPj4gaW5kZXggMmM0ZDYwMzNiNDQ4Li4wNzRiNGNkMGNhODkgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDA3LWIyMTIwLmR0cw0KPj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQwNy1iMjEyMC5kdHMNCj4+IEBAIC0xNSw3ICsxNSw2
IEBADQo+Pg0KPj4gICAgICAgICAgY2hvc2VuIHsNCj4+ICAgICAgICAgICAgICAgICAgYm9vdGFy
Z3MgPSAiY29uc29sZT1zZXJpYWwwLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiAtICAg
ICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAmc2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICB9Ow0K
Pj4NCj4+ICAgICAgICAgIG1lbW9yeUA0MDAwMDAwMCB7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvc3RpaDQxMC1iMjEyMC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDEw
LWIyMTIwLmR0cw0KPj4gaW5kZXggNTQyMjg1MDY0MWU4Li5lYWUzMDUwOTg0ZDAgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMTIwLmR0cw0KPj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvc3RpaDQxMC1iMjEyMC5kdHMNCj4+IEBAIC0xNSw3ICsxNSw2IEBADQo+
Pg0KPj4gICAgICAgICAgY2hvc2VuIHsNCj4+ICAgICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAi
Y29uc29sZT1zZXJpYWwwLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiAtICAgICAgICAg
ICAgICAgc3Rkb3V0LXBhdGggPSAmc2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+
ICAgICAgICAgIG1lbW9yeUA0MDAwMDAwMCB7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvc3RpaDQxMC1iMjI2MC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMjYw
LmR0cw0KPj4gaW5kZXggY2EzNDcxNjBlMzVkLi5jMjZlMzg4YmQxYTQgMTAwNjQ0DQo+PiAtLS0g
YS9hcmNoL2FybS9ib290L2R0cy9zdGloNDEwLWIyMjYwLmR0cw0KPj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvc3RpaDQxMC1iMjI2MC5kdHMNCj4+IEBAIC0xNiw3ICsxNiw2IEBADQo+Pg0KPj4g
ICAgICAgICAgY2hvc2VuIHsNCj4+ICAgICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29s
ZT1zZXJpYWwxLDExNTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiAtICAgICAgICAgICAgICAg
c3Rkb3V0LXBhdGggPSAmdWFydDE7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgIG1l
bW9yeUA0MDAwMDAwMCB7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RpaDQx
OC1iMjE5OS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zdGloNDE4LWIyMTk5LmR0cw0KPj4gaW5k
ZXggZGJmN2JiNzA0YTFhLi5kOTQ4Zjc3NGZlZTcgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9zdGloNDE4LWIyMTk5LmR0cw0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3Rp
aDQxOC1iMjE5OS5kdHMNCj4+IEBAIC0xNSw3ICsxNSw2IEBADQo+Pg0KPj4gICAgICAgICAgY2hv
c2VuIHsNCj4+ICAgICAgICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT1zZXJpYWwwLDEx
NTIwMCBjbGtfaWdub3JlX3VudXNlZCI7DQo+PiAtICAgICAgICAgICAgICAgc3Rkb3V0LXBhdGgg
PSAmc2JjX3NlcmlhbDA7DQo+PiAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgIG1lbW9yeUA0
MDAwMDAwMCB7DQo+PiAtLQ0KPj4gMS45LjENCj4+
