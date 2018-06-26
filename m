Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05726C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F6E26B48
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6E26B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbeFZNY3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:24:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:55590 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935385AbeFZNY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:24:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 06:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="235701081"
Received: from skovflem-mobl1.ger.corp.intel.com ([10.249.254.74])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2018 06:24:23 -0700
Message-ID: <cb41279d3c92e3aa00f46bf18bb9bdbf30be2ef6.camel@linux.intel.com>
Subject: Re: [PATCH v5 3/5] tpm: Convert tpm_find_get_ops() to use
 tpm_default_chip()
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 26 Jun 2018 16:24:22 +0300
In-Reply-To: <20180626110619.2362791-4-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
         <20180626110619.2362791-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 07:06 -0400, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
