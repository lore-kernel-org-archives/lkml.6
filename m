Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2E427A26
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1cgrY+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E427A26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935433AbeF2SCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932296AbeF2SCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:02:43 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AAF27A26;
        Fri, 29 Jun 2018 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530295363;
        bh=4M9K+bdCjgLLnkdmstfwUeN/5CU8bZm5aKOKV9ik4hA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=L1cgrY+cpJkfHNcXN67Rqv/r6jhZvIndG/Tp+ds2+IqsSTOHkeDodf0sW0gvGnylk
         z5S1trqFJDOqIhCrdUrAbCqNY0bS++UGkoYFK+d4o/LaaX+ItVqlUf2/crBBgKEvr6
         7U0zDaT+alnGpjzGl8V8yggy+Ml9U8YQ62mFEIaA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528090479-20861-1-git-send-email-mike.looijmans@topic.nl>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
References: <1528090479-20861-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <153029536217.143105.2743197030332094857@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk-si514,
 clk-si544: Implement prepare/unprepare/is_prepared operations
Date:   Fri, 29 Jun 2018 11:02:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2018-06-03 22:34:39)
> This adds prepare/unprepare/is_prepared functionality to the drivers for
> the SI544 and SI514 chips, allowing the clock output to be disabled when
> the clock is not in use.
> =

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next

