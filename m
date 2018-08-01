Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A33C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881F208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881F208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406780AbeHATMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49816 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406203AbeHATMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:09 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EEE971088664D;
        Wed,  1 Aug 2018 10:00:27 -0700 (PDT)
Date:   Wed, 01 Aug 2018 10:00:26 -0700 (PDT)
Message-Id: <20180801.100026.1079178365659344973.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     doronrk@fb.com, tom@quantonium.net, vakul.garg@nxp.com,
        davejwatson@fb.com, ebiggers@google.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] strparser: remove redundant variable 'rd_desc'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180801071037.12508-1-yuehaibing@huawei.com>
References: <20180801071037.12508-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 10:00:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KRGF0ZTogV2VkLCAxIEF1
ZyAyMDE4IDE1OjEwOjM3ICswODAwDQoNCj4gVmFyaWFibGUgJ3JkX2Rlc2MnIGlzIGJlaW5nIGFz
c2lnbmVkIGJ1dCBuZXZlciB1c2VkLA0KPiBzbyBjYW4gYmUgcmVtb3ZlZC4NCj4gDQo+IGZpeCB0
aGlzIGNsYW5nIHdhcm5pbmc6DQo+IG5ldC9zdHJwYXJzZXIvc3RycGFyc2VyLmM6NDExOjIwOiB3
YXJuaW5nOiB2YXJpYWJsZSChcmRfZGVzY6Igc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0
LXNldC12YXJpYWJsZV0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJp
bmdAaHVhd2VpLmNvbT4NCg0KQXBwbGllZC4NCg==
