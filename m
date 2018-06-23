Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA3C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598FD2482B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598FD2482B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934479AbeFWA2j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:28:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:13325 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934235AbeFWA2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:28:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 17:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="66514318"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.80.177]) ([10.254.80.177])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2018 17:28:36 -0700
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To:     David Howells <dhowells@redhat.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1529706536.git.reinette.chatre@intel.com>
 <27828.1529711149@warthog.procyon.org.uk>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a3501feb-384e-491e-378b-318bb6394e84@intel.com>
Date:   Fri, 22 Jun 2018 17:28:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <27828.1529711149@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 6/22/2018 4:45 PM, David Howells wrote:
> Do you have a public git branch with these patches on it somewhere?

I just added them to branch cache-pseudo-locking/v7 of
https://github.com/rchatre/linux.git

Reinette

