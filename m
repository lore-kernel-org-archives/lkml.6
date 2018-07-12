Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76857C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4421479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeGLHKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:10:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeGLHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:10:38 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2610140D2A4E;
        Thu, 12 Jul 2018 00:02:25 -0700 (PDT)
Date:   Thu, 12 Jul 2018 00:02:25 -0700 (PDT)
Message-Id: <20180712.000225.299971432181835272.davem@davemloft.net>
To:     emilne@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fix spelling mistake "successffuly" ->
 "successfully"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531232844-23004-1-git-send-email-emilne@redhat.com>
References: <1531232844-23004-1-git-send-email-emilne@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 00:02:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ewan D. Milne" <emilne@redhat.com>
Date: Tue, 10 Jul 2018 10:27:24 -0400

> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> Trivial fix to spelling mistake in qed_probe message.
> 
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>

Applied, thanks.
