Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030815AbeBNO3U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:29:20 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:41312 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030429AbeBNO3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:29:19 -0500
Date: Wed, 14 Feb 2018 16:29:15 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.16-rc1: UBSAN warning in nouveau/nvkm/subdev/therm/base.c +
 oops in nvkm_therm_clkgate_fini
In-Reply-To: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1802141628110.25362@math.ut.ee>
References: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is 4.16-rc1+todays git on a lowly P4 with NV5, worked fine in 4.15:

NV5 in another PC (secondary card in x86-64) made the systrem crash on 
boot, in nvkm_therm_clkgate_fini.

-- 
Meelis Roos (mroos@linux.ee)
