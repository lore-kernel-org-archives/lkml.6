Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CBB21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfBKSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:25:21 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:44962 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfBKSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:25:21 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1DAC6200F9;
        Mon, 11 Feb 2019 19:25:13 +0100 (CET)
Date:   Mon, 11 Feb 2019 19:25:12 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "DRM maintainer tools announcements, discussion, and development" 
        <dim-tools@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PULL] topic/component-typed
Message-ID: <20190211182512.GA28363@ravnborg.org>
References: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=CYLJJw9b-V7gLK0kE2YA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Mon, Feb 11, 2019 at 06:15:20PM +0100, Daniel Vetter wrote:
> Hi all,
> 
> Here's the typed component topic branch.
> 
> drm-intel maintainers: Please pull, I need this for the mei hdcp work from Ram.
> 
> drm-misc maintainers: Please pull, there's a drm doc patch follow-up
> that I want to stuff into drm-misc-next.
> 
> Greg: The drm side missed our feature cutoff, so will only land in 5.2.

With all the dependencies why not bend the rule a little and get this in now?
It is not like this is a huge patchset.

	Sam
