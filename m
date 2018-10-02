Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B2C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57521473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJBHZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:25:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:14761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBHZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:25:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 17:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,329,1534834800"; 
   d="scan'208";a="77696279"
Received: from hubermic-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.31])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2018 17:44:41 -0700
Date:   Tue, 2 Oct 2018 03:44:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Message-ID: <20181002004440.GE23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 01:30:14AM +0300, Tomas Winkler wrote:
> This patch series provides initial separation of tpm 1.x and tpm 2.x
> commands, in foresight that the tpm 1.x chips will eventually phase out
> and can be compiled out for modern systems.
>  A new file is added tpm1-cmd.c that contains tpm 1.x specific commands.
> In addition, tpm 1.x commands are now implemented using tpm_buf
> structure and instead of tpm_cmd_t construct. The latter is now removed.
> 
> Note: my tpm 1.x HW availability is limited hence some more testing is needed.
> 
> This series also contains two trivial cleanups and addition of new
> commands by TCG spec 1.36, now supported on new Intet's platforms.

Would be nice if the change log was here and not scattered into
patches.

/Jarkko
