Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B42AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A04B24B9D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A04B24B9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965470AbeF1Laj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:30:39 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:37403 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965444AbeF1Lah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:30:37 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 858D0352FB2;
        Thu, 28 Jun 2018 13:30:35 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     jdow <jdow@earthlink.net>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Amiga RDB partition support for disks >= 2 TB
Date:   Thu, 28 Jun 2018 13:30:35 +0200
Message-ID: <4710936.m2SbBcP6dP@merkaba>
In-Reply-To: <a8bef8a7-7b99-bc91-87b6-f9e4e838a4b8@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org> <1556186.3D3gH2gU0T@merkaba> <a8bef8a7-7b99-bc91-87b6-f9e4e838a4b8@earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amRvdyAtIDI4LjA2LjE4LCAxMjowMDoKPiBPbiAyMDE4MDYyOCAwMToxNiwgTWFydGluIFN0ZWln
ZXJ3YWxkIHdyb3RlOgpb4oCmXQo+ID4+IFRoYXQgYnJpbmdzIHRvIHRoZSBmb3JlIGFuIGludGVy
ZXN0aW5nIHF1ZXN0aW9uLiBXaHkgYm90aGVyIHdpdGgKPiA+PiBSREJzCj4gPj4gb3ZlciAyVEIg
dW5sZXNzIHlvdSB3YW50IGEgZGlzayB3aXRoIG9uZSBzaW5nbGUgcGFydGl0aW9uPyBUaGlzCj4g
Pj4gV2luMTAKPiA+PiBtb25zdGVyIEkgYW0gdXNpbmcgaGFzIGEgbW9kZXN0IEJJT1MgZHJpdmVy
IHBhcnRpdGlvbiBmb3IgdGhlIE9TCj4gPj4gYW5kCj4gPj4gYSBnaWFudCBkYXRhIHBhcnRpdGlv
bi4gVGhhdCBzbWFsbGVyIHBhcnRpdGlvbiB3b3VsZCBlYXNpbHkgd29yawo+ID4+IHdpdGgKPiA+
PiBhbnkgUkRCL0ZpbGVzeXN0ZW0gY29tYmluYXRpb24gc2luY2UgMi4wLiBTbyB0aGVyZSBhcmUg
c29tZSBnb29kCj4gPj4gd29ya2Fyb3VuZHMgdGhhdCBhcmUgcHJvYmFibHkgInNhZmVyIiBhbmQg
YXQgbGVhc3QgYXMgZmxleGlibGUgYXMKPiA+PiBSREJzLCBvbmUgTGludXggaGFzIHVzZWQgZm9y
IGEgdmVyeSBsb25nIHRpbWUsIHRvby4KPiA+IAo+ID4gV2VsbCwgbXkgdXNlIGNhc2Ugd2FzIHNp
bXBsZToKPiA+IAo+ID4gSSBoYWQgdGhpcyAyIFRCIGRpc2sgYW5kIEkgY2hvb3NlIHRvIHNoYXJl
IGl0IGFzIGEgYmFja3VwIGRpc2sgZm9yCj4gPiBMaW51eCAqYW5kKiBBbWlnYU9TIDQueCBvbiB0
aGF0IFNhbTQ0MGVwIEkgc3RpbGwgaGF2ZSBuZXh0IHRvIG1lCj4gPiBkZXNrIGhlcmUuCj4gRUVF
RUVFSyEgVGhlIGhhaXIgb24gbXkgbmVjayBpcyBzdGFuZGluZyB1cCBzdHJhaWdodCEgSGF2ZSB5
b3UgaGVhcmQKPiBvZiBTQU1CQT8gVGhlIGxpbnV4IG1haWwgc2VydmVyIGZpcmV3YWxsIGV0YyBt
YWNoaW5lIGhhcyBhbiBleHRyYSA0VEIKPiBkaXNrIG9uIGl0IGFzIGEgYmFja3VwIGZvciB0aGUg
b3RoZXIgc3lzdGVtcywgYWx0aG91Z2ggYSBwaWRkbHkgNFRCCj4gaXMgc21hbGwgd2hlbiBJIHNh
dmUgdGhlIGVudGlyZSAzRyBSQUlEIHN5c3RlbSBJIGhhdmUuIEl0J3MgYSBwcm9vZgo+IG9mIGNv
bmNlcHQgc28uLi4uIEEgZnVsbCBiYWNrdXAgb24gYSAxZ2lnIEV0aGVybmV0IHN0aWxsIHRha2Vz
IGEKPiBsb29vb29uZyB0aW1lLiBCdXQgYmFja2luZyB1cCBldmVuIGFuIDE4R0IgZGlzayBvbiBh
biBBbWlnYSB2aWEKPiAxMDBCYXNlLXQgaXNuJ3QgdG9vIGJhZC4gQW5kIGRpc2sgc3BlZWRzIG9m
IHRoZSBlcmEgYmVpbmcgd2hhdCB0aGV5Cj4gd2VyZSBpdCdzIGFib3V0IGFsbCB5b3UgY2FuIGRv
IGFueXdheS4KCkhlaCwgdGhlIHRoaW5nIHdvcmtlZCBqdXN0IGZpbmUgaW4gQW1pZ2EgT1MgNC4g
SSBnb3QgYXdheSB3aXRoIGl0IAp3aXRob3V0IGFuIGlzc3VlLCB1bnRpbCBJIHBsdWdnZWQgdGhl
IGRpc2sgdG8gbXkgTGludXggbGFwdG9wIGFuZCB3cm90ZSAKZGF0YSBvbnRvIHRoZSBMaW51eCBm
aWxlIHN5c3RlbS4gTWluZCB5b3UsIEkgdGhpbmsgaW4gdGhhdCBwYXJ0aXRpb24gCm1hcmtlZCBM
TlhcMCBJIGV2ZW4gY3JlYXRlZCBhIExpbnV4IExWTSB3aXRoIHB2Y3JlYXRlLiBEbyB5b3UgY2Fs
bCB0aGF0IAppbnNhbmU/IFdlbGwgaXQgcHJvYmFibHkgaXMuIDopCgpBbmQgYXMgYW4gQW1pZ2Eg
dXNlciBJIGNvdWxkIGp1c3QgcmV0dXJuIHRvIHlvdTogSSBjbGlja2VkIGl0LCBpdCBkaWQgCm5v
dCB3YXJuLCBzbyBhbGwgaXMgZ29vZCA6KQoKQnV0IHllYWgsIGFzIG1lbnRpb25lZCBJIHJlc2Vh
cmNoZWQgdGhlIHRvcGljIGJlZm9yZS4gQW5kIEkgdGhpbmsgdGhlcmUgCmhhcyBub3QgZXZlbiBi
ZWVuIGFuIG92ZXJmbG93IHdpdGhpbiB0aGUgUkRCOgoKPiBUaGUgcmF3LCB0aGVvcmV0aWNhbCBs
aW1pdCBvbiB0aGUgbWF4aW11bSBkZXZpY2UgY2FwYWNpdHkgaXMgYWJvdXQKPiAyXjEwNSBieXRl
czoKPiAKPiAzMiBiaXQgcmRiX0N5bGluZGVycyAqIDMyIGJpdCByZGJfSGVhZHMgKiAzMiBiaXQg
cmRiX1NlY3RvcnMgKiA1MTIKPiBieXRlcy9zZWN0b3IgZm9yIHRoZSBIRCBzaXplIGluIHN0cnVj
dCBSaWdpZERpc2tCbG9jawAKCmh0dHA6Ly93aWtpLmFtaWdhb3MubmV0L3dpa2kvUkRCXyhBbWln
YV9SaWdpZF9EaXNrX0Jsb2NrKQoKQ29uZmlybWVkIGJ5OgoKVGhlIC5BREYgKEFtaWdhIERpc2sg
RmlsZSkgZm9ybWF0IEZBUToKaHR0cDovL2xjbGV2eS5mcmVlLmZyL2FkZmxpYi9hZGZfaW5mby5o
dG1sI3A2CgpCdXQgd2hhdCBkbyBJIHdyaXRlLCB5b3Uga25vdyB0aGUgUkRCIGZvcm1hdCA6KQoK
U28ganVzdCBkbyB0aGUgY2FsY3VsYXRpb24gaW4gOTYgQml0IGFuZCB5b3UgYWxsIGFyZSBzZXQg
OikKCk5vdyB0aGF0IGlzIGEgcmVhc29uIGZvciAxMjggQml0IENQVXMgOikuCgpNdXVoYWhhaGEu
CgpDaWFvLAotLSAKTWFydGlu




