Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeAaHSQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:18:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:14550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeAaHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:18:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,438,1511856000";
   d="scan'208";a="26861716"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: kernel maintainer PGP guide
In-Reply-To: <20180130184917.GA32095@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180130184917.GA32095@gmail.com>
Date: Wed, 31 Jan 2018 09:18:11 +0200
Message-ID: <87bmhajy30.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> This guide is an adapted version of the more general "Protecting Code
> Integrity" guide written and maintained by The Linux Foundation IT for
> use with open-source projects. It provides the oft-lacking guidance on
> the following topics:
>
> - how to properly protect one's PGP keys to minimize the risks of them
>   being stolen and used maliciously to impersonate a kernel developer
> - how to configure Git to properly use GnuPG
> - when and how to use PGP with Git
> - how to verify fellow Linux Kernel developer identities
>
> I believe this document should live with the rest of the documentation
> describing proper processes one should follow when participating in
> kernel development. Placing it in a wiki on some place like kernel.org
> would be insufficient for a number of reasons -- primarily, because only
> a relatively small subset of maintainers have accounts on kernel.org,
> but also because even those who do rarely remember that such wiki
> exists. Keeping it with the rest of in-kernel docs should hopefully give
> it more visibility, but also help keep it up-to-date as tools and
> processes evolve.

FWIW, agreed on having this with the kernel documentation.

I can't say I reviewed it, but glancing through I didn't spot any errors
either. Lots of good stuff.

Just one nit, I think it would be better to move the Maintainer: bit
from the end near the top as a reStructuredText field list. See 'git
grep :Author:' under Documentation for examples. Could even add a
MAINTAINERS entry to improve your chances of being Cc'd on changes.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
