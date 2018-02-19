Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeBSKFs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:05:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:5099 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeBSKFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="31887131"
From: Jani Nikula <jani.nikula@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Tom Saeger <tom.saeger@oracle.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/6] Add support for in-line nested struct comments
In-Reply-To: <20180218170334.711d50e2@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1518788761.git.mchehab@s-opensource.com> <20180218170334.711d50e2@lwn.net>
Date: Mon, 19 Feb 2018 12:05:40 +0200
Message-ID: <87371xb8gb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 16 Feb 2018 11:48:14 -0200
> Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
>
>> his series fix two bugs at kernel-doc.rst examples and add support
>> for in-line nested struct comments.
>> 
>> It also converts one documentation at intel_dpio_phy to use it,
>> in order to give a practical example about how to use it.
>
> OK, I've applied everything but the last patch, which I assume will go
> through the DRM tree.

I was going to reference the kernel-doc commit while applying patch 6,
but I can't find the others. I guess applied literally meant just
applied, not pushed... ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
