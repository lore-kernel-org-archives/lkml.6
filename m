Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7404ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A262075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A262075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeGRXIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:08:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbeGRXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:08:46 -0400
Received: from localhost (50-234-71-226-static.hfc.comcastbusiness.net [50.234.71.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D7E5A147A412D;
        Wed, 18 Jul 2018 15:28:45 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:28:45 +0900 (KST)
Message-Id: <20180719.072845.739644123972982742.davem@davemloft.net>
To:     me@tobin.cc
Cc:     markus.heiser@darmarit.de, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] docs: Convert alias and bridge to rst
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718032736.8000-1-me@tobin.cc>
References: <20180718032736.8000-1-me@tobin.cc>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 15:28:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <me@tobin.cc>
Date: Wed, 18 Jul 2018 13:27:34 +1000

> Here is my first attempt at working on converting docs in
> Documentation/networking to rst format.  I've picked a couple of trivial
> ones to start with.  If there is anything extra I can do to make your
> life easier during documentation conversion please say.  (Also if there
> is some reason that it would be preferable to _not_ embark on this task
> please say :)
> 
> This set does not make any changes to the converted files apart from
> formatting.
 ...
> v2:
>  - remove incorrect patch from set (changing 'Indices' indentation)

Series applied, thanks Tobin.
