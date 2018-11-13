Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F237C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E9222360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E9222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeKNCzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:55:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:30379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbeKNCzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:55:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 08:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="90806709"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2018 08:56:17 -0800
Date:   Tue, 13 Nov 2018 18:56:15 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181113165615.GB4752@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-5-roberto.sassu@huawei.com>
 <20181108140454.GE8922@linux.intel.com>
 <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com>
 <20181108151504.GD14072@linux.intel.com>
 <289C0413-4FFB-4831-B82A-D0C3A965053D@gmx.de>
 <20181108190835.GF20608@linux.intel.com>
 <20181113123449.GA22356@linux.intel.com>
 <0bbfd76f-67eb-52be-4475-7f8b57d198a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bbfd76f-67eb-52be-4475-7f8b57d198a1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 01:39:26PM +0100, Roberto Sassu wrote:
> > AFAIK the kernel development process does not disallow to use direct
> > git protocol for maintainer branches. Please, correct me if I'm
> > mistaken.
> 
> I solved the issue by creating a mirror of your repository with gitlab.

Ok, great!

/Jarkko
