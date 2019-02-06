Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A2F217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfBFHtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:49:11 -0500
Received: from mail.sysgo.com ([176.9.12.79]:50140 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBFHtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:49:10 -0500
Subject: Re: [PATCH] device: Fix comment for driver_data in struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        hdegoede@redhat.com, aspriel@gmail.com, brgl@bgdev.pl,
        heikki.krogerus@linux.intel.com, vivek.gautam@codeaurora.org,
        joe@perches.com, jroedel@suse.de, linux-kernel@vger.kernel.org
References: <20190205121952.14873-1-david.engraf@sysgo.com>
 <20190205132339.GW9224@smile.fi.intel.com>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <75fac672-f1f2-5b15-d871-308469943eb9@sysgo.com>
Date:   Wed, 6 Feb 2019 08:49:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190205132339.GW9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.19 at 14:23, Andy Shevchenko wrote:
> On Tue, Feb 05, 2019 at 01:19:52PM +0100, David Engraf wrote:
>> dev_set_drvdata/dev_get_drvdata is used to access driver_data
>> in struct device.
> 
> The original comment might be slight confusing, though we all know the concept
> of getters and setters.

Okay you're right. I was a bit confused about the syntax.

Thanks
- David


>>   	void		*platform_data;	/* Platform specific data, device
>>   					   core doesn't touch it */
>>   	void		*driver_data;	/* Driver data, set and get with
>> -					   dev_set/get_drvdata */
>> +					   dev_set_drvdata/dev_get_drvdata */
>>   	struct dev_links_info	links;
>>   	struct dev_pm_info	power;
>>   	struct dev_pm_domain	*pm_domain;
>> -- 
>> 2.17.1
>>
> 

