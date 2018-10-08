Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EABC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E393E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E393E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJICYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:24:53 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38596 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJICYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:24:53 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A7B343A9E50
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 21:04:46 +0200 (CEST)
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B713F240006;
        Mon,  8 Oct 2018 19:04:43 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:04:36 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Chris Mason <clm@fb.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181008190435.GA3963@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
 <FA87081B-1344-4CC8-8BCC-F00A985719FF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA87081B-1344-4CC8-8BCC-F00A985719FF@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:15:25PM -0400, Chris Mason wrote:
> On 6 Oct 2018, at 17:37, James Bottomley wrote:
> > Significant concern has been expressed about the responsibilities
> > outlined in
> > the enforcement clause of the new code of conduct.  Since there is
> > concern
> > that this becomes binding on the release of the 4.19 kernel, strip the
> > enforcement clauses to give the community time to consider and debate
> > how this
> > should be handled.
> 
> Even in the places where I don't agree with the discussion about what our
> code of conduct should be, I love that we're having it.  Removing the
> enforcement clause basically goes back to the way things were.  We'd be
> recognizing that we know issues happen, and explicitly stating that when
> serious events do happen, the community as a whole isn't committing to
> helping.
> 
> It's true there are a lot of questions about how the community resolves
> problems and holds each other accountable for maintaining any code of
> conduct.  I think the enforcement section leaves us the room we need to
> continue discussions and still make it clear that we're making an effort to
> shift away from the harsh discussions in the past.

Emphatically seconded.

I absolutely agree that we should to work on the enforcement section
over time; for instance, I agree that a dedicated team (ideally with
some training) would be better than vesting this in a technical
decision-making body.

But I agree with Chris that we should not remove this entirely. And I
don't think there's any special significance to this being in the 4.19
release as compared to an -rc or git HEAD.
