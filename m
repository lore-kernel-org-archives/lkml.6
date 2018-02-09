Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBIJgx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:36:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:28817 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeBIJgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:36:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29439115"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, "Tobin C. Harding" <me@tobin.cc>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH 7/8] docs: kernel-doc: Finish moving STATE_* code out of process_file()
In-Reply-To: <20180208125800.3dae9456@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-8-corbet@lwn.net> <20180208022953.GB3304@eros> <20180208125800.3dae9456@lwn.net>
Date: Fri, 09 Feb 2018 11:36:42 +0200
Message-ID: <871shua4id.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu, 8 Feb 2018 13:29:53 +1100
> "Tobin C. Harding" <me@tobin.cc> wrote:
>
>> It doesn't appear to be introduced by you but the brace positions are
>> non-uniform in this patch.
>> 
>> if
>> {
>>   ...
>> }
>> else
>> {
>>   ...
>> }
>> 
>> instead of
>> 
>> if {
>>   ...
>> } else {
>>   eee
>> }
>
> True, that's worth fixing up while I'm in the neighborhood.  I'll do that
> before I commit the set.

With that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


>
> Thanks,
>
> jon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jani Nikula, Intel Open Source Technology Center
