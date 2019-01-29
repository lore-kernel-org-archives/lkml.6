Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B1FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49102214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfA2PTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:19:22 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54271 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2PTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:19:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6F9758041D;
        Tue, 29 Jan 2019 16:19:18 +0100 (CET)
Date:   Tue, 29 Jan 2019 16:19:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
Message-ID: <20190129151916.GA12635@ravnborg.org>
References: <20190125192233.10019-1-jagan@amarulasolutions.com>
 <20190125192233.10019-2-jagan@amarulasolutions.com>
 <20190125195205.GA31938@ravnborg.org>
 <CAMty3ZAB9vceDu0g-mRhBr2poZHZdNq3D1_-Fp7uYxhGg3GrCg@mail.gmail.com>
 <CAMty3ZCejdo+ztipg0F0SSpSRZwxKxTbhbXA93YqM2GFozxFqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZCejdo+ztipg0F0SSpSRZwxKxTbhbXA93YqM2GFozxFqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=boDjjD2J0CBCENRL4_IA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

> >
> > I see DRM_MODE_ARG as mode argument, that print all mode timings but
> > here we need only 3 timings out of it. do we really need? if yes
> > please suggest an example.
> 
> fyi: sent v6 for this except this change. Let me know if you have any
> comments on this.

Drivers looks fine, the above was just a quick suggestion to use some
exising plumbing.

You have done a nice job following up on all the feedback.

	Sam
