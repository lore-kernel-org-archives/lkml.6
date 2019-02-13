Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B096C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02572222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550043432;
	bh=rLC96h+IaoAKtg2aAZt3L5CQwkA1Kp6RMQaIhg05jE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j8w9uPBmFPz/xUVIRMEUR1HOrvX1Uqn5B8U3bHvWeQALNXW5ZwWm8e/mSInA6wvey
	 wXoEid1TkXm8mZzuUqMiT//rtvyT15qqVBVkok9o5/AjDNqM7lCzWuzarVIrpBRCqg
	 aFbIoblBbTXOKXhEU9VVwEAM3tJ0/kq7BA26BSVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbfBMHhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfBMHhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:37:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38997222BE;
        Wed, 13 Feb 2019 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550043429;
        bh=rLC96h+IaoAKtg2aAZt3L5CQwkA1Kp6RMQaIhg05jE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlCMdEMnH2dX4qAEhclGf01Eui8Giyb9rQEvI+I+3G4Oy4kq6T1w4krxxTxxf4/OY
         FteCuRDhBeenFUYzCul1dka2Fh9xgMhoIbVpCQozCpWX3LYHp6fa29xZ5hD1NFiYUN
         vCHBF9UGRMehYWTzavVBX7F40/lpS0ltw8ATpUKk=
Date:   Wed, 13 Feb 2019 08:37:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Steve French <smfrench@gmail.com>, Sasha Levin <sashal@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190213073707.GA2875@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:20:00AM +0200, Amir Goldstein wrote:
> I never saw an email from you or Greg saying, the branch "stable-xxx" is
> in review. Please run your tests.

That is what my "Subject: [PATCH 4.9 000/137] 4.9.156-stable review"
type emails are supposed to kick off.  They are sent both to the stable
mailing list and lkml.

This message already starts the testing systems going for a number of
different groups out there, do you want to be added to the cc: list so
you get them directly?

thanks,

greg k-h
