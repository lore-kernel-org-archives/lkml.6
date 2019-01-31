Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62421905
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfAaNgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:36:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:31630 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfAaNgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:36:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 05:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="143063070"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2019 05:36:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Jan 2019 15:36:14 +0200
Date:   Thu, 31 Jan 2019 15:36:14 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] device connection: Add support for device graphs
Message-ID: <20190131133614.GB13072@kuha.fi.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <07262cf3-c512-d3dd-f383-3795f035a2d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07262cf3-c512-d3dd-f383-3795f035a2d5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:06:29AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 30-01-19 17:02, Heikki Krogerus wrote:
> > Hi,
> > 
> > This is the second version of this series. On top the two code style
> > improvements requested by Andy, I also renamed the connection
> > identifiers used with the USB Type-C muxes for something that I felt
> > are better, especially after we start using them to name reference
> > device properties in fwnodes. That's why the first patch is now split
> > in two, 1/9 and 3/9.
> > 
> > Hans! Please note that there is no functional change. The alt mode
> > device is still getting a handle to the mux, just like before.
> 
> Ack.
> 
> I've reviewed the entire series and it looks good to me.
> 
> Patches 1-3 are:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I'm slightly less familiar with the material in patches 4-9, so they
> are:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> I will also add this series to my personal git tree for testing.

Cool!

Thanks Hans!

-- 
heikki
