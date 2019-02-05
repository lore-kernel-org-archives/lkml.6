Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5543BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EA5206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBENXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:23:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:10751 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBENXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:23:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 05:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="272642286"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2019 05:23:40 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gr0hP-0004yF-8w; Tue, 05 Feb 2019 15:23:39 +0200
Date:   Tue, 5 Feb 2019 15:23:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        hdegoede@redhat.com, aspriel@gmail.com, brgl@bgdev.pl,
        heikki.krogerus@linux.intel.com, vivek.gautam@codeaurora.org,
        joe@perches.com, jroedel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device: Fix comment for driver_data in struct device
Message-ID: <20190205132339.GW9224@smile.fi.intel.com>
References: <20190205121952.14873-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205121952.14873-1-david.engraf@sysgo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:19:52PM +0100, David Engraf wrote:
> dev_set_drvdata/dev_get_drvdata is used to access driver_data
> in struct device.

The original comment might be slight confusing, though we all know the concept
of getters and setters.

>  	void		*platform_data;	/* Platform specific data, device
>  					   core doesn't touch it */
>  	void		*driver_data;	/* Driver data, set and get with
> -					   dev_set/get_drvdata */
> +					   dev_set_drvdata/dev_get_drvdata */
>  	struct dev_links_info	links;
>  	struct dev_pm_info	power;
>  	struct dev_pm_domain	*pm_domain;
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


