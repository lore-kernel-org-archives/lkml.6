Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76233C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5362C222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404806AbfBMSIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:08:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:30882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404788AbfBMSIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:08:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 10:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="122194034"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2019 10:07:56 -0800
Date:   Wed, 13 Feb 2019 20:07:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Subject: Re: [PATCH v3] selftests/tpm2: Extend tests to cover partial reads
Message-ID: <20190213180759.GB27173@linux.intel.com>
References: <155007596864.18677.9373151400257566077.stgit@tstruk-mobl1.jf.intel.com>
 <155007601798.18778.10490966270922534995.stgit@tstruk-mobl1.jf.intel.com>
 <20190213171928.GB23351@linux.intel.com>
 <24290564-9c4d-93f4-d813-7ce4f1fd8745@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24290564-9c4d-93f4-d813-7ce4f1fd8745@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:22:56AM -0800, Tadeusz Struk wrote:
> On 2/13/19 9:19 AM, Jarkko Sakkinen wrote:
> > OK, great, thank you.
> > 
> > They are in my master branch now.
> 
> Thanks Jarkko. Are you planning to push it also to 5.1?

I did already my v5.1 pull request but might do another one if there are
regressions. So it depends.

/Jarkko
