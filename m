Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA73C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1CF20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1CF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeGYI0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:26:19 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:43284 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeGYI0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:26:19 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 590EC4AD9497C79FC22D;
        Wed, 25 Jul 2018 15:15:57 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
        by mse01.zte.com.cn with SMTP id w6P7FKuX088762;
        Wed, 25 Jul 2018 15:15:47 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from mapi (kjyxapp01[null])
        by mapi (Zmail) with MAPI id mid16;
        Wed, 25 Jul 2018 15:15:49 +0800 (CST)
Date:   Wed, 25 Jul 2018 15:15:49 +0800 (CST)
X-Zmail-TransId: 2b035b5823a511f8b69d
X-Mailer: Zmail v1.0
Message-ID: <201807251515493276583@zte.com.cn>
In-Reply-To: <alpine.LFD.2.20.1807250849100.2794@ja.home.ssi.bg>
References: 1532486980-17844-1-git-send-email-tan.hu@zte.com.cn,alpine.LFD.2.20.1807250849100.2794@ja.home.ssi.bg
Mime-Version: 1.0
From:   <tan.hu@zte.com.cn>
To:     <ja@ssi.bg>
Cc:     <wensong@linux-vs.org>, <horms@verge.net.au>,
        <pablo@netfilter.org>, <kadlec@blackhole.kfki.hu>, <fw@strlen.de>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <lvs-devel@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
        <coreteam@netfilter.org>, <linux-kernel@vger.kernel.org>,
        <zhong.weidong@zte.com.cn>, <jiang.biao2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggdjJdIGlwdnM6IGZpeCByYWNlIGJldHdlZW4gaXBfdnNfY29ubl9uZXcoKSBhbmRpcF92c19kZWxfZGVzdCgp?=
Content-Type: multipart/mixed;
        boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn w6P7FKuX088762
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

VGhhbmtzLCBwYXRjaC12MyBoYXMgYmVlbiBzZW50LiBwbGVhc2UgY2hlY2sgaXQgYWdhaW4uCgo+
IEhlbGxvLAo+IAo+IE9uIFdlZCwgMjUgSnVsIDIwMTgsIFRhbiBIdSB3cm90ZToKPiAKPiA+IFdl
IGNhbWUgYWNyb3NzIGluZmluaXRlIGxvb3AgaW4gaXB2cyB3aGVuIHVzaW5nIGlwdnMgaW4gZG9j
a2VyCj4gPiBlbnYuCj4gPgo+ID4gV2hlbiBpcHZzIHJlY2VpdmVzIG5ldyBwYWNrZXRzIGFuZCBj
YW5ub3QgZmluZCBhbiBpcHZzIGNvbm5lY3Rpb24sCj4gPiBpdCB3aWxsIGNyZWF0ZSBhIG5ldyBj
b25uZWN0aW9uLCB0aGVuIGlmIHRoZSBkZXN0IGlzIHVuYXZhaWxhYmxlCj4gPiAoaS5lLiBJUF9W
U19ERVNUX0ZfQVZBSUxBQkxFKSwgdGhlIHBhY2tldCB3aWxsIGJlIGRyb3BwZWQgc2xpZW50bHku
Cj4gPgo+ID4gQnV0IGlmIHRoZSBkcm9wcGVkIHBhY2tldCBpcyB0aGUgZmlyc3QgcGFja2V0IG9m
IHRoaXMgY29ubmVjdGlvbiwKPiA+IHRoZSBjb25uZWN0aW9uIGNvbnRyb2wgdGltZXIgbmV2ZXIg
aGFzIGEgY2hhbmNlIHRvIHN0YXJ0IGFuZCB0aGUKPiA+IGlwdnMgY29ubmVjdGlvbiBjYW5ub3Qg
YmUgcmVsZWFzZWQuIFRoaXMgd2lsbCBsZWFkIHRvIG1lbW9yeSBsZWFrLCBvcgo+ID4gaW5maW5p
dGUgbG9vcCBpbiBjbGVhbnVwX25ldCgpIHdoZW4gbmV0IG5hbWVzcGFjZSBpcyByZWxlYXNlZCBs
aWtlCj4gPiB0aGlzOgo+ID4KPiA+IGlwX3ZzX2Nvbm5fbmV0X2NsZWFudXAgYXQgZmZmZmZmZmZh
MGE5ZjMxYSBbaXBfdnNdCj4gPiBfX2lwX3ZzX2NsZWFudXAgYXQgZmZmZmZmZmZhMGE5ZjYwYSBb
aXBfdnNdCj4gPiBvcHNfZXhpdF9saXN0IGF0IGZmZmZmZmZmODE1NjdhNDkKPiA+IGNsZWFudXBf
bmV0IGF0IGZmZmZmZmZmODE1NjhiNDAKPiA+IHByb2Nlc3Nfb25lX3dvcmsgYXQgZmZmZmZmZmY4
MTBhODUxYgo+ID4gd29ya2VyX3RocmVhZCBhdCBmZmZmZmZmZjgxMGE5MzU2Cj4gPiBrdGhyZWFk
IGF0IGZmZmZmZmZmODEwYjBiNmYKPiA+IHJldF9mcm9tX2ZvcmsgYXQgZmZmZmZmZmY4MTY5N2Ex
OAo+ID4KPiA+IHJhY2UgY29uZGl0aW9uOgo+ID4gQ1BVMSBDUFUyCj4gPiBpcF92c19pbigpCj4g
PiBpcF92c19jb25uX25ldygpCj4gPiBpcF92c19kZWxfZGVzdCgpCj4gPiBfX2lwX3ZzX3VubGlu
a19kZXN0KCkKPiA+IH5JUF9WU19ERVNUX0ZfQVZBSUxBQkxFCj4gPiBjcC0+ZGVzdCAmJiAhSVBf
VlNfREVTVF9GX0FWQUlMQUJMRQo+ID4gX19pcF92c19jb25uX3B1dAo+ID4gLi4uCj4gPiBjbGVh
bnVwX25ldCAtLS0+IGluZmluaXRlIGxvb3BpbmcKPiA+Cj4gPiBGaXggdGhpcyBieSBjaGVja2lu
ZyB3aGV0aGVyIHRoZSB0aW1lciBhbHJlYWR5IHN0YXJ0ZWQuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogVGFuIEh1IDx0YW4uaHVAenRlLmNvbS5jbj4KPiA+IFJldmlld2VkLWJ5OiBKaWFuZyBCaWFv
IDxqaWFuZy5iaWFvMkB6dGUuY29tLmNuPgo+ID4gLS0tCj4gPiB2MjogZml4IHVzZS1hZnRlci1m
cmVlIGluIENPTk5fT05FX1BBQ0tFVCBjYXNlIHN1Z2dlc3RlZCBieSBKdWxpYW4gQW5hc3Rhc292
Cj4gPgo+ID4gbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2NvcmUuYyB8IDE1ICsrKysrKysrKysr
LS0tLQo+ID4gMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL25ldC9uZXRmaWx0ZXIvaXB2cy9pcF92c19jb3JlLmMgYi9u
ZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfY29yZS5jCj4gPiBpbmRleCAwNjc5ZGQxLi5hMTcxMDRm
IDEwMDY0NAo+ID4gLS0tIGEvbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2NvcmUuYwo+ID4gKysr
IGIvbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2NvcmUuYwo+ID4gQEAgLTE5NzIsMTMgKzE5NzIs
MjAgQEAgc3RhdGljIGludCBpcF92c19pbl9pY21wX3Y2KHN0cnVjdCBuZXRuc19pcHZzICppcHZz
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAo+ID4gaWYgKGNwLT5kZXN0ICYmICEoY3AtPmRlc3QtPmZs
YWdzICYgSVBfVlNfREVTVF9GX0FWQUlMQUJMRSkpIHsKPiA+IC8qIHRoZSBkZXN0aW5hdGlvbiBz
ZXJ2ZXIgaXMgbm90IGF2YWlsYWJsZSAqLwo+ID4KPiA+IC0gaWYgKHN5c2N0bF9leHBpcmVfbm9k
ZXN0X2Nvbm4oaXB2cykpIHsKPiA+ICsgX191MzIgZmxhZ3MgPSBjcC0+ZmxhZ3M7Cj4gCj4gT3Bz
LCBub3cgc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0IC90bXAvZmlsZS5wYXRjaAo+IGlz
IGNvbXBsYWluaW5nIGFib3V0IGV4dHJhIHRyYWlsaW5nIHNwYWNlIGluIGFib3ZlIGxpbmUuCj4g
WW91IGNhbiBhbHNvIHJlbW92ZSB0aGUgZW1wdHkgbGluZSBhYm92ZSB0aGUgbmV3IGNvZGUuLi4K
PiAKPiBSZWdhcmRz


--=====_003_next=====--

--=====_001_next=====--

