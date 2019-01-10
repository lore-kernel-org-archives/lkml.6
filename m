Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8844EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58339206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547107333;
	bh=ngrn5EKXiRHgwMJpQBZLgEycaRsgPQvINk5RBqB8lKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pm92MYkdxk9Vlwn1Il9+jnj55qyyX8EtBuNon67Y9E7XtUPD9AAoSQHYP5SH5+m9Z
	 OLFoJJSQByVlbyT5BiXH3KZCnzfTuVT/x9VsRkTTskTKOHN2HcA3xROqR2yNqWgow5
	 9EukTr6RmE1zWCCmkzBQ2IJ3aX5LAGYAxw2K3q4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfAJICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAJICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:02:10 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1541F2173B;
        Thu, 10 Jan 2019 08:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547107329;
        bh=ngrn5EKXiRHgwMJpQBZLgEycaRsgPQvINk5RBqB8lKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpPMYMvtFrO2g1E5D3hTQJQnLBaghKOhpJ8je3k2Iu4bA8OYrDBnBPJQ6WuNB67S3
         bWfJ7tmoUakjk/GT5FauJV/lMKExaLobJ2J4EOggDFcjdUc9uiOX6ibDz7XSKAp3l4
         hIaeSHrBUHdFVlDXZwTf0iuKXnBZaE77KvGqVyt8=
Date:   Thu, 10 Jan 2019 16:02:03 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110080203.GA13262@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109182955.GC30131@pure.paranoia.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I take back this pull request and send a new pull request with
https:// URLs ?

On Wed, Jan 09, 2019 at 01:29:55PM -0500, Konstantin Ryabitsev wrote:
> On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> > 
> > > (unable to parse the git remote)
> 
> I just committed a fix for this. We weren't expecting URLs without ://
> in them.
> 
> -K
