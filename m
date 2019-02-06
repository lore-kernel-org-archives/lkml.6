Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB822175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfBFRKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:10:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:12414 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfBFRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:10:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 09:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136388773"
Received: from briva-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.148])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 09:10:28 -0800
Date:   Wed, 6 Feb 2019 19:10:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v10 0/6] tpm: retrieve digest size of unknown algorithms
 from TPM
Message-ID: <20190206171027.GA25668@linux.intel.com>
References: <20190206105724.14495-1-roberto.sassu@huawei.com>
 <20190206125725.GA9257@linux.intel.com>
 <1fff7b54-cc9a-7705-4c26-819bdd1286f2@huawei.com>
 <20190206135450.GA20061@linux.intel.com>
 <2dea31e3-0796-e21f-5625-1ddc78485c71@huawei.com>
 <20190206153445.GA23970@linux.intel.com>
 <3cd14c24-9de2-d347-b40c-22ca87d9df87@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd14c24-9de2-d347-b40c-22ca87d9df87@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:07:49PM +0100, Roberto Sassu wrote:
> Seems ok to me. I'll send patch 3/6 and 4/6.

Your series has been applied to master and next. Thank you.

/Jarkko
