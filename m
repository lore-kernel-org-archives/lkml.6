Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029F32175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029F32175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeHMVeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:34:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeHMVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:34:00 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E411142A5A50;
        Mon, 13 Aug 2018 11:50:33 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:50:32 -0700 (PDT)
Message-Id: <20180813.115032.2269454465608823863.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: remove redundant variables queue_run_ms and left
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180702094705.15734-1-colin.king@canonical.com>
References: <20180702094705.15734-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 11:50:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ29saW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KRGF0ZTogTW9uLCAg
MiBKdWwgMjAxOCAxMDo0NzowNSArMDEwMA0KDQo+IEZyb206IENvbGluIElhbiBLaW5nIDxjb2xp
bi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBWYXJpYWJsZSBxdWV1ZV9ydW5fbXMgaXMgbm90
IGJlaW5nIHVzZWQgYW5kIGlzIHJlZHVuZGFudCBhbmQgaGVuY2UgY2FuDQo+IGJlIHJlbW92ZWQu
IFJlbW92aW5nIHRoaXMgYWxzbyBtZWFucyB0aGF0IHZhcmlhYmxlIGxlZnQgY2FuIGFsc28gYmUN
Cj4gcmVtb3ZlZC4NCj4gDQo+IENsZWFucyB1cCBjbGFuZyB3YXJuaW5nOg0KPiB3YXJuaW5nOiB2
YXJpYWJsZSChcXVldWVfcnVuX21zoiBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0
LXZhcmlhYmxlXQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbT4NCg0KQXBwbGllZC4NCg==
