Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D371C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B0E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeIDL4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:56:46 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:32840 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIDL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:56:45 -0400
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="19303084"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Sep 2018 00:32:53 -0700
Received: from CHN-SV-EXMX06.mchp-main.com ([fe80::c5f4:117d:550d:f375]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%13]) with mapi id
 14.03.0352.000; Tue, 4 Sep 2018 00:32:53 -0700
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <stefan.wahren@i2se.com>, <Woojung.Huh@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
Thread-Topic: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
Thread-Index: AQHUQ6lkx4ZgI85Q5kuCL2/ljWwcN6Tfh6kAgACnpYD//4v10A==
Date:   Tue, 4 Sep 2018 07:32:52 +0000
Message-ID: <0573C9D4B793EF43BF95221F2F4CC8515913E7@CHN-SV-EXMX06.mchp-main.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
 <1535994759-8938-4-git-send-email-stefan.wahren@i2se.com>
 <0573C9D4B793EF43BF95221F2F4CC8515912C3@CHN-SV-EXMX06.mchp-main.com>
 <21c3f5d9-c884-3c78-6441-dbfd47001ffe@i2se.com>
In-Reply-To: <21c3f5d9-c884-3c78-6441-dbfd47001ffe@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.7]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBpIGRvbid0IHRoaW5rIHdlIGNhbiBkbyB0aGlzLiBJJ20gc2ltcGx5IGZvbGxvd2luZyB0aGlz
IGd1aWRlbGluZSBbMV0uDQo+IA0KPiBIb3cgYWJvdXQgdGhpczoNCj4gDQo+IC8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiAvKg0KPiDCoCogQ29weXJpZ2h0IChDKSAyMDE1
IE1pY3JvY2hpcCBUZWNobm9sb2d5DQo+IMKgKi8NCj4gDQo+IFsxXSAtIGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvdjQuMTgvcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLmh0bWwNCj4gDQpU
aGFuayB5b3UuDQpMb29rcyBnb29kIHRvIG1lLg0KDQpUaGFua3MsDQotUmFnaHUNCg0K
