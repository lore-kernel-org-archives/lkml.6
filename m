Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1584920856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1584920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeGYBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:39:44 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:49210 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGYBjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:39:44 -0400
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
        by Forcepoint Email with ESMTPS id AC27CC359BB4C48316A9;
        Wed, 25 Jul 2018 08:30:41 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
        by mse02.zte.com.cn with SMTP id w6P0U2rq096564;
        Wed, 25 Jul 2018 08:30:02 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from mapi (kjyxapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 25 Jul 2018 08:30:03 +0800 (CST)
Date:   Wed, 25 Jul 2018 08:30:03 +0800 (CST)
X-Zmail-TransId: 2b065b57c48b734b4e87
X-Mailer: Zmail v1.0
Message-ID: <201807250830037580322@zte.com.cn>
In-Reply-To: <20180724090651.GK2494@hirez.programming.kicks-ass.net>
References: 20180723084031.GX2494@hirez.programming.kicks-ass.net,20180724090651.GK2494@hirez.programming.kicks-ass.net
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
X-MAIL: mse02.zte.com.cn w6P0U2rq096564
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

SGksCj4gT24gVHVlLCBKdWwgMjQsIDIwMTggYXQgMDk6MTE6MzdBTSArMDgwMCwgamlhbmcuYmlh
bzJAenRlLmNvbS5jbiB3cm90ZToKPgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuZyBMaW4gPGNo
ZW5nLmxpbjEzMEB6dGUuY29tLmNuPgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBUYW4gSHUgPHRhbi5o
dUB6dGUuY29tLmNuPgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBKaWFuZyBCaWFvIDxqaWFuZy5iaWFv
MkB6dGUuY29tLmNuPgo+PiA+Cj4+ID5UaGlzIFNvQiBjaGFpbiBpcyBpbnZhbGlkLgo+Cj4+IE1t
LCB3ZSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoYXQgdGhlICpTaWduZWQtb2ZmLWJ5KiBwcmVj
aXNlbHkgbWVhbnMsCj4+IERvZXMgaXQgb25seSBtZWFuIERDTyhkZXZlbG9wZXIgY2VydGlmaWNh
dGUgb2Ygb3JpZ2luKT8KPj4gQXMgd2UgdW5kZXJzdG9vZCwgbXVsdGlwbGUgU29CcyBjb3VsZCBi
ZSB1c2VkIHRvIGluZGljYXRlIGNvLWF1dGhvcnMuCj4+IElmIFNvQiBvbmx5IG1lYW5zIERDTywg
aG93IGNhbiB0aGUgcGF0Y2hlcyByZWZsZWN0IGNvLWF1dGhvcnM/Cj4KPiBJdCBzcGVjaWZpY2Fs
bHkgZG9lcyBub3QgYWxsb3cgZm9yIGNvLWF1dGhvcnNoaXAuIEkgdGhpbmsgdGhlcmUncyBhCj4g
Q28tQXV0aG9yZWQtYnk6IHRhZyBpbnZlbnRlZCBieSBzb21lIHBlb3BsZSAoY2hlY2sgdGhlIGdp
dCBsb2dzKSBidXQKPiBlc3BlY2lhbGx5IGZvciBzdWNoIGEgZGlua3kgbGl0dGxlIHBhdGNoLCBJ
IHdvdWxkbid0IGJvdGhlci4gTWF5YmUgaGF2ZQo+IHlvdXIgY28td29ya2VycyByZXZpZXcgdGhl
IHBhdGNoIG9yIHNvbWV0aGluZy4KSSBkbyBmaW5kIHNvbWUodmVyeSBmZXcpIENvLUF1dGhvcmVk
LWJ5IGluIGdpdCBsb2dzLCBhbmQgd2UnbGwgdHJ5IHRvIGF2b2lkCnVzaW5nIHRoYXQuIFNvbWV0
aW1lcyBsaXR0bGUgcGF0Y2hlcyBtYXkgaW5jbHVkZSBtdWNoIGJhY2tncm91bmQgd29yayBvZgpk
aWZmZXJlbnQgcGVvcGxlLjopIApUaGFua3MgbG90LgoKSmlhbmcsClJlZ2FyZA==


--=====_003_next=====--

--=====_001_next=====--

