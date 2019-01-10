Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A9621773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547126953;
	bh=4ywgLt9DcYw65IAZYoC8ZQhmuIRxsvSA7Q9QGfYzB0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SDf0frBLM2SRcB/5zA1HNMGZS2fV9fvBreCPtZEkgpiV2d9jr9w/M06uhw2EPtJxZ
	 FqUgSs/mOAxZfg5ZH4tSAagZXgHDUVp8q1iWl4AnOu3kZypnPUjiMlHkiIUzwA1/YV
	 z8wfcGl61nXHvlw2aFP6M/fa/3fFuPTijNwQNJpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAJN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfAJN3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:29:12 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6617B214C6;
        Thu, 10 Jan 2019 13:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547126951;
        bh=4ywgLt9DcYw65IAZYoC8ZQhmuIRxsvSA7Q9QGfYzB0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLz0ZGbZa+ARg3TrjLnncDHx+ymVuFuFinBEGfTQs9qcH2wC/rXa7si0aXKl32492
         p4Pj72XBLAWmy+HWVD85L7LIrPqfiWyZyYoPZT0MBTaipdoNPR2JMtCQNRWi7ypYFF
         ns99pzWOhbhCA1JawlKzCCozXTFiX2lnLVg0DH7M=
Date:   Thu, 10 Jan 2019 21:29:02 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110132902.GA10138@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
 <20190110080203.GA13262@guoren-Inspiron-7460>
 <20190110132613.GB22569@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110132613.GB22569@pure.paranoia.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:26:13AM -0500, Konstantin Ryabitsev wrote:
> On Thu, Jan 10, 2019 at 04:02:03PM +0800, Guo Ren wrote:
> > Can I take back this pull request and send a new pull request with
> > https:// URLs ?
> 
> It's not necessary at this point, as the pull request has already been
> processed. However, your future emails should have the public URL of the
> git repository.
OK

Best Regards
 Guo Ren
