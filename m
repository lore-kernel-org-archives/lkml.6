Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD2320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbeGYBtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:49:53 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:41052 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388502AbeGYBtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:49:52 -0400
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
        by Forcepoint Email with ESMTPS id C176AC1610BF32FA24D2;
        Wed, 25 Jul 2018 08:40:48 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
        by mse02.zte.com.cn with SMTP id w6P0ehI4002237;
        Wed, 25 Jul 2018 08:40:43 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from mapi (kjyxapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 25 Jul 2018 08:40:44 +0800 (CST)
Date:   Wed, 25 Jul 2018 08:40:44 +0800 (CST)
X-Zmail-TransId: 2b065b57c70c7c7d3efb
X-Mailer: Zmail v1.0
Message-ID: <201807250840440600958@zte.com.cn>
In-Reply-To: <1531880968-39607-1-git-send-email-jiang.biao2@zte.com.cn>
References: 1531880968-39607-1-git-send-email-jiang.biao2@zte.com.cn
Mime-Version: 1.0
From:   <jiang.biao2@zte.com.cn>
Cc:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <zhong.weidong@zte.com.cn>,
        <huang.chong@zte.com.cn>, <minchan@kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdmlydGlvX2JhbGxvb246IGZpeCBhbm90aGVyIHJhY2UgYmV0d2VlbiBtaWdyYXRpb24gYW5kIGJhbGxvb25pbmc=?=
Content-Type: multipart/mixed;
        boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn w6P0ehI4002237
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

UGluZy4uLi4uCj4gS2VybmVsIHBhbmljIHdoZW4gd2l0aCBoaWdoIG1lbW9yeSBwcmVzc3VyZSwg
Y2FsbHRyYWNlIGxvb2tzIGxpa2UsCj4KPiBQSUQ6IDIxNDM5IFRBU0s6IGZmZmY4ODFiZTNhZmVk
ZDAgQ1BVOiAxNiBDT01NQU5EOiAiamF2YSIKPiMwIFtmZmZmODgxZWM3ZWQ3NjMwXSBtYWNoaW5l
X2tleGVjIGF0IGZmZmZmZmZmODEwNTliZWIKPiAjMSBbZmZmZjg4MWVjN2VkNzY5MF0gX19jcmFz
aF9rZXhlYyBhdCBmZmZmZmZmZjgxMTA1OTQyCj4gIzIgW2ZmZmY4ODFlYzdlZDc3NjBdIGNyYXNo
X2tleGVjIGF0IGZmZmZmZmZmODExMDVhMzAKPiAjMyBbZmZmZjg4MWVjN2VkNzc3OF0gb29wc19l
bmQgYXQgZmZmZmZmZmY4MTY5MDJjOAo+ICM0IFtmZmZmODgxZWM3ZWQ3N2EwXSBub19jb250ZXh0
IGF0IGZmZmZmZmZmODE2N2ZmNDYKPiAjNSBbZmZmZjg4MWVjN2VkNzdmMF0gX19iYWRfYXJlYV9u
b3NlbWFwaG9yZSBhdCBmZmZmZmZmZjgxNjdmZmRjCj4gIzYgW2ZmZmY4ODFlYzdlZDc4MzhdIF9f
bm9kZV9zZXQgYXQgZmZmZmZmZmY4MTY4MDMwMAo+ICM3IFtmZmZmODgxZWM3ZWQ3ODYwXSBfX2Rv
X3BhZ2VfZmF1bHQgYXQgZmZmZmZmZmY4MTY5MzIwZgo+ICM4IFtmZmZmODgxZWM3ZWQ3OGMwXSBk
b19wYWdlX2ZhdWx0IGF0IGZmZmZmZmZmODE2OTMyYjUKPiAjOSBbZmZmZjg4MWVjN2VkNzhmMF0g
cGFnZV9mYXVsdCBhdCBmZmZmZmZmZjgxNjhmNGM4Cj4gW2V4Y2VwdGlvbiBSSVA6IF9yYXdfc3Bp
bl9sb2NrX2lycXNhdmUrNDddCj4gUklQOiBmZmZmZmZmZjgxNjhlZGVmIFJTUDogZmZmZjg4MWVj
N2VkNzlhOCBSRkxBR1M6IDAwMDEwMDQ2Cj4gUkFYOiAwMDAwMDAwMDAwMDAwMjQ2IFJCWDogZmZm
ZmVhMDAxOTc0MGQwMCBSQ1g6IGZmZmY4ODFlYzdlZDdmZDgKPiBSRFg6IDAwMDAwMDAwMDAwMjAw
MDAgUlNJOiAwMDAwMDAwMDAwMDAwMDE2IFJESTogMDAwMDAwMDAwMDAwMDAwOAo+IFJCUDogZmZm
Zjg4MWVjN2VkNzlhOCBSODogMDAwMDAwMDAwMDAwMDI0NiBSOTogMDAwMDAwMDAwMDAxYTA5OAo+
IFIxMDogZmZmZjg4MTA3ZmZkYTAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAw
MDAwMDAwMDAwCj5SMTM6IDAwMDAwMDAwMDAwMDAwMDggUjE0OiBmZmZmODgxZWM3ZWQ3YTgwIFIx
NTogZmZmZjg4MWJlM2FmZWRkMAo+IE9SSUdfUkFYOiBmZmZmZmZmZmZmZmZmZmZmIENTOiAwMDEw
IFNTOiAwMDE4Cj4gIzEwIFtmZmZmODgxZWM3ZWQ3OWIwXSBiYWxsb29uX3BhZ2VfcHV0YmFjayBh
dCBmZmZmZmZmZjgxMWZiZmI5Cj4gIzExIFtmZmZmODgxZWM3ZWQ3OWUwXSBwdXRiYWNrX21vdmFi
bGVfcGFnZXMgYXQgZmZmZmZmZmY4MTFlMzE1NQo+ICMxMiBbZmZmZjg4MWVjN2VkN2ExMF0gY29t
cGFjdF96b25lIGF0IGZmZmZmZmZmODExYTg0M2YKPiAjMTMgW2ZmZmY4ODFlYzdlZDdhNjBdIGNv
bXBhY3Rfem9uZV9vcmRlciBhdCBmZmZmZmZmZjgxMWE4NWFjCj4gIzE0IFtmZmZmODgxZWM3ZWQ3
YjAwXSB0cnlfdG9fY29tcGFjdF9wYWdlcyBhdCBmZmZmZmZmZjgxMWE4OTYxCj4gIzE1IFtmZmZm
ODgxZWM3ZWQ3YjYwXSBfX2FsbG9jX3BhZ2VzX2RpcmVjdF9jb21wYWN0IGF0IGZmZmZmZmZmODE2
ODI3ZDYKPiAjMTYgW2ZmZmY4ODFlYzdlZDdiYzBdIF9fYWxsb2NfcGFnZXNfc2xvd3BhdGggYXQg
ZmZmZmZmZmY4MTY4MmY2NAo+ICMxNyBbZmZmZjg4MWVjN2VkN2NiMF0gX19hbGxvY19wYWdlc19u
b2RlbWFzayBhdCBmZmZmZmZmZjgxMThiNzc1Cj4gIzE4IFtmZmZmODgxZWM3ZWQ3ZDYwXSBhbGxv
Y19wYWdlc192bWEgYXQgZmZmZmZmZmY4MTFkMmE2YQo+ICMxOSBbZmZmZjg4MWVjN2VkN2RjOF0g
ZG9faHVnZV9wbWRfYW5vbnltb3VzX3BhZ2UgYXQgZmZmZmZmZmY4MTFlYmY5Mwo+ICMyMCBbZmZm
Zjg4MWVjN2VkN2UyOF0gaGFuZGxlX21tX2ZhdWx0IGF0IGZmZmZmZmZmODExYjFjMWYKPiAjMjEg
W2ZmZmY4ODFlYzdlZDdlYzBdIF9fZG9fcGFnZV9mYXVsdCBhdCBmZmZmZmZmZjgxNjkyZjg0Cj4g
IzIyIFtmZmZmODgxZWM3ZWQ3ZjIwXSBkb19wYWdlX2ZhdWx0IGF0IGZmZmZmZmZmODE2OTMyYjUK
PiAjMjMgW2ZmZmY4ODFlYzdlZDdmNTBdIHBhZ2VfZmF1bHQgYXQgZmZmZmZmZmY4MTY4ZjRjOAo+
IAo+IEl0IGhhcHBlbnMgaW4gdGhlIHBhZ2VmYXVsdCBhbmQgcmVzdWx0cyBpbiBkb3VibGUgcGFn
ZWZhdWx0Cj4gZHVyaW5nIGNvbXBhY3RpbmcgcGFnZXMgd2hlbiBtZW1vcnkgYWxsb2NhdGlvbiBm
YWlscy4KPiAKPiBBbmFseXNlZCB0aGUgdm1jb3JlLCB0aGUgcGFnZSBsZWFkcyB0byBzZWNvbmQg
cGFnZWZhdWx0IGlzIGNvcnJ1cHRlZAo+IHdpdGggX21hcGNvdW50PS0yNTYsIGJ1dCBwcml2YXRl
PTAuCj4gCj4gSXQncyBjYXVzZWQgYnkgdGhlIHJhY2UgYmV0d2VlbiBtaWdyYXRpb24gYW5kIGJh
bGxvb25pbmcsIGFuZCBsb2NrCj4gbWlzc2luZyBpbiB2aXJ0YmFsbG9vbl9taWdyYXRlcGFnZSgp
IG9mIHZpcnRpb19iYWxsb29uIGRyaXZlci4KPiBUaGlzIHBhdGNoIGZpeCB0aGUgYnVnLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEppYW5nIEJpYW8gPGppYW5nLmJpYW8yQHp0ZS5jb20uY24+Cj4gU2ln
bmVkLW9mZi1ieTogSHVhbmcgQ2hvbmcgPGh1YW5nLmNob25nQHp0ZS5jb20uY24+Cj4gLS0tCj4g
ZHJpdmVycy92aXJ0aW8vdmlydGlvX2JhbGxvb24uYyB8IDIgKysKPiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX2Jh
bGxvb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMKPiBpbmRleCA2YjIzN2Uz
Li4zOTg4YzA5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMK
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fYmFsbG9vbi5jCj4gQEAgLTUxMyw3ICs1MTMs
OSBAQCBzdGF0aWMgaW50IHZpcnRiYWxsb29uX21pZ3JhdGVwYWdlKHN0cnVjdCBiYWxsb29uX2Rl
dl9pbmZvICp2Yl9kZXZfaW5mbywKPiB0ZWxsX2hvc3QodmIsIHZiLT5pbmZsYXRlX3ZxKTsKPiAv
KiBiYWxsb29uJ3MgcGFnZSBtaWdyYXRpb24gMm5kIHN0ZXAgLS0gZGVmbGF0ZSAicGFnZSIgKi8K
PiArICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ2Yl9kZXZfaW5mby0+cGFnZXNfbG9jaywgZmxhZ3Mp
Owo+IGJhbGxvb25fcGFnZV9kZWxldGUocGFnZSk7Cj4gKyAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ2Yl9kZXZfaW5mby0+cGFnZXNfbG9jaywgZmxhZ3MpOwo+IHZiLT5udW1fcGZucyA9IFZJ
UlRJT19CQUxMT09OX1BBR0VTX1BFUl9QQUdFOwo+IHNldF9wYWdlX3BmbnModmIsIHZiLT5wZm5z
LCBwYWdlKTsKPiB0ZWxsX2hvc3QodmIsIHZiLT5kZWZsYXRlX3ZxKTsKPiAtLQo+IDIuNy40


--=====_003_next=====--

--=====_001_next=====--

