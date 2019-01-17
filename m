Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEEC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2D520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfAQPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:45:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:30748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfAQPpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:45:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 07:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="117471042"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2019 07:45:49 -0800
Date:   Thu, 17 Jan 2019 08:44:37 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 00/13] Heterogeneuos memory node attributes
Message-ID: <20190117154436.GB31543@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190117125821.GF26056@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117125821.GF26056@350D>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:58:21PM +1100, Balbir Singh wrote:
> On Wed, Jan 16, 2019 at 10:57:51AM -0700, Keith Busch wrote:
> > It had previously been difficult to describe these setups as memory
> > rangers were generally lumped into the NUMA node of the CPUs. New
> > platform attributes have been created and in use today that describe
> > the more complex memory hierarchies that can be created.
> > 
> 
> Could you please expand on this text -- how are these attributes
> exposed/consumed by both the kernel and user space?
> 
> > This series' objective is to provide the attributes from such systems
> > that are useful for applications to know about, and readily usable with
> > existing tools and libraries.
> 
> I presume these tools and libraries are numactl and mbind()?

Yes, and numactl is used the examples provided in both changelogs and
documentation in this series. Do you want to see those in the cover
letter as well?
