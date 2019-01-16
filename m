Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE4A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfAPVqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:46:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:29949 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfAPVq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:46:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 13:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="115222565"
Received: from lhaqq1-mobl2.amr.corp.intel.com (HELO localhost) ([10.249.254.231])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2019 13:46:26 -0800
Date:   Wed, 16 Jan 2019 23:46:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tpm: ppi: rename TPM_PPI_REVISION_ID to
 TPM_PPI_REVISION_1
Message-ID: <20190116214624.GC25803@linux.intel.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <20190109221103.1897677-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109221103.1897677-3-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:11:00PM -0500, Stefan Berger wrote:
> TPM PPI 1.3 introduces a function revision 2 for some functions. So,
> rename the existing TPM_PPI_REVISION_ID to TPM_PPI_REVISION_1.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

The change looks good, but why TPM_PPI_REVISION_1 and not
TPM_PPI_REVISION_ID_1?

/Jarkko
