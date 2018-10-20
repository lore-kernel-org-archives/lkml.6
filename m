Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52411ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49221476
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F49221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJTJGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:06:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:9226 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:06:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 17:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,402,1534834800"; 
   d="scan'208";a="101018205"
Received: from kskibin-mobl.ger.corp.intel.com ([10.249.254.29])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2018 17:58:05 -0700
Date:   Sat, 20 Oct 2018 03:58:03 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Tomas Winkler <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/21] tpm: factor out tpm1_get_random into
 tpm1-cmd.c
In-Reply-To: <20181019182307.17745-10-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810200357060.9963@jsakkine-mobl1>
References: <20181019182307.17745-1-tomas.winkler@intel.com> <20181019182307.17745-10-tomas.winkler@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018, Tomas Winkler wrote:
> Factor out get random implementation from tpm-interface.c
> into tpm1_get_random function in tpm1-cmd.c.
> No functional changes.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

*If* there is need for a new version can you change that to:

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Otherwise, I can fix it.

/Jarkko
