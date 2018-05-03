Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2687911-1525361279-2-6560502544193777997
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
    1525361278; b=Og9LGJ4Rvf1bZcv8sJG5K5R9KW3zXWI5BEKs3zCup9K0UkDzck
    swipeZ27Q5x9aIn21SxlTAF/LFYBxMEHqSnnupFOnbp950aqYU+gAAETTu9JvpXX
    dpcGpOOa218R/vZ26et4ERIZtVmTE/w11DUCIZRZhUkGhvyLnZA4Oed/ujrX7E1o
    qKW6n2bswmTUl7O2wIDBAMkm2ldfoT5XNAQv0V8n+hSqpf9NTAybIFWT0sJ/ZBLk
    3VoZEtTtPLorBzKanJj85WymN59Y+ipFtZ9LoKOT2Pxo0Yn6zKF/STcrxwhRhNgr
    82Wlsm9VVJRwQm2V9mpFa2d2p2SmCDlUPblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:date:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525361278; bh=VsQXF
    HiSQK1WNLz5lYvMQuXu0ej1uKB4LvLAvjRtGLI=; b=LveIUI/U+8Kw31kz3d6Oa
    RBr7abe6pbPEMciFEF4fPluP0FaSfvOE+SjMWa0dullKrW1KNTlScu9JS+57ukQG
    auiA3A+r1rsGRfMyGREK74hzo7rBkUvC79gChV8d9BPBCW8HYtVtmuGsC7H/atZd
    42faZZVisfne7GhrwH4VlzlFQ3/cP4u7RanfIEuGykrZhYS9VvNIsMclIN68Q3f7
    elGrQtiWm5re9onXbbw22J7xxvIpklJ8YQu26uOjYZW+yb15zLeDwLLM1mUPiZ/d
    VufTRPmUICLcn7HxCywMg2KFYdAaGpx8x00MVPqe3NvkougRZjapOSJhGzUTkfYj
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=hansenpartnership.com header.i=@hansenpartnership.com
    header.b=gnfRuMVY x-bits=1024 x-keytype=rsa x-algorithm=sha256
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
      header.b=gnfRuMVY x-bits=1024 x-keytype=rsa x-algorithm=sha256
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
X-CM-Envelope: MS4wfBRbEzYf6lAlLkGpve+3LOPDrSUut/WlsbPshYT//qYtubGJfjYg3sMTFp8ugrprxVGN5VHsguvs2VEKDpAmaMk2Gxl8Oq7XaS/AvopVSSzSjFQpzISX
    fGeu0G4K6ERA9ctQgFfZofW1GMtFPQUAb8pOE7CKlb9ImTdObNA8zTnqJtJsO16HmH0lemZQqfO+MVhkydLxgkYc50TT4GjutqHZ96S4me71mwkoouef9oSz
    k7InlKfDvB9ZQaia/5f7Ww==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=oegzBmWK145t3pjcEiQA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Message-ID: <1525361268.3225.17.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>, Willy Tarreau <w@1wt.eu>
Date: Thu, 03 May 2018 08:27:48 -0700
In-Reply-To: <20180503150608.GM18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org> <877eol808s.fsf@intel.com>
	<1525357984.3225.12.camel@HansenPartnership.com>
	<20180503144850.GC23311@1wt.eu> <20180503150608.GM18390@sasha-vm>
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
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

T24gVGh1LCAyMDE4LTA1LTAzIGF0IDE1OjA2ICswMDAwLCBTYXNoYSBMZXZpbiB2aWEgS3N1bW1p
dC1kaXNjdXNzCndyb3RlOgo+IE9uIFRodSwgTWF5IDAzLCAyMDE4IGF0IDA0OjQ4OjUwUE0gKzAy
MDAsIFdpbGx5IFRhcnJlYXUgd3JvdGU6Cj4gPiBPbiBUaHUsIE1heSAwMywgMjAxOCBhdCAwNzoz
MzowNEFNIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4gPiA+IFRoZXkncmUgZGVmaW5p
dGVseSBmb3IgYnVnIGZpeGVzLCBidXQgdGhlcmUncyBhIHNwZWN0cnVtOiBvYnZpb3VzCj4gPiA+
IGJ1ZyBmaXhlcyB3aXRoIG5vIHNpZGUgZWZmZWN0cyBhcmUgZWFzeSB0byBqdXN0aWZ5LsKgwqBN
b3JlIGNvbXBsZXgKPiA+ID4gYnVnIGZpeGVzIHJ1biB0aGUgcmlzayBvZiBoYXZpbmcgc2lkZSBl
ZmZlY3RzIHdoaWNoIGludHJvZHVjZQo+ID4gPiBvdGhlciBidWdzLCBzbyBjb3VsZCBwb3RlbnRp
YWxseSBkZXN0YWJpbGl6ZSB0aGUgLXJjIHByb2Nlc3MuwqDCoEluCj4gPiA+IFNDU0kgd2UgdGVu
ZCB0byBsb29rIGF0IHdoYXQgdGhlIHVzZXIgdmlzaWJsZSBlZmZlY3RzIG9mIHRoZSBidWcKPiA+
ID4gYXJlIGluIHRoZSBwb3N0IC1yYzUgcmVnaW9uIGFuZCBpZiB0aGV5J3JlIHNsaWdodCBvciB3
b3VsZG4ndCBiZQo+ID4gPiB2aXNpYmxlIHRvIG1vc3QgdXNlcnMsIHdlJ2xsIGhvbGQgdGhlbSBv
dmVyLsKgwqBJZiB0aGUgZml4IGxvb2tzCj4gPiA+IGNvbXBsZXggYW5kIHdlJ3JlIG5vdCBzdXJl
IHdlIGNhdWdodCB0aGUgcmFtaWZpY2F0aW9ucywgd2Ugb2Z0ZW4KPiA+ID4gYWRkIGl0IHRvIHRo
ZSBtZXJnZSB3aW5kb3cgdHJlZSB3aXRoIGEgY2MgdG8gc3RhYmxlIGFuZCBhIG5vdGUKPiA+ID4g
c2F5aW5nIHRvIHdhaXQgWCB3ZWVrcyBiZWZvcmUgYWN0dWFsbHkgYWRkaW5nIHRvIHRoZQo+ID4g
PiBzdGFibGUgdHJlZSBqdXN0IHRvIG1ha2Ugc3VyZSBubyBzaWRlIGVmZmVjdHMgc2hvdyB1cCB3
aXRoIHdpZGVyCj4gPiA+IHRlc3RpbmcuwqDCoFNvLCBhcyB3aXRoIG1vc3QgdGhpbmdzLCBpdCdz
IGEganVkZ21lbnQgY2FsbCBmb3IgdGhlCj4gPiA+IG1haW50YWluZXIuCj4gPiAKPiA+IEZvciBt
ZSB0aGlzIGlzIHRoZSByaWdodCwgYW5kIHJlc3BvbnNpYmxlIHdheSB0byBkZWFsIHdpdGggYnVn
Cj4gPiBmaXhlcy4gU2VsZi1jb250cm9sIGlzIG11Y2ggbW9yZSBlZmZpY2llbnQgdGhhbiByYW5k
b20gcmVqZWN0aW9uCj4gPiBhbmQgZmF2b3JzIGEgZ29vZCBhbmFseXNpcy4KPiAKPiBJIHRoaW5r
IHRoYXQgdGhlIGlkZWFsIG91dGNvbWUgb2YgdGhpcyBkaXNjdXNzaW9uLCBhdCBsZWFzdCBmb3Ig
bWUsCj4gaXMgYSB0b29sIHRvIGdvIHVuZGVyIHNjcmlwdHMvIHRoYXQgd291bGQgYWxsb3cgbWFp
bnRhaW5lcnMgdG8gZ2V0Cj4gc29tZSBzb3J0IG9mIChxdWFudGlmaWFibGUpIGRhdGEgdGhhdCB3
aWxsIGluZGljYXRlIGhvdyB3ZWxsIHRoZQo+IHBhdGNoIHdhcyB0ZXN0ZWQgdmlhIHRoZSByZWd1
bGFyIGNoYW5uZWxzLgo+IAo+IEF0IHdoaWNoIHBvaW50IGl0J3MgdGhlIG1haW50YWluZXIncyBq
dWRnZW1lbnQgY2FsbCBvbiB3aGV0aGVyIGhlCj4gd2FudHMgdG8gZ3JhYiB0aGUgcGF0Y2ggb3Ig
d2FpdCBmb3IgbW9yZSB0ZXN0cyBvciByZXZpZXdzLgo+IAo+IFRoaXMgaXMgdmVyeSBzaW1pbGFy
IHRvIHdoYXQgSmFtZXMgaGFzIGRlc2NyaWJlZCwgaXQganVzdCBuZWVkcyB0bwo+IGxlYXZlIGhp
cyBicmFpbiBhbmQgdHVybiBpbnRvIGNvZGUgOikKCkkgYXBwcmVjaWF0ZSB0aGUgc2VudGltZW50
LCBidXQgaWYgd2UgY291bGQgc2NyaXB0IHRhc3RlLCB3ZSdkIGhhdmUKcmVwbGFjZWQgTGludXMg
d2l0aCBzb21ldGhpbmcgZmFyIGxlc3MgY2FudGFua2Vyb3VzIGEgbG9uZyB0aW1lIGFnbyAuLi4K
Ckl0J3MgYWxzbyBhIHNhZCBmYWN0IHRoYXQgYSBsb3Qgb2YgdGhpbmdzIHdoaWNoIGxvb2sgbGlr
ZSBvYnZpb3VzIGZpeGVzCmFjdHVhbGx5IHR1cm4gb3V0IG5vdCB0byBiZSBzbyB3aXRoIGxhdGVy
IHRlc3RpbmcuICBUaGlzIGlzIHdoeSB0aGUKdXNlciB2aXNpYmlsaXR5IHRlc3QgaXMgcGFyYW1v
dW50LiAgSWYgYSBidWcgZml4IGhhcyBubyByZWFsIHVzZXIKdmlzaWJsZSBlZmZlY3RzLCBpdCdz
IG9mdGVuIGJldHRlciB0byBkZWZlciBpdCBubyBtYXR0ZXIgaG93IG9idmlvdXMgaXQKbG9va3Ms
IHdoaWNoIGlzIHdoeSB0aGUgc3RhdGljIGNvZGUgY2hlY2tlcnMgb2Z0ZW4gZ2V0IHNob3J0IHNo
cmlmdApiZWZvcmUgYSBtZXJnZSB3aW5kb3cuCgpBIHNjcmlwdCBtZWFzdXJpbmcgdXNlciB2aXNp
YmlsaXR5IHdvdWxkIGJlIG5pY2UsIGJ1dCBsb29rcyBhIGJpdApjb21wbGV4IC4uLgoKSmFtZXMK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCktzdW1taXQt
ZGlzY3VzcyBtYWlsaW5nIGxpc3QKS3N1bW1pdC1kaXNjdXNzQGxpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
a3N1bW1pdC1kaXNjdXNzCg==
