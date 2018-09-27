Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1471CC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2262215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2262215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0RP6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:15:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47122 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:15:58 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 72402CF16A;
        Thu, 27 Sep 2018 13:05:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH V3] Bluetooth: bt3c_cs: Fix obsolete function
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1535338500-7682-1-git-send-email-dingxiang@cmss.chinamobile.com>
Date:   Thu, 27 Sep 2018 12:58:14 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8B1963A4-F0B0-4F17-816E-3D4E6715ED31@holtmann.org>
References: <1535338500-7682-1-git-send-email-dingxiang@cmss.chinamobile.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ding,

> simple_strtol and simple_strtoul are obsolete, both place
> use kstrtouint instead.
> 
> V2: fix error tmp += tn
> V3: fix compile error
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
> drivers/bluetooth/bt3c_cs.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

