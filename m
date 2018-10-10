Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B992086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B992086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeJKF54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:57:56 -0400
Received: from thyrsus.com ([71.162.243.5]:42680 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKF54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:57:56 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 40E793A42A6; Wed, 10 Oct 2018 18:33:19 -0400 (EDT)
Date:   Wed, 10 Oct 2018 18:33:19 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
Message-ID: <20181010223319.GA31256@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Josh Triplett <josh@joshtriplett.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
 <20181010221611.GA5711@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010221611.GA5711@localhost>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org>:
> > The words removed by this patch are a political statement.
> 
> Choosing not to say those words is a political statement.

The situation is not symmetrical.  Choosing the protected classes
in the CoC is a *change* in its implied politics. 

It's a change that is, obviously from LKML traffic, very contentious.
If this were a tpurely technical matter, it would be described as
not backwards-compatible.

It's a change that, I submit, should not have been made without a clear
consensus *in favor* of the change.

Our culture has a process for this. It's called RFCs. If we want to
designate protected classes to be called out in conductt guidelines,
an RFC should be floated first and the change should be made only
if rough consensus has been achieved.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


