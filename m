Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeEKDjz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:39:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:38038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbeEKDjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:39:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="49961736"
Date: Fri, 11 May 2018 11:39:50 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, LKP <lkp@01.org>, LKP <lkp@intel.com>,
        Julie Du <julie.du@intel.com>, Philip Li <philip.li@intel.com>
Subject: Re: cross-compiling a 64-bit kernel on a 32-bit host
Message-ID: <20180511033950.ahkey2jnsd5i2gvi@wfg-t540p.sh.intel.com>
References: <20180510223619.jwdlle42brksfp4v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180510223619.jwdlle42brksfp4v@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

CC LKP team.

On Thu, May 10, 2018 at 05:36:19PM -0500, Josh Poimboeuf wrote:
>Hi Fengguang,
>
>I occasionally get compilation bug reports from people who are
>cross-compiling an x86-64 kernel target on an x86-32 host.
>
>Any chance the 0-day build bot could test that configuration?  I think
>just building a defconfig would be sufficient.  It would help sort out
>issues in objtool and other host-built scripts.

To do that we'll need to create a new build chroot. Julie/Philip
should be able to evaluate the efforts and do the plan.

Thanks,
Fengguang
