Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31048ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C8620684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C8620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeGRFRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:17:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeGRFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:17:52 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0CB4100821E3;
        Tue, 17 Jul 2018 21:41:54 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:41:52 +0900 (KST)
Message-Id: <20180718.134152.1719446664161643330.davem@davemloft.net>
To:     tyhicks@canonical.com
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        stephen@networkplumber.org, dmitry.torokhov@gmail.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace
 objects belong to container
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718.131734.1797450417729100374.davem@davemloft.net>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
        <20180718.131734.1797450417729100374.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 21:41:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogV2VkLCAxOCBK
dWwgMjAxOCAxMzoxNzozNCArMDkwMCAoS1NUKQ0KDQo+IE9rLCBJIGNhbid0IGxldCB0aGlzIHNl
cmllcyByb3QgZm9yZXZlciwgc28gSSdsbCBhcHBseSBpdCB0byBuZXQtbmV4dC4NCg0KVW5mb3J0
dW5hdGVseSwgSSBoYWQgdG8gcmV2ZXJ0LCB0aGlzIGJyZWFrcyB0aGUgYnVpbGQ6DQoNCmFyY2gv
eDg2L2tlcm5lbC9jcHUvaW50ZWxfcmR0X3JkdGdyb3VwLmM6MTUwNjo3OiBlcnJvcjogdG9vIGZl
dyBhcmd1bWVudHMgdG8gZnVuY3Rpb24goV9fa2VybmZzX2NyZWF0ZV9maWxlog0KICBrbiA9IF9f
a2VybmZzX2NyZWF0ZV9maWxlKHBhcmVudF9rbiwgbmFtZSwgMDQ0NCwgMCwNCg==
