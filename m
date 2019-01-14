Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E000C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184AD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfANPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:55:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:2253 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfANPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:55:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 07:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="116654455"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2019 07:55:13 -0800
Date:   Mon, 14 Jan 2019 08:53:54 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 13/13] doc/mm: New documentation for memory performance
Message-ID: <20190114155354.GC22829@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-14-keith.busch@intel.com>
 <20190113114230.GB8765@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113114230.GB8765@rapoport-lnx>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 01:42:30PM +0200, Mike Rapoport wrote:
> There are a couple of nitpicks below, otherwise
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thank you for the detailed review. I've incorporated all your
recommmendations for the next revision.
