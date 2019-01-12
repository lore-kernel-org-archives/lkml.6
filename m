Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8414C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F3020836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfALQxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:53:35 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:47362 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:53:35 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 70DF220031;
        Sat, 12 Jan 2019 17:53:33 +0100 (CET)
Date:   Sat, 12 Jan 2019 17:53:31 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190112165331.GA30019@ravnborg.org>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
 <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
 <20190112101409.GA14273@ravnborg.org>
 <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
 <20190112120056.GA7374@ravnborg.org>
 <CAMty3ZAvEzatWMPbtPKUhVRMSzC9icarsxK7KfXAp+gvCR74Lw@mail.gmail.com>
 <20190112153348.GA12461@ravnborg.org>
 <CAMty3ZDTwAx6aY=KJCWjwRo-JxBKENTfPtjV_LkY=QaSxAjRWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDTwAx6aY=KJCWjwRo-JxBKENTfPtjV_LkY=QaSxAjRWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7IxT3UG5KUivFUahzXIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

> When did .unprepare and .disable are actually called? I turn-off the
> backlight by echo 1 > /sys/class/backlight/backlight/bl_power and even
> power of the board I assume the video transmission stop so it would
> ended-up calling these, but I couldn't see prints. does it the same
> time uart dead or something? do you have any inputs on sanity testing
> of typical panels, if yes please share.

Sorry, I do not rememebr the details to help you here.
Maybe module unload and then manipulating the panel in /sys/ would
do the trick.

	Sam
