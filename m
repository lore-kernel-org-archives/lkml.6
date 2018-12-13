Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5800EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298B720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeLMAcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:32:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42064 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLMAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:32:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37CC8128FECA2;
        Wed, 12 Dec 2018 16:32:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:32:03 -0800 (PST)
Message-Id: <20181212.163203.1585545691540102737.davem@davemloft.net>
To:     jtoppins@redhat.com
Cc:     netdev@vger.kernel.org, michael.chan@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bnxt: remove printing of hwrm message
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a183bfa67a3c3ca6c62676f01434eb921c9dc008.1544633931.git.jtoppins@redhat.com>
References: <CACKFLi=bOMKnmucRTNUyG=xWYWADJ61COFy2U-7rph0WRWR4Yg@mail.gmail.com>
        <a183bfa67a3c3ca6c62676f01434eb921c9dc008.1544633931.git.jtoppins@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 16:32:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Toppins <jtoppins@redhat.com>
Date: Wed, 12 Dec 2018 11:58:51 -0500

>   bnxt_en 0000:19:00.0 (unregistered net_device) (uninitialized): hwrm
> req_type 0x190 seq id 0x6 error 0xffff
> 
> The message above is commonly seen when a newer driver is used on
> hardware with older firmware. The issue is this message means nothing to
> anyone except Broadcom. Remove the message to not confuse users as this
> message is really not very informative.
> 
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
> 
> Notes:
>     v2:
>       include changes recommended by Michael Chan

Applied, thank you.
