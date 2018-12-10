Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F43C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BC72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BC72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeLJI7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:59:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45041 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLJI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:59:12 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 730b250b7004801a; Mon, 10 Dec 2018 09:59:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the pm tree
Date:   Mon, 10 Dec 2018 09:58:53 +0100
Message-ID: <9045374.omvoRxFOEf@aspire.rjw.lan>
In-Reply-To: <20181210161454.1c8ca97f@canb.auug.org.au>
References: <20181210161454.1c8ca97f@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 10, 2018 6:14:54 AM CET Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/base/platform.c
> u
> between commit:
> 
>   2d51ac9086fd ("driver core: platform: Remove duplicated device_remove_properties() call")
> 
> from the pm tree and commit:
> 
>   99fef587ff98 ("driver core: platform: Respect return code of platform_device_register_full()")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The fix looks good to me, thank you!

