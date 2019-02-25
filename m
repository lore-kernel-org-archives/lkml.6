Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5E2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfBYJlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:41:22 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:56963 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfBYJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:41:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B982E8040F;
        Mon, 25 Feb 2019 10:41:17 +0100 (CET)
Date:   Mon, 25 Feb 2019 10:41:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        thierry.reding@gmail.com
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Message-ID: <20190225094116.GA19587@ravnborg.org>
References: <20190222175153.20567-1-pawel.mikolaj.chmiel@gmail.com>
 <20190222175153.20567-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222175153.20567-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=hD80L64hAAAA:8
        a=R42PPxg-1mjhGoWC4SoA:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł, Thierry

On Fri, Feb 22, 2019 at 06:51:53PM +0100, Paweł Chmiel wrote:
> This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
> spi. It's based on already removed, non dt s6e63m0 driver and
> panel-samsung-ld9040. It can be found for example in some of Samsung
> Aries based phones.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

I took a last look at the driver.
Everything looks good to me now, and I consider this driver ready to be applied.

	Sam
