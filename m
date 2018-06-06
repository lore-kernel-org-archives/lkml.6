Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id g2mtDilEGFtwYgAAmS7hNA
	; Wed, 06 Jun 2018 20:29:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2216F607F7; Wed,  6 Jun 2018 20:29:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A95FC601D2;
	Wed,  6 Jun 2018 20:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A95FC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeFFU30 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:29:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:24934 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752465AbeFFU3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:29:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 13:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="54524396"
Received: from sthiyag1-mobl3.amr.corp.intel.com (HELO [10.255.38.168]) ([10.255.38.168])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2018 13:29:24 -0700
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
 <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
 <20180601170847.GC8677@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6fc091cf-bf63-9dae-40cd-8603c980cf95@linux.intel.com>
Date: Wed, 6 Jun 2018 15:29:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601170847.GC8677@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2018 12:08 PM, Mark Brown wrote:
> On Fri, Jun 01, 2018 at 10:19:58AM -0500, Pierre-Louis Bossart wrote:
>
>> I wanted to ack this patch but the Intel validation folks asked for a couple
>> of days to finish their tests on a variety of Chromebooks (e.g. Lars) and
>> double-check which models used the v4 topology. There is an internal thread
>> on all this which remains active. I don't think the feedback will be delayed
>> beyond early next week.
> OK, I'm expecting the merge window to open over the weekend so I think
> I'm just going to apply now so we it's in -next when that happens.
quick follow-up note: Intel folks successfully tested this patchset on 
chell, sentry, lars, glados, asuka platforms. There is an unrelated 
issue on chell with playback not working, but at least the topology 
parsing is handled correctly with Guenter's contribution.
