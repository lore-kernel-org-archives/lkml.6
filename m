Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F318C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75A321782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75A321782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeHCVJy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:09:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52918 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728246AbeHCVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:09:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12589357-1500050 
        for multiple; Fri, 03 Aug 2018 20:12:03 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180803164150.8185-1-gwan-gyeong.mun@intel.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20180803164150.8185-1-gwan-gyeong.mun@intel.com>
Message-ID: <153332352090.15394.16477722089065680950@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix typo in i915_drm_resume()
Date:   Fri, 03 Aug 2018 20:12:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwan-gyeong Mun (2018-08-03 17:41:50)

Even for trivial patches, always include a changelog. In this case, I
added "Trivial typo, s/loose/lose/, in i915_drm_resume."

> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

And pushed, thanks for the spelling correction.
-Chris
