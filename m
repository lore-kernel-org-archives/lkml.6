Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE622EC0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFE622EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeGEPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:43:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:47669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbeGEPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:43:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 08:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="70326895"
Received: from dmorlich-mobl.amr.corp.intel.com (HELO localhost) ([10.252.36.24])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2018 08:43:01 -0700
Date:   Thu, 5 Jul 2018 18:43:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] ima: Use tpm_default_chip() and call TPM functions with
 a tpm_chip
Message-ID: <20180705154300.GA12193@linux.intel.com>
References: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
 <1530550839.3709.46.camel@linux.vnet.ibm.com>
 <1a5b3d6cddba2d8bc74e5025a628aee7867a8987.camel@linux.intel.com>
 <1530706203.3452.74.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530706203.3452.74.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 08:10:03AM -0400, Mimi Zohar wrote:
> > > Jarkko, would you mind staging this patch with the rest of the patch
> > > set?
> > 
> > Yes, sure, I can do that. Any additional tag?
> 
> Thanks, just these.

I pushed the changes to my tree (also next).

> Mimi

/Jarkko
