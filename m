Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8D92084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8D92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeKQRSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:18:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:18:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E6E41402B910;
        Fri, 16 Nov 2018 23:03:02 -0800 (PST)
Date:   Fri, 16 Nov 2018 23:03:01 -0800 (PST)
Message-Id: <20181116.230301.629582236801848278.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     isdn@linux-pingi.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, natechancellor@gmail.com
Subject: Re: [PATCH net-next] isdn/hisax: remove set but not used variable
 'total'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115022303.22604-1-yuehaibing@huawei.com>
References: <20181115022303.22604-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 23:03:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KRGF0ZTogVGh1LCAxNSBO
b3YgMjAxOCAxMDoyMzowMyArMDgwMA0KDQo+IEZpeGVzIGdjYyAnLVd1bnVzZWQtYnV0LXNldC12
YXJpYWJsZScgd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvaXNkbi9oaXNheC9oZmNfcGNpLmM6Mjc3
OjY6IHdhcm5pbmc6DQo+ICB2YXJpYWJsZSChdG90YWyiIHNldCBidXQgbm90IHVzZWQgWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+IA0KPiBJdCBuZXZlciB1c2VkIHNpbmNlIGdpdCBoaXN0
b3J5IHN0YXJ0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0Bo
dWF3ZWkuY29tPg0KDQpBcHBsaWVkLg0K
