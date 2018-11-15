Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFEFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005702086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005702086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeKPFoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:44:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeKPFoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:44:11 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DFB1F1479418D;
        Thu, 15 Nov 2018 11:35:03 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:35:01 -0800 (PST)
Message-Id: <20181115.113501.2215768757973757171.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     sbrivio@redhat.com, sd@queasysnail.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] geneve: Add missing braces in addr6 initializer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181112221248.11477-1-natechancellor@gmail.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Nov 2018 11:35:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4NCkRhdGU6
IE1vbiwgMTIgTm92IDIwMTggMTU6MTI6NDggLTA3MDANCg0KPiBDbGFuZyB3YXJuczoNCj4gDQo+
IGRyaXZlcnMvbmV0L2dlbmV2ZS5jOjQyODoyOTogZXJyb3I6IHN1Z2dlc3QgYnJhY2VzIGFyb3Vu
ZCBpbml0aWFsaXphdGlvbg0KPiBvZiBzdWJvYmplY3QgWy1XZXJyb3IsLVdtaXNzaW5nLWJyYWNl
c10NCj4gICAgICAgICAgICAgICAgIHN0cnVjdCBpbjZfYWRkciBhZGRyNiA9IHsgMCB9Ow0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHt9DQo+IA0KPiBGaXhlczogYTA3OTY2NDQ3
ZjM5ICgiZ2VuZXZlOiBJQ01QIGVycm9yIGxvb2t1cCBoYW5kbGVyIikNCj4gU2lnbmVkLW9mZi1i
eTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4NCg0KQW5kIHRo
aXMgbWFrZXMgR0NDIHdhcm4uDQoNCmRyaXZlcnMvbmV0L2dlbmV2ZS5jOiBJbiBmdW5jdGlvbiDi
gJhnZW5ldmVfdWRwX2VuY2FwX2Vycl9sb29rdXDigJk6DQpkcml2ZXJzL25ldC9nZW5ldmUuYzo0
Mjg6Mjc6IHdhcm5pbmc6IG1pc3NpbmcgYnJhY2VzIGFyb3VuZCBpbml0aWFsaXplciBbLVdtaXNz
aW5nLWJyYWNlc10NCiAgIHN0cnVjdCBpbjZfYWRkciBhZGRyNiA9IHsgeyAwIH0gfTsNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7
IH0NCg0K77yI4pWvwrDilqHCsO+8ieKVr++4tSDilLvilIHilLsNCg==
