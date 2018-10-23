Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F16C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57213207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57213207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJWPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:03:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36316 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:03:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEqN1-0005pZ-AJ; Tue, 23 Oct 2018 06:40:51 +0000
Date:   Tue, 23 Oct 2018 07:40:51 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, NeilBrown <neil@brown.name>,
        Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023064051.GX32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181022224604.GM1617@thunk.org>
 <20181023062652.yrns7n67jkuict5n@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023062652.yrns7n67jkuict5n@mwanda>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:26:52AM +0300, Dan Carpenter wrote:

> Ten years back there was a patch rejected because "F*** you, what do
> women know about programming?"  I can't imagine it happening now, but I
> was so shocked by it at the time also...

URL?  I would really, honestly, no kidding, like to know who had that
been (and where had that been, while we are at it).  I would expect
a massive (and absolutely deserved) shitstorm if that was on any
public kernel-related lists 10 years ago, but I'm not reading all
of them, obviously...
