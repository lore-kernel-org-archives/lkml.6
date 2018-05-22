Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEVIgy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:36:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:6386 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVIgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:36:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="57390206"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc: David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 24/33] drm: use match_string() helper
In-Reply-To: <CAHp75Vc-Qe-Ft0etW49CtaOFfUHV3hij5E__HiX8a1zM4u6PHQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-25-git-send-email-xieyisheng1@huawei.com> <CAHp75Vc-Qe-Ft0etW49CtaOFfUHV3hij5E__HiX8a1zM4u6PHQ@mail.gmail.com>
Date: Tue, 22 May 2018 11:39:25 +0300
Message-ID: <87in7gw0ci.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>
> https://patchwork.kernel.org/patch/10382377/

818c05d8e267 ("drm: panel-orientation-quirks: Convert to use match_string() helper")

BR,
Jani.

>
>> Cc: Gustavo Padovan <gustavo@padovan.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: dri-devel@lists.freedesktop.org

-- 
Jani Nikula, Intel Open Source Graphics Center
