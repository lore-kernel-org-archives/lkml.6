Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119B3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA12E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA12E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeH2NvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:51:07 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:59164 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbeH2NvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:51:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-53-P34sVcJBN6asUW4_5sMfYw-1; Wed, 29 Aug 2018 10:54:58 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 29 Aug 2018 10:56:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 Aug 2018 10:56:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 4.19-rc1
Thread-Topic: Linux 4.19-rc1
Thread-Index: AQHUPYbm+S/YO6rz0Ue6UxW4KRpWPqTWgddg
Date:   Wed, 29 Aug 2018 09:56:37 +0000
Message-ID: <1ffc0bab16dd48549ec8a8433f248258@AcuMS.aculab.com>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
In-Reply-To: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: P34sVcJBN6asUW4_5sMfYw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgQXVndXN0IDIwMTggMjI6NDkNCj4gDQo+
IFNvIHR3byB3ZWVrcyBoYXZlIHBhc3NlZCwgYW5kIHRoZSBtZXJnZSB3aW5kb3cgZm9yIDQuMTkg
aXMgb3Zlci4NCj4gDQo+IFRoaXMgd2FzIGEgZmFpcmx5IGZydXN0cmF0aW5nIG1lcmdlIHdpbmRv
dywgcGFydGx5IGJlY2F1c2UgNC4xOSBsb29rcw0KPiB0byBiZSBhIHByZXR0eSBiaWcgcmVsZWFz
ZSAobm8gc2luZ2xlIHJlYXNvbiksIGFuZCBwYXJ0bHkganVzdCBkdWUgdG8NCj4gcmFuZG9tIG5v
aXNlLg0KLi4uDQoNClRpbWUgZm9yIDUuMCA/Pw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

