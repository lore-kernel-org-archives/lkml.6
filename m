Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C0EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991EA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="qDPBJXad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfAGP5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:57:25 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38299 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfAGP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=graAAe1smfTXE/AF0BJLQaz6saf38XMwxom186Ymz2I=;
        b=qDPBJXad0KmNkn43rRbjGC9Ptu1NrjpAI+dEB5v6sBUs28MA1nOOy5WnetXVqqaP1fgD3GNrqZlQgr7J/fyK77HoRFliYxngOOZecsPApYHpHXwQQIZrjm2+Zrmc7aCWUgDB8knyV85VHzixZwmyqmI9EBk8Vjxkk/sIZBDgJsuZH5TSYiYP/XOBmUqIjt9GrRBYxRbx7aSpgghu3M3HEDUDPu9HmbSq3WazIQyXhEx95SNxyDy/c/uosdRv6Yl3XtO1C7DnfkSqoGL2/J0W/8CieJR5OuAdaStoe2br/CeAb+Xn3LdHnwPV0W6+uEeBmEvCsfZu7WSxXSo4Rg2img==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64471 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXHG-0000XA-NL; Mon, 07 Jan 2019 16:57:22 +0100
Subject: Re: [PATCH v2 09/14] drm: remove include of drmP.h from
 drm_encoder_slave.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181230174838.32330-10-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <4c0f0b3c-cc6b-d4f5-5ab1-812ce507cb9b@tronnes.org>
Date:   Mon, 7 Jan 2019 16:57:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-10-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> No further changes required.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
