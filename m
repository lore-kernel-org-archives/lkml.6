Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D2C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2A2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA2A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeLMAY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:24:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLMAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:24:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15E27149AF4E2;
        Wed, 12 Dec 2018 16:06:10 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:06:09 -0800 (PST)
Message-Id: <20181212.160609.1564345085630799191.davem@davemloft.net>
To:     nhorman@tuxdriver.com
Cc:     lucien.xin@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, dave.hansen@linux.intel.com,
        rientjes@google.com, eparis@redhat.com, khorenko@virtuozzo.com
Subject: Re: [PATCHv2 net 0/3] net: add support for flex_array_resize in
 flex_array
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212120015.GA7637@hmswarspite.think-freely.org>
References: <cover.1544163962.git.lucien.xin@gmail.com>
        <20181211.225000.726755542677275663.davem@davemloft.net>
        <20181212120015.GA7637@hmswarspite.think-freely.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 16:06:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Horman <nhorman@tuxdriver.com>
Date: Wed, 12 Dec 2018 07:00:15 -0500

> I suggest xin respond to messageid
> 20180523011821.12165-6-kent.overstreet@gmail.com> and send a NAK,
> indicating that his patch seems like it will break the build, as,
> looking through it, it never removes flex_array calls from the sctp
> code.  If kent reposts with a conversion of the sctp code to radix
> trees, we're done.  If not, you can move forward with this commit.

Ok, Xin please do that so we can more forward.

Thanks Neil.
