Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4789ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1EF2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1EF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJWViG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:38:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:26307 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWViG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:38:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 06:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="243640812"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.111])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 06:14:37 -0700
Date:   Tue, 23 Oct 2018 16:14:36 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/21] tpm: separate tpm 1.x and tpm 2.x commands
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9FA974@hasmsx109.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1810231612030.19836@jsakkine-mobl1>
References: <20181019182307.17745-1-tomas.winkler@intel.com> <alpine.DEB.2.21.1810200419110.9963@jsakkine-mobl1> <5B8DA87D05A7694D9FA63FD143655C1B9D9FA974@hasmsx109.ger.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018, Winkler, Tomas wrote:
>> This is the list of patches (assuming that I didn't miss anything)
>> that still need tested-by tags:
>
> Those are just code movements, we are running them form months on our
> systems.

I'm not sure what point you are trying to make. You cannot give
tested-by by yourself to yourself you know. By saying that you
are just saying things. It is not any form of peer testing.

>> - tpm: factor out tpm1_get_random into tpm1-cmd.c
>> - tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
>> - tpm1: rename tpm1_pcr_read_dev to tpm1_pcr_read()
>>    (the subsystem tag is wrong in this, just noticed, should be 'tpm:')
> When have you established this requirement I missed that and it cannot
> be deduced from the git history.

Which requirement?

/jarkko
