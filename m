Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41AECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17C120836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17C120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJVGmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 02:42:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39623 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJVGmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 02:42:04 -0400
X-Originating-IP: 167.98.65.38
Received: from localhost (unknown [167.98.65.38])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 46F541BF204;
        Sun, 21 Oct 2018 22:26:09 +0000 (UTC)
Date:   Sun, 21 Oct 2018 23:26:08 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     NeilBrown <neil@brown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181021222608.GA24845@localhost>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
> I call on you, Greg:
>  - to abandon this divisive attempt to impose a "Code of Conduct"
>  - to revert 8a104f8b5867c68
>  - to return to your core competence of building a great team around
>    a great kernel
> 
>  #Isupportreversion
> 
> I call on the community to consider what *does* need to be said, about
> conduct, to people outside the community and who have recently joined.
> What is the document that you would have liked to have read as you were
> starting out?  It is all too long ago for me to remember clearly, and so
> much has changed.

The document I would have liked to have read when starting out is
currently checked into the source tree in
Documentation/process/code-of-conduct.rst .

What is your actual concern? Why does it matter so much to you to push
back against this code of conduct? What does it say that you so
fundamentally object to?

(I personally *do* want to see most of the patch series that started
this particular thread dropped, because half of it undermines the point
of the document. The original commit, however, is a matter of
celebration.)
