Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AFEECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75320880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeISIan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:30:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbeISIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6844A36A5F5;
        Wed, 19 Sep 2018 02:55:00 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82641C1785;
        Wed, 19 Sep 2018 02:54:57 +0000 (UTC)
Date:   Tue, 18 Sep 2018 19:54:56 -0700 (PDT)
Message-Id: <20180918.195456.1557976111284221132.davem@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     sameo@linux.intel.com, netdev@vger.kernel.org,
        allen.pais@oracle.com, keescook@chromium.org, surenb@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NFC fixes for 4.19-final
From:   David Miller <davem@redhat.com>
In-Reply-To: <20180917135141.28328-1-gregkh@linuxfoundation.org>
References: <20180917135141.28328-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Sep 2018 02:55:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 17 Sep 2018 15:51:39 +0200

> For some reason, these two NFC patches fell through the cracks.  It
> looks like sometimes NFC patches go through the wireless tree, and
> other times, through the networking tree directly.
> 
> I don't care which way they go, but they should get merged through some
> way, or, I can take them in my device tree, but that feels a bit odd to
> me.

I'll take these directly, thanks Greg.
