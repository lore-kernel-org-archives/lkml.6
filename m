Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D64ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789082083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="c/HycySz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789082083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeJUQlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 12:41:37 -0400
Received: from imap.thunk.org ([74.207.234.97]:41132 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeJUQlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=I0e1Ac5uDdjSFXjrLaoW+wty7EnZAAN3M7OPZ/15jtA=; b=c/HycySzKnqG+oryo28yJsAjyH
        cJ1N1twFwVnMnMwsk4YjTPTH8wGdVGKGsNlsIVEFdkQdSpE4E91kgc+h7FlGU997lbe1Dv6aVNfU8
        ogaOsBPrZiDv09NBOjgUu1txpS3GnsN4j3oKSsHZViibz84va38DbzgWHCc7/KQLbduk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gE95b-000469-15; Sun, 21 Oct 2018 08:27:59 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 190F17A2F4E; Sun, 21 Oct 2018 04:27:57 -0400 (EDT)
Date:   Sun, 21 Oct 2018 04:27:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc:     trondmy@hammerspace.com, gnomes@lxorguk.ukuu.org.uk,
        Greg KH <gregkh@linuxfoundation.org>, mishi@linux.com,
        ksummit-discuss@lists.linuxfoundation.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
 contact email address
Message-ID: <20181021082757.GB1617@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "jonsmirl@gmail.com" <jonsmirl@gmail.com>, trondmy@hammerspace.com,
        gnomes@lxorguk.ukuu.org.uk, Greg KH <gregkh@linuxfoundation.org>,
        mishi@linux.com, ksummit-discuss@lists.linuxfoundation.org,
        lkml <linux-kernel@vger.kernel.org>
References: <20181020134908.GA32218@kroah.com>
 <20181020135118.GG32218@kroah.com>
 <20181020192845.48b8b860@alans-desktop>
 <dfabf8b10d3e825c9a7f6c110e042dc72e50217d.camel@hammerspace.com>
 <CAKON4OxLLhUkPGGbSF_ZtBC18fzZo44t1gUSsbYA0d2vCPfosg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKON4OxLLhUkPGGbSF_ZtBC18fzZo44t1gUSsbYA0d2vCPfosg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 03:14:20PM -0400, jonsmirl@gmail.com wrote:
> 
> Which is why the lawyers need to go over this document and I haven't
> seen anything posted from them. In the same vein Mauro is concerned
> that the way this is code is written it is a binding contract in
> Brazil.

My understanding is that lawyers from the Linux Foundation have gone
over both the CoC and as well as the changes in this patchset, and
that this happened before they were sent out.

						- Ted
