Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687E62081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687E62081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLJIaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:30:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:59831 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:30:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 00:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="100287309"
Received: from jlahtine-mobl.fi.intel.com ([10.237.66.147])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2018 00:30:09 -0800
Message-ID: <76ccd79ddff183113a4cc972e6a8cc1c8bb29a05.camel@linux.intel.com>
Subject: Re: v4.20-rc5+ on x220: Resetting chip for hang on rcs0
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
Date:   Mon, 10 Dec 2018 10:30:08 +0200
In-Reply-To: <20181209111856.GA20366@amd>
References: <20181108175803.GA10785@amd>
         <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
         <20181121115449.GA32455@amd>
         <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
         <20181124152352.GA9548@amd> <20181208111346.GA5535@amd>
         <20181208112447.GA9663@amd> <20181209111856.GA20366@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-09 at 12:18 +0100, Pavel Machek wrote:
> Hi!
> 
> Another day, another problem... but this one is different from the
> previous hang, as machine survives.

Please, file a bug. It says so even in the splat...

Regards, Joonas

> 
> Chromium was running with youtube video playing.
> 
> [31850.666274] [drm] GPU hangs can indicate a bug anywhere in the
> entire gfx stack, including userspace.
> [31850.666277] [drm] Please file a _new_ bug report on
> bugs.freedesktop.org against DRI -> DRM/Intel
> [31850.666279] [drm] drm/i915 developers can then reassign to the
> right component if it's not a kernel issue.
> [31850.666282] [drm] The gpu crash dump is required to analyze gpu
> hangs, so please always attach it.
> [31850.666285] [drm] GPU crash dump saved to
> /sys/class/drm/card0/error
> [31850.666394] i915 0000:00:02.0: Resetting chip for hang on rcs0
> [31850.668474] WARNING: CPU: 0 PID: 13675 at
> /data/fast/l/k/include/linux/dma-fence.h:503
> i915_request_skip+0x71/0x80
> [31850.668478] Modules linked in:
> [31850.668484] CPU: 0 PID: 13675 Comm: kworker/0:3 Not tainted
> 4.20.0-rc5+ #5
> [31850.668487] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET74WW
> (1.44 ) 03/13/2018
> 
> Dmesg and /sys/class/drm/card0/error are attached.
> 
> Best regards,
> 									Pavel
-- 
Joonas Lahtinen
Open Source Graphics Center
Intel Corporation

