Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A1C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23B24A79
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B23B24A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeFWBiN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:38:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34054 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933585AbeFWBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:38:11 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9B3212130ECC;
        Fri, 22 Jun 2018 18:38:09 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:38:08 +0900 (KST)
Message-Id: <20180623.103808.1504095881749207713.davem@davemloft.net>
To:     jeffrey.t.kirsher@intel.com
Cc:     me@tobin.cc, corbet@lwn.net, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5718d34758dd55090dbc73441c3b12c6c5c02ff8.camel@intel.com>
References: <20180622003708.31848-1-me@tobin.cc>
        <5718d34758dd55090dbc73441c3b12c6c5c02ff8.camel@intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Jun 2018 18:38:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 22 Jun 2018 09:44:00 -0700

> On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
>> I may be a little confused here, I'm getting docs build failure on
>> Linus' mainline, linux-next, and your docs-next but different errors.
>> There seems to be patches to the first two trees that are not in your
>> docs-next tree?
>> 
>> Do networking docs typically go through your tree?  Looks like
>> networking has done some conversion to rst that hasn't gone through
>> your
>> tree.  Or else my git skills are failing.
> 
> Networking documentation changes went through David Miller's networking
> tree because he maintains changes under Documentation/networking/

I've applied this series of fixes to my 'net' tree, thanks everyone.
