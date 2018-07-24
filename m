Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B33ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB6720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB6720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeGXCPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:15:34 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:42184 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388234AbeGXCPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:15:34 -0400
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
        by Forcepoint Email with ESMTPS id CBD3AA94A383619B4DC2;
        Tue, 24 Jul 2018 09:11:39 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
        by mse02.zte.com.cn with SMTP id w6O1BapH017570;
        Tue, 24 Jul 2018 09:11:36 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from mapi (kjyxapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 24 Jul 2018 09:11:37 +0800 (CST)
Date:   Tue, 24 Jul 2018 09:11:37 +0800 (CST)
X-Zmail-TransId: 2b065b567cc9c125f9b5
X-Mailer: Zmail v1.0
Message-ID: <201807240911372861670@zte.com.cn>
In-Reply-To: <20180723084031.GX2494@hirez.programming.kicks-ass.net>
References: 1532324370-80651-1-git-send-email-chen.lin130@zte.com.cn,20180723084031.GX2494@hirez.programming.kicks-ass.net
Mime-Version: 1.0
From:   <jiang.biao2@zte.com.cn>
To:     <peterz@infradead.org>
Cc:     <chen.lin130@zte.com.cn>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <zhong.weidong@zte.com.cn>,
        <tan.hu@zte.com.cn.cn>, <cheng.lin130@zte.com.cn>,
        <tan.hu@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gc2NoZWQvbnVtYTogZG8gbm90IGJhbGFuY2UgdGFza3Mgb250byBpc29sYXRlZCBjcHVz?=
Content-Type: multipart/mixed;
        boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn w6O1BapH017570
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

Pgo+IE9uIE1vbiwgSnVsIDIzLCAyMDE4IGF0IDAxOjM5OjMwUE0gKzA4MDAsIENoZW4gTGluIHdy
b3RlOgo+PiBGcm9tOiBDaGVuIExpbiA8Y2hlbmcubGluMTMwQHp0ZS5jb20uY24+Cj4+Cj4+IE5V
TUEgYmFsYW5jaW5nIGhhcyBub3QgdGFrZW4gKmlzb2xjcHVzKGlzb2xhdGVkIGNwdXMpKiBpbnRv
Cj4+IGNvbnNpZGVyYXRpb24uIEl0IG1heSBtaWdyYXRlIHRhc2tzIG9udG8gaXNvbGF0ZWQgY3B1
cyBhbmQgdGhlCj4+IG1pZ3JhdGVkIHRhc2tzIHdpbGwgbmV2ZXIgZXNjYXBlIGZyb20gdGhlIGlz
b2xhdGVkIGNwdXMsIHdoaWNoIHdpbGwKPj4gYnJlYWsgdGhlIGlzb2xhdGlvbiBwcm92aWRlZCBi
eSAqaXNvbGNwdXMqIGJvb3QgcGFyYW1ldGVyIGFuZAo+PiBpbnRyZHVjZSB2YXJpb3VzIHByb2Js
ZW1zLgo+Pgo+PiBUaGlzIHBhdGNoIGVuc3VyZSBOVU1BIGJhbGFuY2luZyBub3QgdG8gYmFsYW5j
ZSB0YXNrcyBvbnRvIGlhb2xhdGVkCj4+IGNwdXMuCj4KPiBJJ20gbm90IHN1cmUgd2hhdCBrZXJu
ZWwgeW91J3JlIHBhdGNoaW5nLCBidXQgY3B1X2lzb2xhdGVkX21hcCBkb2Vzbid0Cj4gZXhpc3Qg
YW55bW9yZS4gQWxzbywgaWYgaXQgc3RlcHMgb24gaXNvbGF0ZWQgQ1BVcywgdGhpcyBpcyB0aGUg
d3JvbmcgZml4Cj4gYW55d2F5LiBMb2FkLWJhbGFuY2luZyBzaG91bGQgYmUgY29uc3RyYWluZWQg
dG8gdGhlIGN1cnJlbnQgcm9vdCBkb21haW4uCkluZGVlZCwgd2UgdXNlZCA0LjE0IHZlcnNpb24g
YW5kIG1hZGUgd3JvbmcgYXNzdW1wdGlvbiwgc29ycnkgZm9yIHRoYXQuCldlIHdpbGwgcmV0ZXN0
IG9uIGxhdGVzdCBtYWlubGluZSB2ZXJzaW9uLCByZXdvcmsgdGhlIHBhdGNoIGFuZCBzZW5kIGFu
b3RoZXIKdmVyc2lvbi4KCj4+IFNpZ25lZC1vZmYtYnk6IENoZW5nIExpbiA8Y2hlbmcubGluMTMw
QHp0ZS5jb20uY24+Cj4+IFNpZ25lZC1vZmYtYnk6IFRhbiBIdSA8dGFuLmh1QHp0ZS5jb20uY24+
Cj4+IFNpZ25lZC1vZmYtYnk6IEppYW5nIEJpYW8gPGppYW5nLmJpYW8yQHp0ZS5jb20uY24+Cj4g
Cj5UaGlzIFNvQiBjaGFpbiBpcyBpbnZhbGlkLgpNbSwgd2UgZG9uJ3QgcXVpdGUgdW5kZXJzdGFu
ZCB3aGF0IHRoZSAqU2lnbmVkLW9mZi1ieSogcHJlY2lzZWx5IG1lYW5zLApEb2VzIGl0IG9ubHkg
bWVhbiBEQ08oZGV2ZWxvcGVyIGNlcnRpZmljYXRlIG9mIG9yaWdpbik/CkFzIHdlIHVuZGVyc3Rv
b2QsIG11bHRpcGxlIFNvQnMgY291bGQgYmUgdXNlZCB0byBpbmRpY2F0ZSBjby1hdXRob3JzLgpJ
ZiBTb0Igb25seSBtZWFucyBEQ08sIGhvdyBjYW4gdGhlIHBhdGNoZXMgcmVmbGVjdCBjby1hdXRo
b3JzPwoKVGhhbmtzIGEgbG90LgpKaWFuZywKUmVnYXJkcw==


--=====_003_next=====--

--=====_001_next=====--

