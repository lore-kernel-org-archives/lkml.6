Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13361C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCF20675
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfADAhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:37:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADAhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:37:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A1B314C1DD1F;
        Thu,  3 Jan 2019 16:37:18 -0800 (PST)
Date:   Thu, 03 Jan 2019 16:37:16 -0800 (PST)
Message-Id: <20190103.163716.1927360927242144906.davem@davemloft.net>
To:     jeffrey.t.kirsher@intel.com
Cc:     Julia.Lawall@lip6.fr, kernel-janitors@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] i40e: increase indentation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
        <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
        <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 03 Jan 2019 16:37:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Jan 2019 15:58:10 -0800

> On Sun, 2018-12-30 at 16:53 +0100, Julia Lawall wrote:
>> Convert spaces to tabs to get correct alignment.
>> 
>> Found with the help of Coccinelle.
>> 
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>> 
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Dave, since this is apart of a series, please feel free to commit this
> patch with the series.

It's kind of net-next material and therefore would need to be re-submitted
anyways when net-next opens up.

Alternatively, Jeff, you can toss it into your -next tree.
