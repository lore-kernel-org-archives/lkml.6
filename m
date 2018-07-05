Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5416C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE632086E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE632086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeGEFYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:24:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeGEFYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:24:15 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 10A8C108CE7DA;
        Wed,  4 Jul 2018 22:24:13 -0700 (PDT)
Date:   Thu, 05 Jul 2018 14:24:12 +0900 (KST)
Message-Id: <20180705.142412.238281898262839575.davem@davemloft.net>
To:     treeze.taeung@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, qinteng@fb.com
Subject: Re: [PATCH v2 2/4] samples/bpf: Check the result of system()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180704133639.11855-3-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
        <20180704133639.11855-3-treeze.taeung@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Jul 2018 22:24:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGFldW5nIFNvbmcgPHRyZWV6ZS50YWV1bmdAZ21haWwuY29tPg0KRGF0ZTogV2VkLCAg
NCBKdWwgMjAxOCAyMjozNjozNyArMDkwMA0KDQo+IFRvIGF2b2lkIHRoZSBiZWxvdyBidWlsZCB3
YXJuaW5nIG1lc3NhZ2UsDQo+IHVzZSBuZXcgZ2VuZXJhdGVfbG9hZCgpIGNoZWNraW5nIHRoZSBy
ZXR1cm4gdmFsdWUuDQo+IA0KPiAgIGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiChc3lzdGVtoiwg
ZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgd2Fybl91bnVzZWRfcmVzdWx0DQo+IA0KPiBBbmQgaXQg
YWxzbyByZWZhY3RvcnMgdGhlIGR1cGxpY2F0ZSBjb2RlIG9mIGJvdGgNCj4gdGVzdF9wZXJmX2V2
ZW50X2FsbF9jcHUoKSBhbmQgdGVzdF9wZXJmX2V2ZW50X3Rhc2soKQ0KPiANCj4gQ2M6IFRlbmcg
UWluIDxxaW50ZW5nQGZiLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGFldW5nIFNvbmcgPHRyZWV6
ZS50YWV1bmdAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBk
YXZlbWxvZnQubmV0Pg0K
