Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8160C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7078A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7078A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeHAUCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:02:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49670 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404942AbeHATHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:08 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52383100A56E7;
        Wed,  1 Aug 2018 10:01:09 -0700 (PDT)
Date:   Wed, 01 Aug 2018 10:01:08 -0700 (PDT)
Message-Id: <20180801.100108.2283603494879452693.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     santosh.shilimkar@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: remove redundant variable 'rds_ibdev'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180801071407.22044-1-yuehaibing@huawei.com>
References: <20180801071407.22044-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 10:01:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KRGF0ZTogV2VkLCAxIEF1
ZyAyMDE4IDE1OjE0OjA3ICswODAwDQoNCj4gVmFyaWFibGUgJ3Jkc19pYmRldicgaXMgYmVpbmcg
YXNzaWduZWQgYnV0IG5ldmVyIHVzZWQsDQo+IHNvIGNhbiBiZSByZW1vdmVkLg0KPiANCj4gZml4
IHRoaXMgY2xhbmcgd2FybmluZzoNCj4gIG5ldC9yZHMvaWJfc2VuZC5jOjc2MjoyNDogd2Fybmlu
ZzogdmFyaWFibGUgoXJkc19pYmRldqIgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdA
aHVhd2VpLmNvbT4NCg0KQXBwbGllZC4NCg==
