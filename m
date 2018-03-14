Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeCNAKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:10:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:42015 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbeCNAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:10:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="211031619"
Date: Wed, 14 Mar 2018 08:09:32 +0800
From: kbuild test robot <lkp@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: kbuild-all@01.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH RESEND v2 1/2] drm/xen-front: Add support for Xen PV
 display frontend
Message-ID: <201803140807.NZ4rSrgW%fengguang.wu@intel.com>
References: <1520958066-22875-2-git-send-email-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520958066-22875-2-git-send-email-andr2000@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Andrushchenko/drm-xen-front-Add-support-for-Xen-PV-display-frontend/20180314-014856
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/xen/xen_drm_front.c:420:29: sparse: symbol 'xen_drm_front_platform_info' was not declared. Should it be static?
--
>> drivers/gpu/drm/xen/xen_drm_front_drv.c:125:19: sparse: symbol 'xen_drm_driver' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
