Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C4821872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="VMoex33B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAXHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:23:37 -0500
Received: from chill.innovation.ch ([216.218.245.220]:40614 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:23:36 -0500
Date:   Wed, 23 Jan 2019 23:23:36 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 38169640151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1548314616;
        bh=FDm89pfp/uRfHWX9lhpEf34dJ3xM5CmhUdlS1x06bG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMoex33BKMDEyj7UNKhwFHYHLTMmFWvjodvmaBKlwjWz9Jsrg1V8m55oh+CsyfaOJ
         Eqk2SkN4C7AdujPL30aZqXRRtEa/5IMAfBuzS0Fq3OzPoOJ/+IVy8lqlSLMw98jVEf
         zQmj8lGyDCpnVsv+ymfRIbu0y82fM2Wnxi1vhfpqp/CA/8dHeb39ZiWn4JgezoCFGj
         gojoZlJptviIBlxOGWT9UpncoES1nlzAqblNKTPYHmYRZjU52nCVeqDw1uLVM/xJh1
         V8aqAN+yU+lfo5FCiT6Azg096TacEVPwjEs8c+gzdnP8KTIn+Fn6KcVEl/FTesHkeS
         oY5R5nVqzjODw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190124072336.GB28127@innovation.ch>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190122211028.GK3264@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122211028.GK3264@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Laurent,

On Tue, Jan 22, 2019 at 11:10:28PM +0200, Laurent Pinchart wrote:
> 
> Thank you for the patch.
> 
> On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> > commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> 
> Commits are usually quoted using the short 12 digits version of their
> SHA-1.

Oh, right, sorry - will fix in next version of patch.

[snip]


  Cheers,

  Ronald

