Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1997C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D88F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfAXVxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:53:03 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:60058 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:53:02 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 33F1B20049;
        Thu, 24 Jan 2019 22:52:58 +0100 (CET)
Date:   Thu, 24 Jan 2019 22:52:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sean Paul <sean@poorly.run>
Cc:     Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vincent Abriou <vincent.abriou@st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: Re: [PATCH v5 6/6] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190124215256.GA32543@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
 <20190119084014.5355-7-sam@ravnborg.org>
 <20190124140320.GY3271@phenom.ffwll.local>
 <20190124200747.GQ114153@art_vandelay>
 <20190124201749.GA9246@ravnborg.org>
 <20190124202840.GR114153@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124202840.GR114153@art_vandelay>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=0JncZOcB4e0098qJHeAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean/Hans.

> > Hans de Goede sent out patches in September to convert it to a proper
> > atomic driver.
> > I recall that the feedback was mostly positive and that there was only
> > minor things to left to do. Hans?

I browsed the archieves and I could not find anything that was not addressed,
so nothing is apperantly missing expect the actual move from staging to gpu/drm/
And that move out of staging may require a proper review at dri-devel?

Browsing the code left me with an impression of a nice code base.

	Sam
