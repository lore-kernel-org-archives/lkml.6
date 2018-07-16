Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C087BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C875208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C875208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPV11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:27:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeGPV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:27:26 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 42F331434E864;
        Mon, 16 Jul 2018 13:58:17 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:58:16 -0700 (PDT)
Message-Id: <20180716.135816.2203644668997114867.davem@davemloft.net>
To:     tyhicks@canonical.com
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        stephen@networkplumber.org, dmitry.torokhov@gmail.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace
 objects belong to container
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Jul 2018 13:58:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 13 Jul 2018 16:05:42 +0000

> Eric had previously provided feedback that he didn't favor these changes
> affecting all layers of the stack and that most of the changes could
> remain local to drivers/base/core.c. That feedback is certainly sensible
> but I wanted to send out v2 of the patch set without making that large
> of a change since quite a bit of time has passed and the bridge changes
> in the last patch of this set shows that not all of the changes will be
> local to drivers/base/core.c. I'm happy to make the changes if the
> original request still stands.

I'd like to give Eric an opportunity to review this and give feedback
before applying.

Thanks.
