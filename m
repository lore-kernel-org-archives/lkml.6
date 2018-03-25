Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2861279-1521996255-2-7990312432656695620
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521996255; b=OH5EntTiFV2wSkQdkupoVl9YoM7XPcAxulhIM54uVBh213y
    LEaNWgIfggMUdAA4CyBHh5CqcABwVDvMkD3bR6tqTYpgbTb/4iRwae4tHmZHoJRD
    5ZmgXbmGNVf52D7lc2B7SvubBMsg/ToIu37FWbox6qPkjkBsnWr2Y/0rCjpeq4VC
    1ph9yl2GfMica/ul0pOQsBHqsqRkqbCZN35yYXEzHhlR6bqwHSjsN7jQQKJlKK2B
    cpqhQdPDFAnjKXMfnqRgjjDn5OAsPH4PdGTxBSn9+Bu3bAaeVe6uvokhcd5eJ98O
    gqo+RFuCzy0CT5D3g4pCabYPPx5Hk3TObGhm6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521996255; bh=i
    MRvuayP0hTTU3jRGqJMX58ICIJehc6w6rbLZjaFPtc=; b=wJDXcNWSIP20TdBZI
    Ebp6MTgHY6JZl9vrmf0o42pO0pcCunJxybDx05DFyyj07NEwZ+AwF796mOa6TxWX
    L4bZs/92jBl61ooe/ltanTe2Um4K8ZjgLWP/EvgJxovCl0VHReBK06b+KKNs4g92
    XUUCoB6TiIIhg6E6bLXA8GPkIlJ2Ugv/wzF9S0cCLT8zlldjwUh5WpWcIzNks4g1
    +mkUujT6FTMsAAK9Cbxvphf7gexrhNm2vvld5sQJAiwIQrlluICqeX9IJn/sR/Pc
    AYJXIHxLpgOcLENxxCdSFxwREzo7G/hSgurCZ4mBKzpEU6hPeABmbQwXVksYC8o2
    HaisQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017A121836
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 17:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Message-ID: <20180325174401.43310fc1@archlinux>
In-Reply-To: <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
 <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU2F0LCAyNCBNYXIgMjAxOCAxNjowNjoxNyAtMDcwMApKb2huIFN5bmUgPGpvaG4zOTA5QGdt
YWlsLmNvbT4gd3JvdGU6CgpUaGlzIHRocmVhZCBpcyBiZWNvbWluZyB1bm1hbmFnZWFibGUgc28g
SSBhbSBjcm9wcGluZyB0aGlzIGRvd24gdG8ganVzdAp0aGUgcXVlc3Rpb25zIHRoYXQgcmVtYWlu
IG9wZW4uCgo+ID4+IFByb2JhYmx5IGVhc2llciB0byBjb3B5IGFuZCBwYXN0ZSB0aGlzIHRhYmxl
IGludG8gYSBzcHJlYWRzaGVldC4gTGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgSSBn
b3Qgd3JvbmcuIFRoYW5rIHlvdSBhZ2FpbiBmb3IgYWxsIHlvdXIgaGVscC4gIAo+ID4gWWVhaCwg
d2UgbmVlZCB0byBzaHJpbmsgdGhpcyBpZiB3ZSBkbyBpdCBhZ2Fpbi4gIAo+IEnigJlsbCBzZW5k
IGFuIHVwZGF0ZWQgY29weSBhZnRlciB0aGlzIGUtbWFpbC4gQ2FuIHlvdSBhY2NlcHQgYSBzcHJl
YWRzaGVldCAKPiBhdHRhY2htZW50IG9yIGEgQ1NWIGZpbGU/CldlIG5lZWQgdG8ga2VlcCB0aGUg
ZGlzY3Vzc2lvbiB2aXNpYmxlIG9uIGxpc3Qgc28gaXQgbmVlZHMgdG8gc3RheSBpbgpwbGFpbiB0
ZXh0LiAgSnVzdCBuZWVkIHRvIGRyb3AgYW55IGNvbHVtbnMgd2UgYXJlbid0IGNhcmluZyBhYm91
dCB0byBtYWtlCml0IGVhc2llciB0byByZWFkLgo+ID4gCi4uLgo+ID4+IDB4NDM5QwlDVkFST1MJ
aW5fcG93ZXJyZWFjdGl2ZTBfcGhhc2VDX29mZnNldAkJaW4JcG93ZXJyZWFjdGl2ZQkwCXBoYXNl
QwlvZmZzZXQJUi9XCTI0CTMyIFpQU0UJUwkweDAwMDAwMAlQaGFzZSBDIHRvdGFsIHJlYWN0aXZl
IHBvd2VyIG9mZnNldCBhZGp1c3QgKEFERTc4NTgsIEFERTc4NjgsIGFuZCBBREU3ODc4KS4KPiA+
PiAweDQzOUQJQUZXR0FJTglpbl9wb3dlcjBfcGhhc2VBX2Z1bmRhbWVudGFsX3NjYWxlCQlpbglw
b3dlcgkwCXBoYXNlQV9mdW5kYW1lbnRhbAlzY2FsZQlSL1cJMjQJMzIgWlBTRQlTCTB4MDAwMDAw
CVBoYXNlIEEgZnVuZGFtZW50YWwgYWN0aXZlIHBvd2VyIGdhaW4gYWRqdXN0LiBMb2NhdGlvbiBy
ZXNlcnZlZCBmb3IgQURFNzg1NCwgQURFNzg1OCwgYW5kIEFERTc4NjguICAKPiA+IEhtbS4gRnVu
ZGFtZW50YWwgbmVlZHMgdG8gYmUgcmVwcmVzZW50ZWQgdXNpbmcgYSBzZXBhcmF0ZSBjaGFubmVs
IGluZGV4Cj4gPiBhbmQgZGVzY3JpcHRpb24gb2YgdGhlIGZyZXF1ZW5jeSBmaWx0ZXJzIGFwcGxp
ZWQuICBUaGF0IHNob3VsZCBtYXAgaXQKPiA+IGEgZ2VuZXJpYyB3YXkuICAKPiBIb3cgZG8gSSBk
byB0aGlzPwpEZWZpbmUgYWRkaXRpb25hbCBjaGFubmVscyB3aXRoIGRpZmZlcmVudCBpbmRleCBh
bmQgZm9yIHRoZW0KdXNlIHRoZSB0aGUgaW5mb21hc2sgZWxlbWVudHMKSUlPX0NIQU5fSU5GT19M
T1dfUEFTU19GSUxURVJfM0RCX0ZSRVFVRU5DWSwKSUlPX0NIQU5fSU5GT19ISUdIX1BBU1NfRklM
VEVSXzNEQl9GUkVRVUVOQ1kKYW5kIHByb3ZpZGUgc3VpdGFibGUgdmFsdWVzIGZyb20gdGhlIHJl
YWRfcmF3IGNhbGxiYWNrcyBmb3IgdGhhdApjaGFubmVsLgoKLi4uCj4gPj4gMHg0M0MwCUFJUk1T
CWluX2N1cnJlbnQwX3BoYXNlQV9ybXMJCWluCWN1cnJlbnQJMAlwaGFzZUFfcm1zCQlSCTI0CTMy
IFpQCVMJTi9BNAlQaGFzZSBBIGN1cnJlbnQgcm1zIHZhbHVlLiAgCj4gPiBpbl9jdXJyZW50MF9w
aGFzZUFfcm1zX3JhdyBhcyBvdGhlcndpc2Ugd2UgZG9uJ3Qga25vdyB3ZSBuZWVkIHRvIGFwcGx5
Cj4gPiBpbl9jdXJyZW50MF9waGFzZUFfcm1zX3NjYWxlIHRvIGl0IChvciB0aGUgc2hhcmVkIHZh
bHVlIHRoYXQgbWFwcyB0byB0aGF0KS4gIAo+IFllYWgsIHRoaXMgaXMgc3RpbGwgY29uZnVzaW9u
IHRvIG1lLiBUaGlzIHNob3VsZCByZWFkIGluX2N1cnJlbnQwX3BoYXNlQV9ybXNfZ2FpbiAKPiBh
cyBpdCBkaXJlY3RseSBhZmZlY3RzIHRoZSB2YWx1ZSBpbl9jdXJyZW50MF9waGFzZUFfcm1zX3Jh
dy4gV2Ugc3RpbGwgaGF2ZSB0byBhcHBseQo+IGEgc2NhbGUgdmFsdWUgdG8gdHVybiB0aGlzIGNy
eXB0aWMgbnVtYmVyIGludG8gc29tZXRoaW5nIG1lYW5pbmdmdWwuIApTbyBJJ20gYSBsaXR0bGUg
bG9zdC4gV2UgaGF2ZSB2YXJpYWJsZSBnYWluIGZpbmUuCkRvZXMgaXQgZWZmZWN0IHRoZSBuZWNl
c3Nhcnkgc2NhbGUgZmFjdG9yIHRvIGdvIGZyb20gcmF3IHRvIHJlYWwgdmFsdWUgb3Igbm90Pwox
KSBZZXMgaXQgZG9lcyAtIHRoZW4gcm9sbCBpdCBhcyBhcHByb3ByaWF0ZSBpbnRvIHRoZSBfc2Nh
bGUgYXR0cmlidXRlLiAKICAgSXQgc2hvdWxkIG5vdCBiZSBzZXBhcmF0ZWQuICBUaGlzIG9mdGVu
IHJlcXVpcmVzIHNvbWUgaW50ZXJlc3RpbmcgbWF0aHMKICAgYnV0IGlzIGEgb25ldGltZSB0aGlu
ZyBhcyB0aGUgdmFsdWUgaXNuJ3QgY2hhbmdpbmcgZHluYW1pY2FsbHkuCgoyKSBObyBpdCBkb2Vz
bid0IC0gdGhlbiBpdCBpcyBjYWxpYmdhaW4gYXMgaXQgcmVwcmVzZW50cyBhIG5lY2Vzc2FyeQog
ICBwYXJhbWV0ZXIgdG8gY2hhbmdlIHRoZSBpbmNvbWluZyBjaXJjdWl0IHRvIGNvbXBlbnNhdGUg
Zm9yIGV4dGVybmFsIGVmZmVjdHMuCgpJdCBpcyBwb3NzaWJsZSB5b3UgaGF2ZSBhIG1peHR1cmUg
b2YgdGhlIHR3byBhbmQgaGVuY2UgbmVlZCBib3RoIGJ1dCB0aGF0CmlzIG5vcm1hbGx5IG9ubHkg
dGhlIGNhc2Ugd2l0aCBkZXZpY2VzIHdoZXJlIHRoZSBjYWxpYmdhaW4gaXMgYWJvdXQgZml4aW5n
CnRoZSBmYWN0b3J5IGNhbGlicmF0aW9uLgoKLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRldmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZl
cnByb2plY3Qub3JnCmh0dHA6Ly9kcml2ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaXZlcmRldi1kZXZlbAo=
