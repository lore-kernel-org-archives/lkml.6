Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2931836-1525371032-2-9108779542376298954
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
    1525371031; b=K7pzd00aeAOF8iiUToVum9y5lrdkhdInTmQddXppev/O8Y/wXn
    Fm8fkmFZbOgz8TM9/jTZz/FIn7Yi5ZVCNRR2tBfDzVNBuHYQgXw2VicO5PuWaSzy
    SQXIIy0pfsO22B2T3YCOkhsmXyCBbG1mbWUi4MrgnE8/lsS/xgkff2HKcIWefFar
    fmlRJkMRKLHkV0F4bze4FZMxw4OsGsAtKjlMito5F3CCHeUSQ8VbGR73lQ/2zPeV
    ZAgjjRSAuSXQdaQDrB4nvTVJcWCJiIk+ElKzm7sqE6lxPX9rSMX214Nnf8QkmTc+
    tsb8hCYXtiiOJy0MWMaQls+MSSsSuyGaDqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:date:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525371031; bh=mNjaA
    74LlfUaST2L3npNyXvgbqShmgZfS6W80SKx6vM=; b=CstGSFTpBSEBPeqRaqQi1
    PRM97qDpSGCiLEHbWHldUvdvSVjFaIUD1dL/tDccnSzmSL13YNCQkKumX3/R8Sx4
    w36MIGOsheSm0JsOe5TqBXBBlgvGo2zZdqqOiYalb48MioNjuBQc44GFMoxOQe1t
    Gb46cdVM7vUyKIcLRoabdbR0S8Eiq/MyyqP1Bg855u3XLUfOZ6H2sCl7egBSj/hR
    Ay4Z/Fgf5e5djMDnzdUTxpsqb6IAI5jH1r721pNIY2J6TCY6vvr6s/DdXI0eyqvT
    rcoS9rRQMTbicTUVCISLONz25G+V7WqwAvD3a7NI3qBLhWkVUntxUsCMKg0I+4T+
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=hansenpartnership.com header.i=@hansenpartnership.com
    header.b=pczyXUei x-bits=1024 x-keytype=rsa x-algorithm=sha256
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=hansenpartnership.com header.i=@hansenpartnership.com
      header.b=pczyXUei x-bits=1024 x-keytype=rsa x-algorithm=sha256
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
X-CM-Envelope: MS4wfE8OE8Wl7WKWhWI3gunURITbTRPlez0RXqeXVTL8/PmUJB/IJ4y3iQuXG0ngcWMIgQsdNgXfkVmwa3c0llggE3B6Aqolr+Vlle8ePk4jIBuAxhaAUq5N
    NXorb8ojf/wZ//BjsZBc61q4yt79KmrHetGBcvdaEcr0/2WSh43tDuqsIA41cEv7yGRFYxgr/K5APInkVwD2yj94Vthrt44OE/7VwOn1BshauJpr5Krg2Wkm
    P9mQ1ISlA2YLTgXbO1hIZA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=3gDBaSajH8Mv9S90I38A:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Message-ID: <1525371022.3225.22.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Date: Thu, 03 May 2018 11:10:22 -0700
In-Reply-To: <20180503154342.GN18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
	<1525357984.3225.12.camel@HansenPartnership.com>
	<20180503144850.GC23311@1wt.eu> <20180503150608.GM18390@sasha-vm>
	<1525361268.3225.17.camel@HansenPartnership.com>
	<20180503154342.GN18390@sasha-vm>
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

T24gVGh1LCAyMDE4LTA1LTAzIGF0IDE1OjQzICswMDAwLCBTYXNoYSBMZXZpbiB2aWEgS3N1bW1p
dC1kaXNjdXNzCndyb3RlOgo+IE9uIFRodSwgTWF5IDAzLCAyMDE4IGF0IDA4OjI3OjQ4QU0gLTA3
MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKWy4uLl0KPiA+IEl0J3MgYWxzbyBhIHNhZCBmYWN0
IHRoYXQgYSBsb3Qgb2YgdGhpbmdzIHdoaWNoIGxvb2sgbGlrZSBvYnZpb3VzCj4gPiBmaXhlcyBh
Y3R1YWxseSB0dXJuIG91dCBub3QgdG8gYmUgc28gd2l0aCBsYXRlciB0ZXN0aW5nLsKgwqBUaGlz
IGlzCj4gPiB3aHkgdGhlIHVzZXIgdmlzaWJpbGl0eSB0ZXN0IGlzIHBhcmFtb3VudC7CoMKgSWYg
YSBidWcgZml4IGhhcyBubwo+ID4gcmVhbCB1c2VyIHZpc2libGUgZWZmZWN0cywgaXQncyBvZnRl
biBiZXR0ZXIgdG8gZGVmZXIgaXQgbm8gbWF0dGVyCj4gPiBob3cgb2J2aW91cyBpdCBsb29rcywg
d2hpY2ggaXMgd2h5IHRoZSBzdGF0aWMgY29kZSBjaGVja2VycyBvZnRlbgo+ID4gZ2V0IHNob3J0
IHNocmlmdCBiZWZvcmUgYSBtZXJnZSB3aW5kb3cuCj4gPiAKPiA+IEEgc2NyaXB0IG1lYXN1cmlu
ZyB1c2VyIHZpc2liaWxpdHkgd291bGQgYmUgbmljZSwgYnV0IGxvb2tzIGEgYml0Cj4gPiBjb21w
bGV4IC4uLgo+IAo+IEl0IGlzLCBidXQgSSB0aGluayBpdCdzIHdvcnRod2hpbGUuIFdvdWxkIHNv
bWV0aGluZyB0aGF0J2xsIHNob3cgeW91Cj4gdGhpbmdzIGxpa2U6Cj4gCj4gwqAtIEhvdyBsb25n
IGEgcGF0Y2ggaGFzIGJlZW4gaW4gLW5leHQ/Cj4gwqAtIEhvdyBtYW55IHJlcGxpZXMvcmV2aWV3
cy9jb21tZW50cyBpdCBnb3Qgb24gYSBtYWlsaW5nIGxpc3Q/Cj4gwqAtIERpZCB0aGUgMGRheSBi
b3QgdGVzdCBpdD8KPiDCoC0gRGlkIHN5emJvdCBmdXp6IGl0PyBmb3IgaG93IGxvbmc/Cj4gwqAt
IElmIGl0IHJlZmVyZW5jZXMgYSBidWd6aWxsYSBvZiBzb21lIHNvcnQsIGhvdyBtYW55Cj4gwqDC
oMKgY29tbWVudHMvcmV2aWV3cy9ldGMgaXQgZ290IHRoZXJlPwo+IMKgLSBJcyBpdCAtc3RhYmxl
IG1hdGVyaWFsLCBvciBkb2VzIGl0IGZpeCBhIHJlZ3Jlc3Npb24gaW4gdGhlIGN1cnJlbnQKPiDC
oMKgwqBtZXJnZSB3aW5kb3c/Cj4gwqAtIElmIHN1YnN5c3RlbSBoYXMgY3VzdG9tIHRlc3Rpbmcg
cmlnLCByZXN1bHRzIGZyb20gdGhvc2UgdGVzdHMKPiAKPiBiZSBhIHN0ZXAgaW4gdGhlIHJpZ2h0
IHdheT8gaXMgaXQgc29tZXRoaW5nIHlvdSdkIHVzZSB0byBtYWtlCj4gZGVjaXNpb25zIG9uIHdo
ZXRoZXIgeW91J2QgdGFrZSBhIHBhdGNoIGluPwoKQWN0dWFsbHksIG5vLCB0aGVzZSBhcmUgYWxs
IG5vdCB3aGF0IEknbSB0YWxraW5nIGFib3V0OiAgVGhleSdyZSBhbGwKbWVhc3VyZXMgb2Ygd2hl
dGhlciB0aGUgY29tbWl0IHRyaWdnZXJzIGFub3RoZXIgYnVnLiAgV2hpY2gsIEkgYWdyZWUsCmlz
IHRoZSBmZWFyLCBzbyBpdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgdGhlbSBvZiBjb3Vyc2UsIGJ1
dCB0aGV5IGFsbAp0YWtlIHRpbWUgdGhlIG1haW50YWluZXIgZG9lc24ndCBoYXZlIHdoZW4gbWFr
aW5nIGEgcXVpY2sgZGVjaXNpb24KYWJvdXQgYSBsYXRlIC1yYyBidWcgZml4LgoKQXQgbGF0ZSAt
cmMgdGhlIGRlY2lzaW9uIGlzIHRoZSBjdXJyZW50IHVzZXIgdmlzaWJsZSBwcm9ibGVtIHNldAph
Z2FpbnN0IHRoZSByaXNrIG9mIC1yYyBkZXN0YWJpbGl6YXRpb24uICBZb3UncmUgbWVhc3VyaW5n
IHRoZSBsYXR0ZXIKaW4gdGhlIGFib3ZlLCBidXQgaW4gdGhlIHJ1bGUgb2YgdGh1bWIgZGVjaXNp
b24gbWFraW5nIHdlIGp1c3QgYXNzdW1lCnRoYXQncyBjb25zdGFudC4gIFdoYXQgd2UncmUgbG9v
a2luZyB0byBtZWFzdXJlIGlzIHRoZSB1c2VyIHZpc2libGUKZWZmZWN0IG9mIG5vdCBmaXhpbmcg
dGhlIHByb2JsZW0uCgpTbywgZm9yIGluc3RhbmNlLCBhIGJvb3QgZmFpbHVyZSBvbiBhIHdpZGVs
eSB1c2VkIFNDU0kgYm9hcmQgaXMgYSBubwpicmFpbmVyIGZvciBmaXggbm93IGFuZCB0YWNrbGUg
Y29uc2VxdWVuY2VzIGxhdGVyLiAgQW4gb2J2aW91cyBmaXggdG8KYW4gZXJyb3IgbGVnIG9mIGEg
bGl0dGxlIHVzZWQgYm9hcmQgaXMgdGhlIG90aGVyIHdheTogbm8tb25lIGlzIHJlYWxseQphZmZl
Y3RlZCwgc28gd2UgZG9uJ3QgdGFrZSB0aGUgcmlzay4gIFRoZSBqdWRnbWVudCBjYWxsIGlzIHRo
ZSBzcGVjdHJ1bQppbiBiZXR3ZWVuIHRoZXNlIHR3byBleHRyZW1lcy4KCkphbWVzCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpLc3VtbWl0LWRpc2N1c3Mg
bWFpbGluZyBsaXN0CktzdW1taXQtZGlzY3Vzc0BsaXN0cy5saW51eGZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tzdW1taXQt
ZGlzY3Vzcwo=
