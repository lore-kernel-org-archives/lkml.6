Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062AEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CD420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zDqRb6jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CD420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLCKa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeLCKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:30:56 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2954C20851;
        Mon,  3 Dec 2018 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543833028;
        bh=mlk8czJKFEIdJc6C1jlxl5tewOx3lN9QFlJhM8fCWRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zDqRb6jAJECHfK0rA/ngwxXB9hmsUE6pJNNdlfTvWUN0HWNCMFcO1aYAzVcAyVpcH
         MHDHO84mlv3Afh3tZxpas5fGaf1Q/In0iWspPQm41pY+PqiMVKKa23jbijcA4VUt37
         AffITLW9NWhWSHuCEHSO+P387Y1WtKtIsWWHufp8=
Date:   Mon, 3 Dec 2018 11:26:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [patch set 4.19.6] BFS updates
Message-ID: <20181203102631.GA18219@kroah.com>
References: <CAK+_RLnYbyDrqRbm6-AyRmG4=iFrqqL_UrzHuhPO1_jD1F9WSQ@mail.gmail.com>
 <CAK+_RLk=WL1SxtNF7YRw5eLGjcCc9o2dcHodgFw7SoFPSm25Xw@mail.gmail.com>
 <CAK+_RLmJTrc3P0q0rzjoo4LD=g2cyA0eRwoVUtg-V8kPYEg7eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RLmJTrc3P0q0rzjoo4LD=g2cyA0eRwoVUtg-V8kPYEg7eg@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 09:55:23AM +0000, Tigran Aivazian wrote:
> Re-sending the patches with the "Cc: stable@vger.kernel.org" included
> in the sign-off area, as per Option 1 of the rules Greg referred me
> to. I hope that now I have done everything by the rules.

As you want to replace an existing patch in linux-next that is in
Andrew's trees, you need to cc: him :)

Also, you need to send each patch as an individual email, like
Documentation/SubmittingPatches says to do.

This shouldn't be any different from submitting any other patch.

thanks,

greg k-h
