Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E4FC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0AA20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406404AbfBMSqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:15 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38762 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406389AbfBMSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:11 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 42E82805E1;
        Wed, 13 Feb 2019 19:46:07 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:46:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
Message-ID: <20190213184605.GA11537@ravnborg.org>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
 <20190204185416.GC2834@ravnborg.org>
 <20190206155856.GK3271@phenom.ffwll.local>
 <c5c6169c-8e3d-36ec-67ed-dd2773a5eb9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c6169c-8e3d-36ec-67ed-dd2773a5eb9d@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=F6_ScabtenoHzcDf9_EA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans
> >
> >>Which bring me back to a question asked a week ago or so.
> >>What is missing before we can move vboxvideo out of staging/
> >
> >I think it boils down to someone needs to submit it and we'll take a look.
> 
> Right, I have this on my TODO, but I did not manage to find time for this
> the past few weeks. I expect to have time for this in a couple of weeks
> from now, which means the move will miss the 5.1 merge window.
> 
> Note you (Sam) are certainly welcome to submit a patch doing the move
> yourself, I can certainly use some help with maintaining vboxvideo.

I have not tried to submit patches to move vboxvideo out of staging.
Partially due to lack of time, mostly lack of competence to
follow-up on the review comments I hope we will see.
I am perfectly happy to do trivial stuff, but when someone ask
to replace the use of ttm with shmem+gem (example - I do not
know if this is a relevant comment), then it is above
me for the moment.
And on top of this then I lack a good testing environment.

I could do it but then anything difficult would just be added
to a TODO file, and then I dunno how useful it is.
Something to consider when we are past the merge window anyway.

	Sam
