Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D616C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B350020891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B350020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeGZGtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:49:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33248 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbeGZGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:49:35 -0400
Received: from localhost (unknown [172.58.43.249])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54C3C12DE580C;
        Wed, 25 Jul 2018 22:34:28 -0700 (PDT)
Date:   Wed, 25 Jul 2018 22:34:27 -0700 (PDT)
Message-Id: <20180725.223427.566027515457701460.davem@davemloft.net>
To:     anders.roxell@linaro.org
Cc:     santosh.shilimkar@oracle.com, ka-cheong.poon@oracle.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180725222008.32186-1-anders.roxell@linaro.org>
References: <20180725222008.32186-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 22:34:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPg0KRGF0ZTogVGh1
LCAyNiBKdWwgMjAxOCAwMDoyMDowOCArMDIwMA0KDQo+IEJ1aWxkIGVycm9yLCBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiBfX2luZXQ2X2VoYXNoZm4gc2hvd3MgdXANCj4gV2hlbiBS
RFMgaXMgZW5hYmxlZCBidXQgbm90IElQVjYuDQo+IG5ldC9yZHMvY29ubmVjdGlvbi5jOiBJbiBm
dW5jdGlvbiChcmRzX2Nvbm5fYnVja2V0ojoNCj4gbmV0L3Jkcy9jb25uZWN0aW9uLmM6Njc6OTog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIKFfX2luZXQ2X2VoYXNoZm6i
OyBkaWQgeW91IG1lYW4goV9faW5ldF9laGFzaGZuoj8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dDQo+ICAgaGFzaCA9IF9faW5ldDZfZWhhc2hmbihsaGFzaCwgMCwgZmhh
c2gsIDAsIHJkc19oYXNoX3NlY3JldCk7DQo+ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KPiAg
ICAgICAgICBfX2luZXRfZWhhc2hmbg0KPiANCj4gQ3VycmVudCBjb2RlIGFkZHMgSVBWNiBhcyBh
IGRlcGVuZHMgb24gaW4gY29uZmlnIFJEUy4NCj4gDQo+IEZpeGVzOiBlZWUyZmE2YWIzMjIgKCJy
ZHM6IENoYW5naW5nIElQIGFkZHJlc3MgaW50ZXJuYWwgcmVwcmVzZW50YXRpb24gdG8gc3RydWN0
IGluNl9hZGRyIikNCj4gU2lnbmVkLW9mZi1ieTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVs
bEBsaW5hcm8ub3JnPg0KDQpBcHBsaWVkLg0K
