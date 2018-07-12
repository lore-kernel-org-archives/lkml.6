Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF194C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AC720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AC720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGLJ2e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:28:34 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54460 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbeGLJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:28:34 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12329133-1500050 
        for multiple; Thu, 12 Jul 2018 10:19:36 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1531351486-5932-1-git-send-email-asmadeus@codewreck.org>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
 <1531351486-5932-1-git-send-email-asmadeus@codewreck.org>
Message-ID: <153138718209.10340.14031656576072613123@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] i915/intel_tv_get_modes: fix strncpy truncation warning
Date:   Thu, 12 Jul 2018 10:19:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dominique Martinet (2018-07-12 00:24:46)
> Change it to use strlcpy instead
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks for the spotting the issue and providing a fix, pushed.
-Chris
