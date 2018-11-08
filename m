Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D480ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF392086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF392086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKHXzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:55:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50800 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbeKHXzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:55:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-Nmpiwt8OP0qWcaypkvLvqQ-1;
 Thu, 08 Nov 2018 14:19:22 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 8 Nov 2018 14:19:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 8 Nov 2018 14:19:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Jeffery' <andrew@aj.id.au>,
        Colin King <colin.king@canonical.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" ->
 "[En]queuing"
Thread-Topic: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" ->
 "[En]queuing"
Thread-Index: AQHUdwYjo3X9lWFxN0a2wOk/LEM10KVF7d8A
Date:   Thu, 8 Nov 2018 14:19:27 +0000
Message-ID: <66d0fa13f6b6409bbc6b080ae58273ff@AcuMS.aculab.com>
References: <20180929114313.10557-1-colin.king@canonical.com>
 <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
In-Reply-To: <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Nmpiwt8OP0qWcaypkvLvqQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmV3IEplZmZlcnkNCj4gU2VudDogMDggTm92ZW1iZXIgMjAxOCAwMTo1NQ0KPiA+
IC0JCUVQREJHKGVwLCJFbnF1ZWluZyByZXF1ZXN0IG9uIHdyb25nIG9yIGRpc2FibGVkIEVQXG4i
KTsNCj4gPiArCQlFUERCRyhlcCwgIkVucXVldWluZyByZXF1ZXN0IG9uIHdyb25nIG9yIGRpc2Fi
bGVkIEVQXG4iKTsNCg0KU2hvdWxkbid0IGl0IGJlIEVucXVldWVpbmcgPw0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

