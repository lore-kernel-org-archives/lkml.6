Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A14244CA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A14244CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeF1LiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:38:14 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:55783 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeF1LiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:38:12 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 0A0A8352FCE;
        Thu, 28 Jun 2018 13:38:10 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     jdow <jdow@earthlink.net>, Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Amiga RDB partition support for disks >= 2 TB
Date:   Thu, 28 Jun 2018 13:38:09 +0200
Message-ID: <51008870.LIDn3ZZdjm@merkaba>
In-Reply-To: <4710936.m2SbBcP6dP@merkaba>
References: <20180425154602.GA8546@bombadil.infradead.org> <a8bef8a7-7b99-bc91-87b6-f9e4e838a4b8@earthlink.net> <4710936.m2SbBcP6dP@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFydGluIFN0ZWlnZXJ3YWxkIC0gMjguMDYuMTgsIDEzOjMwOgo+IGpkb3cgLSAyOC4wNi4xOCwg
MTI6MDA6Cj4gPiBPbiAyMDE4MDYyOCAwMToxNiwgTWFydGluIFN0ZWlnZXJ3YWxkIHdyb3RlOgo+
IFvigKZdCj4gCj4gPiA+PiBUaGF0IGJyaW5ncyB0byB0aGUgZm9yZSBhbiBpbnRlcmVzdGluZyBx
dWVzdGlvbi4gV2h5IGJvdGhlciB3aXRoCj4gPiA+PiBSREJzCj4gPiA+PiBvdmVyIDJUQiB1bmxl
c3MgeW91IHdhbnQgYSBkaXNrIHdpdGggb25lIHNpbmdsZSBwYXJ0aXRpb24/IFRoaXMKPiA+ID4+
IFdpbjEwCj4gPiA+PiBtb25zdGVyIEkgYW0gdXNpbmcgaGFzIGEgbW9kZXN0IEJJT1MgZHJpdmVy
IHBhcnRpdGlvbiBmb3IgdGhlIE9TCj4gPiA+PiBhbmQKPiA+ID4+IGEgZ2lhbnQgZGF0YSBwYXJ0
aXRpb24uIFRoYXQgc21hbGxlciBwYXJ0aXRpb24gd291bGQgZWFzaWx5IHdvcmsKPiA+ID4+IHdp
dGgKPiA+ID4+IGFueSBSREIvRmlsZXN5c3RlbSBjb21iaW5hdGlvbiBzaW5jZSAyLjAuIFNvIHRo
ZXJlIGFyZSBzb21lIGdvb2QKPiA+ID4+IHdvcmthcm91bmRzIHRoYXQgYXJlIHByb2JhYmx5ICJz
YWZlciIgYW5kIGF0IGxlYXN0IGFzIGZsZXhpYmxlIGFzCj4gPiA+PiBSREJzLCBvbmUgTGludXgg
aGFzIHVzZWQgZm9yIGEgdmVyeSBsb25nIHRpbWUsIHRvby4KPiA+ID4gCj4gPiA+IFdlbGwsIG15
IHVzZSBjYXNlIHdhcyBzaW1wbGU6Cj4gPiA+IAo+ID4gPiBJIGhhZCB0aGlzIDIgVEIgZGlzayBh
bmQgSSBjaG9vc2UgdG8gc2hhcmUgaXQgYXMgYSBiYWNrdXAgZGlzayBmb3IKPiA+ID4gTGludXgg
KmFuZCogQW1pZ2FPUyA0Lnggb24gdGhhdCBTYW00NDBlcCBJIHN0aWxsIGhhdmUgbmV4dCB0byBt
ZQo+ID4gPiBkZXNrIGhlcmUuCj4gPiAKPiA+IEVFRUVFRUshIFRoZSBoYWlyIG9uIG15IG5lY2sg
aXMgc3RhbmRpbmcgdXAgc3RyYWlnaHQhIEhhdmUgeW91IGhlYXJkCj4gPiBvZiBTQU1CQT8gVGhl
IGxpbnV4IG1haWwgc2VydmVyIGZpcmV3YWxsIGV0YyBtYWNoaW5lIGhhcyBhbiBleHRyYQo+ID4g
NFRCCj4gPiBkaXNrIG9uIGl0IGFzIGEgYmFja3VwIGZvciB0aGUgb3RoZXIgc3lzdGVtcywgYWx0
aG91Z2ggYSBwaWRkbHkgNFRCCj4gPiBpcyBzbWFsbCB3aGVuIEkgc2F2ZSB0aGUgZW50aXJlIDNH
IFJBSUQgc3lzdGVtIEkgaGF2ZS4gSXQncyBhIHByb29mCj4gPiBvZiBjb25jZXB0IHNvLi4uLiBB
IGZ1bGwgYmFja3VwIG9uIGEgMWdpZyBFdGhlcm5ldCBzdGlsbCB0YWtlcyBhCj4gPiBsb29vb29u
ZyB0aW1lLiBCdXQgYmFja2luZyB1cCBldmVuIGFuIDE4R0IgZGlzayBvbiBhbiBBbWlnYSB2aWEK
PiA+IDEwMEJhc2UtdCBpc24ndCB0b28gYmFkLiBBbmQgZGlzayBzcGVlZHMgb2YgdGhlIGVyYSBi
ZWluZyB3aGF0IHRoZXkKPiA+IHdlcmUgaXQncyBhYm91dCBhbGwgeW91IGNhbiBkbyBhbnl3YXku
Cj4gCj4gSGVoLCB0aGUgdGhpbmcgd29ya2VkIGp1c3QgZmluZSBpbiBBbWlnYSBPUyA0LiBJIGdv
dCBhd2F5IHdpdGggaXQKPiB3aXRob3V0IGFuIGlzc3VlLCB1bnRpbCBJIHBsdWdnZWQgdGhlIGRp
c2sgdG8gbXkgTGludXggbGFwdG9wIGFuZAo+IHdyb3RlIGRhdGEgb250byB0aGUgTGludXggZmls
ZSBzeXN0ZW0uIE1pbmQgeW91LCBJIHRoaW5rIGluIHRoYXQKPiBwYXJ0aXRpb24gbWFya2VkIExO
WFwwIEkgZXZlbiBjcmVhdGVkIGEgTGludXggTFZNIHdpdGggcHZjcmVhdGUuIERvCj4geW91IGNh
bGwgdGhhdCBpbnNhbmU/IFdlbGwgaXQgcHJvYmFibHkgaXMuIDopCj4gCj4gQW5kIGFzIGFuIEFt
aWdhIHVzZXIgSSBjb3VsZCBqdXN0IHJldHVybiB0byB5b3U6IEkgY2xpY2tlZCBpdCwgaXQgZGlk
Cj4gbm90IHdhcm4sIHNvIGFsbCBpcyBnb29kIDopCj4gCj4gQnV0IHllYWgsIGFzIG1lbnRpb25l
ZCBJIHJlc2VhcmNoZWQgdGhlIHRvcGljIGJlZm9yZS4gQW5kIEkgdGhpbmsKPiB0aGVyZQo+IGhh
cyBub3QgZXZlbiBiZWVuIGFuIG92ZXJmbG93IHdpdGhpbiB0aGUgUkRCOgo+ID4gVGhlIHJhdywg
dGhlb3JldGljYWwgbGltaXQgb24gdGhlIG1heGltdW0gZGV2aWNlIGNhcGFjaXR5IGlzIGFib3V0
Cj4gPiAyXjEwNSBieXRlczoKPiA+IAo+ID4gMzIgYml0IHJkYl9DeWxpbmRlcnMgKiAzMiBiaXQg
cmRiX0hlYWRzICogMzIgYml0IHJkYl9TZWN0b3JzICogNTEyCj4gPiBieXRlcy9zZWN0b3IgZm9y
IHRoZSBIRCBzaXplIGluIHN0cnVjdCBSaWdpZERpc2tCbG9jawAKPiAKPiBodHRwOi8vd2lraS5h
bWlnYW9zLm5ldC93aWtpL1JEQl8oQW1pZ2FfUmlnaWRfRGlza19CbG9jaykKPiAKPiBDb25maXJt
ZWQgYnk6Cj4gCj4gVGhlIC5BREYgKEFtaWdhIERpc2sgRmlsZSkgZm9ybWF0IEZBUToKPiBodHRw
Oi8vbGNsZXZ5LmZyZWUuZnIvYWRmbGliL2FkZl9pbmZvLmh0bWwjcDYKPiAKPiBCdXQgd2hhdCBk
byBJIHdyaXRlLCB5b3Uga25vdyB0aGUgUkRCIGZvcm1hdCA6KQo+IAo+IFNvIGp1c3QgZG8gdGhl
IGNhbGN1bGF0aW9uIGluIDk2IEJpdCBhbmQgeW91IGFsbCBhcmUgc2V0IDopCgpGb3Igc2VjdG9y
cy4KCk9yCgozKjMyKzkgKGZvciA1MTIgYnl0ZXMgcGVyIHNlY3RvcikgPSAxMDUgYml0cwoKZm9y
IGJ5dGVzLgoKPiBOb3cgdGhhdCBpcyBhIHJlYXNvbiBmb3IgMTI4IEJpdCBDUFVzIDopLgo+IAo+
IE11dWhhaGFoYS4KLS0gCk1hcnRpbg==




