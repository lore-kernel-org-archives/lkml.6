Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbeDCKDh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:03:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:61160 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbeDCKDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:03:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,400,1517904000";
   d="scan'208";a="43593035"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" -> "Unsupported"
In-Reply-To: <alpine.DEB.2.20.1804031139110.3630@hadrien>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180330160047.7368-1-colin.king@canonical.com> <87tvssaawl.fsf@intel.com> <alpine.DEB.2.20.1804031139110.3630@hadrien>
Date: Tue, 03 Apr 2018 13:04:22 +0300
Message-ID: <87o9j0a9nd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Tue, 3 Apr 2018, Jani Nikula wrote:
>> Please do consider limiting the distribution in the future,
>> though. There's no need to include lkml or even dri-devel for trivial
>> patches like this.
>
> It's complex to have to remember the preferences for every subsystem.
> Preferences should be expressed in the MAINTAINERS file in some way.

They are; it's just that get_maintainer.pl has silly defaults. There's
no reason it should include the full chain from the leaf driver to the
subsystem to the LKML by default, with a bunch of authors and commit
signers on top. Especially so for supported drivers. I'm surprised it
doesn't include Linus by default.

> Also, since no one reads lkml, does it hurt to have even trivial patches?

Heh. Let's just say I care more about dri-devel.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
