Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAFBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD272156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD272156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbeIVDrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:47:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:46678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391400AbeIVDrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:47:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 14:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="93831053"
Received: from winnerl-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.194])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2018 14:57:02 -0700
Date:   Sat, 22 Sep 2018 00:57:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2, RESEND 2/3] tpm: modify tpm_pcr_read() definition to
 pass TPM hash algorithms
Message-ID: <20180921215701.GA23799@linux.intel.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
 <20180917093820.20500-3-roberto.sassu@huawei.com>
 <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411432db-ea57-a537-05d3-0b53008bef27@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:24:15PM +0200, Roberto Sassu wrote:
> On 9/17/2018 11:38 AM, Roberto Sassu wrote:
> > Currently the TPM driver allows other kernel subsystems to read only the
> > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > tpm2_pcr_read() to pass an array of tpm_digest structures, which contains
> > the desired hash algorithms. Initially, the array size is limited to 1.
> 
> Jarkko, is this patch ok?
> 
> Mimi, I wait for your review of the IMA part.
> 
> Roberto

Oops, just bumped into these. Have to check next week. Please add me to
either to- or cc-field in the future.

/Jarkko
