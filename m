Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5525C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E32B26B2F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E32B26B2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935699AbeFZNVu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:21:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:14919 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934199AbeFZNVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:21:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 06:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="235700121"
Received: from skovflem-mobl1.ger.corp.intel.com ([10.249.254.74])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2018 06:21:41 -0700
Message-ID: <0084b7ca7e5b9a48f4f8354805eed8b3c44f90c3.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/5] tpm: rename tpm_chip_find_get() to
 tpm_find_get_ops()
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 26 Jun 2018 16:21:40 +0300
In-Reply-To: <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-2-stefanb@linux.vnet.ibm.com>
         <55a1a67f9c53ad8cac6e560bb23b1b712fdd4caa.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 16:18 +0300, Jarkko Sakkinen wrote:
> On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> > Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
> > the tpm_put_ops() counter part.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> Awesome, makes sense by itself alone. Thanks Stefan. If we need
> follow up versions, no need to include this patch. I would take
> it even if the whole patch set was discarded for whatever reason.
> 
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already pushed to my master. Kind of waiting James to rebase his
tree before moving stuff to next.

/Jarkko
