Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3537408-1525819309-2-7993040103371646014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525819308; b=mS83TVOO1SighKOJVzJYDeAN4YK8VRW81XfqmAQa5BmHhmJxdo
    yPgk9p6z9fUKF6n2glWk+/pRCKhwWE3N9a3792DdP10Ma34J+hI0/ddllnsfQ37K
    ynZHaGtSocN8KfYrBhY0FF+cRpkEA/yegwgTL9g9R/DRLgoOs5vicLTT4TPCahhv
    zcnktSieaPe9Be0IAH55i39lA75HabmcnaqlEuh46YzqgQzjdLeAg7twvl0jEfjZ
    Th/IX9cIW0gGeIfKE9KNqHz5gkIYtPDrWTrI5N+a3Z8so87WF5eQxv+QZHpboI+o
    hk2R+qzRUfrX9HSgS+RF/Madii160wA617Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:date:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525819308; bh=66nfy
    /g9WJVf3SDThey33APwV+ZO3Vu1G+0p/Z/0Uoo=; b=bzjeBk12PMXwZG+0sWlmr
    P8/EcmN1JRdNgEk110FN2l1ExYJ+dJbHpRb7o66ovcIFkoWLtejbbaCBrmlPxJfS
    qJ266m3jn+GZq+HbB4SxzLLwRxV0R7/eqZSE9y4kZ0juud6jZ5P9FsebePOvm6uR
    64yZWNZKM3asLUSypawoYF+QrmIDEMnf5rCD/2BL7lPXHLsi2eHkim+60kK61OQF
    qP67mdngy3BSxMmCXn1CjzgTVHWKmD5Sxq2JwT0u+LXQFB7MU91/aeGo4U0NEG0e
    ThzO3Sxkevzdvdx0zZXJSKecukboJnFKFfVFXe8vYB0WmLofV840D0fRCAI0gMBK
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=hansenpartnership.com header.i=@hansenpartnership.com
    header.b=GCtqioUB x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=hansenpartnership.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=hansenpartnership.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=hansenpartnership.com header.i=@hansenpartnership.com
      header.b=GCtqioUB x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20151216;
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=hansenpartnership.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=hansenpartnership.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCujSzCVxnpXNm6H8f/3nCqKZhAHh7JNKWTrZs2u85A6P0pCGgwR5xAmaSD2zFjHC24L9szJsDHE+ExMF2wZtYJiJ+zleTy1/64qP3J5uP0vmgw7rduX
    kYUJwcyusU4PICBxAqnynoLfOBmdGdn4uNL21k6JpAv1TGDgCP7uCoM+/C1silLZBOp+UGA0AhLpdGhQPSSSbUTuVOJMLhY5ODTAp8uymIT/t5gIvbITfrSq
    q/yuUVpL3XfKQp97mMxfBg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=Si8D3kuRNIGzquobSMMA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Message-ID: <1525819297.13798.3.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>, David Lang <david@lang.hm>
Date: Tue, 08 May 2018 15:41:37 -0700
In-Reply-To: <20180508214339.GE8514@sasha-vm>
References: <20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
	<20180508202912.GC8514@sasha-vm>
	<CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
	<20180508205505.GD8514@sasha-vm>
	<alpine.DEB.2.02.1805081357451.31825@nftneq.ynat.uz>
	<20180508214339.GE8514@sasha-vm>
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTA4IGF0IDIxOjQzICswMDAwLCBTYXNoYSBMZXZpbiB2aWEgS3N1bW1p
dC1kaXNjdXNzCndyb3RlOgo+IE9uIFR1ZSwgTWF5IDA4LCAyMDE4IGF0IDAxOjU5OjE4UE0gLTA3
MDAsIERhdmlkIExhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIDggTWF5IDIwMTgsIFNhc2hhIExldmlu
IHdyb3RlOgo+ID4gCj4gPiA+IFRoZXJlJ3Mgbm8gb25lLCBmb3IgZXhhbXBsZSwgd2hvIHBpY2tl
ZCB1cCB2YW5pbGxhIHY0LjE2IGFuZAo+ID4gPiBwbGFucyB0byBrZWVwIHVzaW5nIGl0IGZvciBh
IHllYXIuCj4gPiAKPiA+IEFjdHVhbGx5LCBhdCBhIHByaW9yIGpvYiBJIHdvdWxkIGRvIGFsbW9z
dCBleGFjdGx5IHRoYXQuCj4gPiAKPiA+IEkgbmV2ZXIgaW50ZW5kZWQgdG8gZ28gYSB5ZWFyIHdp
dGhvdXQgdXBkYXRpbmcsIGJ1dCBpdCB3b3VsZCBoYXBwZW4KPiA+IGlmwqAgbm90aGluZyBjYW1l
IHVwIHRoYXQgd2FzIHJlbGF0ZWQgdG8gdGhlIGhhcmR3YXJlL2ZlYXR1cmVzIEkKPiA+IHdhc8Kg
cnVubmluZy4KPiA+IAo+ID4gc28gJ25vIG9uZSB1c2VzIHRoZSBMaW51cyBrZXJuZWwgaXMgZmFs
c2UuCj4gCj4gTXkgcG9pbnQgaXMgbm90IHRoYXQgIm5vIG9uZSBldmVyIHVzZXMgTGludXMga2Vy
bmVsIiBidXQgdGhhdCBubyBvbmUKPiB0YWtlcyBvbmUgb2YgdGhvc2Uga2VybmVscyBhbmQgcGxh
bnMgdG8gc3RpY2sgd2l0aCBpdCBmb3IgMyBtb250aHMKPiB1bnRpbCB0aGUgbmV4dCBvbmUgY29t
ZXMgdXAsIGV2ZW4gaWYgdGhlcmUgYXJlIHVwZGF0ZXMgcmVsZXZhbnQgdG8KPiB0aGF0IHVzZXIu
LgoKQWN0dWFsbHksIEkgaGF2ZSBzb21ldGltZXMgZG9uZSB0aGF0LiAgTXkgY3VycmVudCBsYXB0
b3AgaXMgcnVubmluZyB0aGUKdjQuMTYgdGFnIG5vdywgbm90IGJlY2F1c2UgSSBpbnRlbmRlZCB0
byBydW4gaXQgZm9yIHRoaXMgbG9uZyBidXQKYmVjYXVzZSBJJ3ZlIHJ1biBpbnRvIGEgUm91bmQg
VHVpdCBzaG9ydGFnZSBhcyBmYXIgYXMgdGhlIC1yYwpjYW5kaWRhdGVzIGdvLgoKPiBZZXMsIHNv
bWUgdXNlcnMgd2lsbCB1c2UgYSAuMCByZWxlYXNlIHVudGlsIGVpdGhlciBHcmVnIHJlbGVhc2Vz
IGEKPiAtc3RhYmxlLCBvciB1bnRpbCB0aGUgbmV4dCAtcmMgaXMgb3V0Lgo+IAo+IFdoYXQgSSdt
IHRyeWluZyB0byBzYXkgaXMgdGhhdCB0aGVyZSBpcyB0aGF0IHRoZSAuMCByZWxlYXNlIG1ha2Vz
Cj4gc29tZSBwZW9wbGUgcnVzaCBwb29ybHkgdGVzdGVkIGNvbW1pdHMgaW4gaXQgZXZlbiB0aG91
Z2ggdGhlIC4wCj4gcmVsZWFzZSBpcyBub3Qgc2lnbmlmaWNhbnQgaW4gYW55IHdheS4KCkFzIGEg
bWlsZXN0b25lLCBpdCdzIGV4dHJlbWVseSBzaWduaWZpY2FudCBiZWNhdXNlIGl0J3MgdGhlIGNh
ZGVuY2UKZnJvbSB3aGljaCBldmVyeXRoaW5nIGVsc2UgZmxvd3MuICBJZiB3ZSBhcyBkZXZlbG9w
ZXJzIHN0b3AgdGFraW5nIHRoZQotcmMgY3ljbGUgc2VyaW91c2x5LCB5b3UnbGwgZmluZCBpbW1l
ZGlhdGUgbmVnYXRpdmUgY29uc2VxdWVuY2VzIGZvcgp5b3VyIHN0YWJsZSBrZXJuZWxzLiAgQW5k
IEkgbWVhbiB3YXkgd29yc2UgY29uc2VxdWVuY2VzIHRoYW4gdGhlIG9kZApiYWQganVkZ21lbnQg
Y2FsbCBhYm91dCBhIHBhdGNoIHRoYXQgb3VnaHQgbm90IHRvIGhhdmUgZ29uZSBpbiByaWdodApi
ZWZvcmUgYSBMaW51cyByZWxlYXNlLgoKSmFtZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCktzdW1taXQtZGlzY3VzcyBtYWlsaW5nIGxpc3QKS3N1bW1p
dC1kaXNjdXNzQGxpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8va3N1bW1pdC1kaXNjdXNzCg==
