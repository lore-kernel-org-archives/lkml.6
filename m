Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C8DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682321901
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545942723;
	bh=wITeotuaQcqySjxcAfZmtK8HyUvh7L3QYcfA8Tu63jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbdXFXAFEx6KIe5ocmBp1QRh6x/xTqxY9I/Fp3qgyojN1XyPON357b3M5yBE7v9Fj
	 thClh/imHCieX5PeHgS2q3N80vNxi5NESCFknce2sHj2cfvgE3Hk7uiFlrPcRrCLFy
	 PapjKaBfBJ0uVQp86Z8nuU1ykrwB7kex//6CEulo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeL0UcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:32:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:33500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729900AbeL0UcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:32:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ECFBAD88;
        Thu, 27 Dec 2018 20:32:00 +0000 (UTC)
Date:   Thu, 27 Dec 2018 21:31:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20181227203158.GO16738@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226131446.330864849@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-12-18 21:14:46, Wu Fengguang wrote:
> This is an attempt to use NVDIMM/PMEM as volatile NUMA memory that's
> transparent to normal applications and virtual machines.
> 
> The code is still in active development. It's provided for early design review.

So can we get a high level description of the design and expected
usecases please?
-- 
Michal Hocko
SUSE Labs
