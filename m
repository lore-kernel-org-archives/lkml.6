Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A481AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A02205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBVSJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:09:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:27852 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfBVSJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:09:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2019 10:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,400,1544515200"; 
   d="scan'208";a="135579394"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2019 10:09:41 -0800
Date:   Fri, 22 Feb 2019 11:09:45 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv6 06/10] node: Add memory-side caching attributes
Message-ID: <20190222180944.GD10237@localhost.localdomain>
References: <20190214171017.9362-1-keith.busch@intel.com>
 <20190214171017.9362-7-keith.busch@intel.com>
 <29336223-b86e-3aca-ee5a-276d1c404b96@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29336223-b86e-3aca-ee5a-276d1c404b96@inria.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:12:38AM +0100, Brice Goglin wrote:
> Le 14/02/2019 à 18:10, Keith Busch a écrit :
> > +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/size
> > +Date:		December 2018
> > +Contact:	Keith Busch <keith.busch@intel.com>
> > +Description:
> > +		The size of this memory side cache in bytes.
> 
> 
> Hello Keith,
> 
> CPU-side cache size is reported in kilobytes:
> 
> $ cat
> /sys/devices/system/cpu/cpu0/cache/index*/size                                             
> 
> 32K
> 32K
> 256K
> 4096K
> 
> Can you do the same of memory-side caches instead of reporting bytes?

Ok, will do.
