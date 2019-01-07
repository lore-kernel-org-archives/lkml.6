Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34137C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053E72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="V1jYzcSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAGQCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:02:31 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:58751 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfAGQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=GEyuI6bEE+0hT7l/qFwwY6y1AopaVkDt50sBnU1pGnc=;
        b=V1jYzcSo83Z8bL3xvKv0+JdFwCWOI1PDsiNcjOdsTL3yl3BZj0N6HV/4MkfA457IUzW+JFrSNsL7RLOYumsBkhh6G/B4ExFApPp/kpTz4Y3lf8VcetWbUt4EeXIlVmuFdxbaHJZB6062cNaOWfJ7efC1puCAlYPa5I04NFHqpm9F55f3bNvLmaNGMDQ69Xu+KR1ciAiWBA6TkwwjH7oeQf61jZnVLDpm4IwuKw00JVO4CTu/QqYfg9vdlpPi52zvmimGo5nMr0ji6CFcE7uaC3fXf1iaMEEX9UcQw+0C32/zE09Ht7h2wfEMXRtbMG+Fnq5yo2DP9RKFphfsNof9MQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64504 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXMC-0002DI-SA; Mon, 07 Jan 2019 17:02:28 +0100
Subject: Re: [PATCH v2 14/14] drm: remove drmP.h from drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181230174838.32330-15-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0ace53d6-0199-78ad-19c0-bcb3583688e5@tronnes.org>
Date:   Mon, 7 Jan 2019 17:02:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-15-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> With all dependencies fixed we can now remove
> drmP.h from drm_gem_cma_helper.h.
> It is replaced by the include files required,
> or forward declarations as appropritate.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
