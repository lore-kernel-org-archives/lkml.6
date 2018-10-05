Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A68C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6BE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6BE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJEOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:30:33 -0400
Received: from verein.lst.de ([213.95.11.211]:59407 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbeJEOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:30:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9176967358; Fri,  5 Oct 2018 09:33:05 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:33:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1] ras: Use consistent types for UUIDs
Message-ID: <20181005073305.GB24224@lst.de>
References: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:10:27PM +0300, Andy Shevchenko wrote:
> The commit
> 
>   297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")
> 
> brought inconsistency in UUID types which are used across the RAS subsystem.
> 
> Fix this by moving to use guid_t everywhere.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
