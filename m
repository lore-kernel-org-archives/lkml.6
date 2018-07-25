Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972420852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGYCEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:04:50 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:60034 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388441AbeGYCEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:04:49 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 508F0FA47B79F4A812A0;
        Wed, 25 Jul 2018 08:55:42 +0800 (CST)
Received: from kjyxapp04.zte.com.cn ([10.30.12.203])
        by mse01.zte.com.cn with SMTP id w6P0tXNv045447;
        Wed, 25 Jul 2018 08:55:33 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (kjyxapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 25 Jul 2018 08:55:34 +0800 (CST)
Date:   Wed, 25 Jul 2018 08:55:34 +0800 (CST)
X-Zmail-TransId: 2b075b57ca861f0168e2
X-Mailer: Zmail v1.0
Message-ID: <201807250855344461527@zte.com.cn>
In-Reply-To: <CAHC9VhRZnzKF03tFmgp007BWB4GuWOM5e8X7s=_GuPQ4d1tjow@mail.gmail.com>
References: 1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn,89963f4c8c4f89bc766ffc0b58fe8e24942c3793.camel@redhat.com,CAHC9VhRZnzKF03tFmgp007BWB4GuWOM5e8X7s=_GuPQ4d1tjow@mail.gmail.com
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <paul@paul-moore.com>
Cc:     <eparis@redhat.com>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jiang.biao2@zte.com.cn>,
        <zhong.weidong@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXVkaXQ6IGZpeCBwb3RlbnRpYWwgbnVsbCBkZXJlZmVyZW5jZSAnY29udGV4dC0+bW9kdWxlLm5hbWUn?=
Content-Type: multipart/mixed;
        boundary="=====_001_next====="
X-MAIL: mse01.zte.com.cn w6P0tXNv045447
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

PiBPbiBUdWUsIEp1bCAyNCwgMjAxOCBhdCA2OjM4IFBNIEVyaWMgUGFyaXMgPGVwYXJpc0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAxOC0wNy0yNCBhdCAxNTo1NSAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gVHVlLCBKdWwgMjQsIDIwMTggYXQgNzozOSBBTSBFcmlj
IFBhcmlzIDxlcGFyaXNAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gV291bGQgaXQgbWFrZSBt
b3JlIHNlbnNlIHRvIGFjdHVhbGx5IGNoZWNrIGZvciBmYWlsdXJlIG9uCj4gPiA+ID4gYWxsb2Nh
dGlvbgo+ID4gPiA+IHJhdGhlciB0aGFuIHRyeSB0byByZW1lbWJlciB0byBkZWFsIHdpdGggaXQg
bGF0ZXI/IEhvdyBhYm91dCB3ZQo+ID4gPiA+IGp1c3QKPiA+ID4gPiBoYXZlIGF1ZGl0X2xvZ19r
ZXJuX21vZHVsZSByZXR1cm4gYW4gZXJyb3IgYW5kIGZhaWwgaWYgd2UgYXJlIE9PTT8KPiA+ID4K
PiA+ID4gR2VuZXJhbGx5IEkgYWdyZWUsIGNoZWNraW5nIG9uIGFsbG9jYXRpb24gaXMgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvLgo+ID4gPiBIb3dldmVyLCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSB0
aGUgZXJyb3IgcmVjb3ZlcnkgZm9yIGEgZmFpbGVkCj4gPiA+IGFsbG9jYXRpb24gd291bGQgbGlr
ZWx5IGlnbm9yZSB0aGUgcmVjb3JkIGVudGlyZWx5LCBhbmQgSSB0aGluayBhCj4gPiA+IG1vZHVs
ZSBsb2FkIHJlY29yZCB3aXRoIGEgIihudWxsKSIgbW9kdWxlIG5hbWUgaXMgc3RpbGwgYmV0dGVy
IHRoYW4KPiA+ID4gbm8KPiA+ID4gbW9kdWxlIGxvYWQgcmVjb3JkIGF0IGFsbCAuLi4gYW5kIHll
cywgSSB1bmRlcnN0YW5kIHRoYXQgaWYgdGhlCj4gPiA+IG1vZHVsZQo+ID4gPiBuYW1lIGFsbG9j
YXRpb24gZmFpbHMgdGhlcmUgaXMgYSBnb29kIGNoYW5jZSBvdGhlciBhbGxvY2F0aW9ucyB3aWxs
Cj4gPiA+IGZhaWwgYW5kIHdlIG1pZ2h0IG5vdCBlbWl0IHRoZSByZWNvcmQsIGJ1dCBJJ2xsIHRh
a2UgbXkgY2hhbmNlcyB0aGF0Cj4gPiA+IHRoZSBsb2FkIGlzIHRyYW5zaWVudCBhbmQgdGhlIHN5
c3RlbSBpcyBhYmxlIHRvIHJlY292ZXIgaW4gYSB0aW1lbHkKPiA+ID4gbWFubmVyLgo+ID4KPiA+
IE9uIHRoZSBsb2FkX21vZHVsZSgpIGNvZGUgcGF0aCBwYXNzaW5nIHRoZSBlcnJvciB1cCB0aGUg
c3RhY2sgd291bGQKPiA+IGNhdXNlIHRoZSBtb2R1bGUgdG8gbm90IGJlIGxvYWRlZCwgaW5zdGVh
ZCBvZiBiZWluZyBsb2FkZWQgd2l0aCBsb3NzIG9mCj4gPiBuYW1lIGluZm9ybWF0aW9uLiBJJ2Qg
cmF0aGVyIGhhdmUgdGhlIG1vZHVsZSBub3QgbG9hZGVkIGFuZCBhCj4gPiBuYW1lPShudWxsKSBy
ZWNvcmQgdGhhbiBpdCBCRSBsb2FkZWQgYW5kIGdldCBuYW1lPShudWxsKQo+ID4KPiA+IFlvdSd2
ZSBzb2xkIG1lIG9uIHdoeSBZaSBXYW5nJ3MgcGF0Y2ggaXMgZ29vZCwgYnV0IG5vdCBvbiB3aHkg
d2UKPiA+IHdvdWxkbid0IHByb3BhZ2F0ZSB0aGUgZXJyb3IgdXAgdGhlIHN0YWNrIG9uIGxvYWQv
ZGVsZXRlLiAoZXZlbiBpZiB3ZQo+ID4gbWF5IGNob29zZSB0byBkZWxldGUgdGhlIG1vZHVsZSBv
biBPT00pCj4KPiBGb3IgYmV0dGVyIG9yIHdvcnNlIG1vc3QgKGFsbD8pIG9mIHRoZSB2YXJpb3Vz
IGF1ZGl0X2xvZ18qKCkgZnVuY3Rpb25zCj4gZG9uJ3QgcmV0dXJuIGFuIGVycm9yIGNvZGUsIG9y
IGlmIHRoZXkgZG8gdGhleSBhcmVuJ3QgcmVsaWFibHkgY2hlY2tlZAo+IGJ5IGNhbGxlcnMuICBJ
IGFncmVlIHdpdGggeW91IHRoYXQgaW4gYSBwZXJmZWN0IHdvcmxkIGl0IHdvdWxkIGJlIG5pY2UK
PiBpZiBhbiBhdWRpdCBmYWlsdXJlIGhlcmUgd291bGQgYmxvY2sgdGhlIG9wZXJhdGlvbiwgYnV0
IHRoYXQgaXNuJ3QgaG93Cj4gYXVkaXQgaXMgdHlwaWNhbGx5IHVzZWQuCj4KPiBXZSBjb3VsZCBw
cmVzdW1hYmx5IGZhaWwgdGhlIHJlY29yZCBnZW5lcmF0aW9uIG9uIGFuIGFsbG9jYXRpb24KPiBm
YWlsdXJlIGFuZCBzaWduYWwgYSBsb3N0IHJlY29yZCB2aWEgYXVkaXRfbG9nX2xvc3QoKT8gIFBl
cmhhcHMgdGhhdCdzCj4gdGhlIGJlc3Qgb3B0aW9uIGFzIGl0IHdvdWxkIGxlYXZlIHRoZSBkZWNp
c2lvbiB1cCB0byBhZG1pbmlzdHJhdG9yCj4gKGNvbnRpbnVlIHdpdGhvdXQgdGhlIHJlY29yZCwg
cHJpbnRrLCBvciBwYW5pYykuClRoYW5rcyBldmVyeW9uZSBmb3IgeW91ciByZXZpZXcgYW5kIGFk
dmljZSEgSSB3aWxsIHN1Ym1pdCBhIHYyIHBhdGNoIHNvb24KdXNpbmcga3N0cmR1cCgpIGFuZCBy
ZWNvcmRpbmcgdGhlIGxvc3Qgd2l0aCBhdWRpdF9sb2dfbG9zdCgpLgoKLS0tCkJlc3Qgd2lzaGVz
CllpIFdhbmc=


--=====_003_next=====--

--=====_001_next=====--

