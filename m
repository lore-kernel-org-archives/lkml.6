Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeEVIeD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:34:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:50840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEVId7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:33:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="57389652"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 22/33] drm/i915: use match_string() helper
In-Reply-To: <CAHp75Ve0zmHZqESKgB1U9XEhztHPzAWcw9O-8K4JUAamdmYd3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-23-git-send-email-xieyisheng1@huawei.com> <CAHp75Ve0zmHZqESKgB1U9XEhztHPzAWcw9O-8K4JUAamdmYd3A@mail.gmail.com>
Date: Tue, 22 May 2018 11:36:30 +0300
Message-ID: <87lgccw0hd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>
> https://patchwork.kernel.org/patch/10382323/

Even more convincingly,

47d4cb8ae8e7 ("i915: Convert to use match_string() helper")

BR,
Jani.

>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org

-- 
Jani Nikula, Intel Open Source Graphics Center
