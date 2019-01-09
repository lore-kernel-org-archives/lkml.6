Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB45B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfAIJm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:42:56 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:49197 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfAIJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:42:53 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9C2FD20025;
        Wed,  9 Jan 2019 10:42:46 +0100 (CET)
Date:   Wed, 9 Jan 2019 10:42:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: Re: [PATCH v3 10/12] drm/stm: do not reply on drmP.h from
 drm_gem_cma_helper.h
Message-ID: <20190109094245.GA32251@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-11-sam@ravnborg.org>
 <CA+M3ks5odiPjG1mTFB-MUGDh8ku11rY2zpkxcQMZBzphakH1Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5odiPjG1mTFB-MUGDh8ku11rY2zpkxcQMZBzphakH1Cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=0-aFeuAdrtJRIH6pGY0A:9
        a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin.

On Wed, Jan 09, 2019 at 09:21:39AM +0100, Benjamin Gaignard wrote:
> Le mar. 8 janv. 2019 à 20:30, Sam Ravnborg <sam@ravnborg.org> a écrit :
> I just notice the a typo in the title of the commit message reply ->rely ?
Randy already told me this, but I missed that in the update.

Will fix in v4 if this set do not get applied.

	Sam
