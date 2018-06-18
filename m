Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BAAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeFRIFE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:05:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:55043 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932485AbeFRIFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:05:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 01:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="65003170"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2018 01:04:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aaron Brown <aaron.f.brown@intel.com>
Subject: Re: [PATCH] net: fix e100.rst Documentation build errors
In-Reply-To: <72f13386-c484-3eed-c363-a5b667aea2e6@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <72f13386-c484-3eed-c363-a5b667aea2e6@infradead.org>
Date:   Mon, 18 Jun 2018 11:04:51 +0300
Message-ID: <87efh4y0yk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation build errors in e100.rst.  Several section titles
> and the corresponding underlines should not be indented.

Really the content blocks below the titles should not be indented
either. It's not an error, but the end result is probably not what you
want.

BR,
Jani.


>
> Documentation/networking/e100.rst:90: (SEVERE/4) Unexpected section title.
> Documentation/networking/e100.rst:109: (SEVERE/4) Unexpected section title.
>
> Fixes: 85d63445f411 ("Documentation: e100: Update the Intel 10/100 driver doc")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Aaron Brown <aaron.f.brown@intel.com>
> ---
> Is there a Sphinx version problem here?  Tested-by: should indicate
> that there was no error like I am seeing.
>
>  Documentation/networking/e100.rst |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> --- lnx-418-rc1.orig/Documentation/networking/e100.rst
> +++ lnx-418-rc1/Documentation/networking/e100.rst
> @@ -86,8 +86,8 @@ Event Log Message Level:  The driver use
>  Additional Configurations
>  =========================
>  
> -  Configuring the Driver on Different Distributions
> -  -------------------------------------------------
> +Configuring the Driver on Different Distributions
> +-------------------------------------------------
>  
>    Configuring a network driver to load properly when the system is started is
>    distribution dependent. Typically, the configuration process involves adding
> @@ -105,8 +105,8 @@ Additional Configurations
>         alias eth0 e100
>         alias eth1 e100
>  
> -  Viewing Link Messages
> -  ---------------------
> +Viewing Link Messages
> +---------------------
>    In order to see link messages and other Intel driver information on your
>    console, you must set the dmesg level up to six. This can be done by
>    entering the following on the command line before loading the e100 driver::
> @@ -119,8 +119,8 @@ Additional Configurations
>    NOTE: This setting is not saved across reboots.
>  
>  
> -  ethtool
> -  -------
> +ethtool
> +-------
>  
>    The driver utilizes the ethtool interface for driver configuration and
>    diagnostics, as well as displaying statistical information.  The ethtool
> @@ -129,8 +129,8 @@ Additional Configurations
>    The latest release of ethtool can be found from
>    https://www.kernel.org/pub/software/network/ethtool/
>  
> -  Enabling Wake on LAN* (WoL)
> -  ---------------------------
> +Enabling Wake on LAN* (WoL)
> +---------------------------
>    WoL is provided through the ethtool* utility.  For instructions on enabling
>    WoL with ethtool, refer to the ethtool man page.
>  
> @@ -138,16 +138,16 @@ Additional Configurations
>    this driver version, in order to enable WoL, the e100 driver must be
>    loaded when shutting down or rebooting the system.
>  
> -  NAPI
> -  ----
> +NAPI
> +----
>  
>    NAPI (Rx polling mode) is supported in the e100 driver.
>  
>    See https://wiki.linuxfoundation.org/networking/napi for more information
>    on NAPI.
>  
> -  Multiple Interfaces on Same Ethernet Broadcast Network
> -  ------------------------------------------------------
> +Multiple Interfaces on Same Ethernet Broadcast Network
> +------------------------------------------------------
>  
>    Due to the default ARP behavior on Linux, it is not possible to have
>    one system on two IP networks in the same Ethernet broadcast domain
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jani Nikula, Intel Open Source Graphics Center
