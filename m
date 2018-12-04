Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2444FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26F62146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Dlm14+O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26F62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDFSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:18:02 -0500
Received: from imap.thunk.org ([74.207.234.97]:38978 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbeLDFSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WathNWjjaVjJPt4ScbXrSqhejOEN1+RZmvB8R0nni9g=; b=Dlm14+O6Sb7+hU5vZ8r6RLII0L
        2D5p6nXA9Gh++r7lY6up4HElYj8AMmROrvbAXBgNSuUZ3eWGaZqKUYAoZeoCpJx7jaZ9fZWVQ8LcU
        tjZMfr/eCuGoEv7C41mhzJhzs/rHuP3Ew/dBnA59PtjO9t9o7dyzZExoe1WlOCZ2O/Lo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gU35q-0008LU-R5; Tue, 04 Dec 2018 05:17:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F7407A47E0; Tue,  4 Dec 2018 00:17:57 -0500 (EST)
Date:   Tue, 4 Dec 2018 00:17:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Colin King <colin.king@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: clean up indentation issues, remove extraneous tabs
Message-ID: <20181204051757.GE4981@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Colin King <colin.king@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181123163043.14178-1-colin.king@canonical.com>
 <20181127092836.GD16301@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127092836.GD16301@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:28:36AM +0100, Jan Kara wrote:
> On Fri 23-11-18 16:30:43, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are several lines that are indented too far, clean these
> > up by removing the tabs.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> The patch looks good. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
