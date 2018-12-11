Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70233C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0BE2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0BE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeLKDpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:45:03 -0500
Received: from mail2.tencent.com ([163.177.67.195]:60150 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeLKDpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:45:03 -0500
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 88E2918329;
        Tue, 11 Dec 2018 11:44:59 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail01.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 11 Dec
 2018 11:44:57 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "kilobyte@angband.pl" <kilobyte@angband.pl>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH v1] binder: implement binderfs(Internet mail)
Thread-Topic: [PATCH v1] binder: implement binderfs(Internet mail)
Thread-Index: AQHUjoRMJUUJwWCJ/U2GsuwwQDeMJ6V3voOAgAEpgHA=
Date:   Tue, 11 Dec 2018 03:44:48 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198FD6A14@EXMBX-SZMAIL022.tencent.com>
References: <20181207232509.31771-1-christian@brauner.io>
 <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
In-Reply-To: <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.21]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBjaG91cnl6aG91QCwgY2FuIHlvdSBjb25maXJtIHRoYXQgdGhpcyBpbXBsZW1lbnRhdGlvbiB3
b3JrcyBmb3IgeW91cg0KPiBhbmRyb2lkLWluLWNvbnRhaW5lciB1c2UtY2FzZT8NCj4gDQo+IC1U
b2RkDQo+IA0KV2UgYXJlIHJ1bm5pbmcgQW5kcm9pZCBQaWUgaW4gY29udGFpbmVyIG5vdy4gSWYg
aXQgd29ya3MgZm9yIGxhdGVyIEFuZHJvaWQgDQpyZWxlYXNlLCBpdCB3aWxsIHdvcmtzIGZvciB1
cy4NCg0KLSBjaG91cnkNCg==
