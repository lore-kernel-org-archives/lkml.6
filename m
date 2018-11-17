Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521832086A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521832086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbeKQOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:32:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbeKQOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:32:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC11A13F186F9;
        Fri, 16 Nov 2018 20:16:53 -0800 (PST)
Date:   Fri, 16 Nov 2018 20:16:53 -0800 (PST)
Message-Id: <20181116.201653.643709639983122056.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     netdev@vger.kernel.org, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        steve.glendinning@shawell.net, linux-kernel@lists.codethink.co.uk
Subject: Re: SMSC95xx driver updates (round 1)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 20:16:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 14 Nov 2018 11:50:18 +0000

> This is a series of a few driver cleanups and some fixups of the code
> for the SMSC95XX driver. There have been a few reviews, and the issues
> have been fixed so this should be ready for merging.
> 
> I will work on the tx-alignment and the other bits of usbnet changes
> and produce at least two more patch series for this later.

Series applied with the missing space in the comment of patch #4 fixed.

Thanks.
