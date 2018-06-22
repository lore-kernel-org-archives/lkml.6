Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BB023E96
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BB023E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeFVIAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:00:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:27975 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeFVIAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:00:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 01:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="65378181"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2018 01:00:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8708E143; Fri, 22 Jun 2018 11:00:20 +0300 (EEST)
Date:   Fri, 22 Jun 2018 11:00:20 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     yang.shi@linux.alibaba.com
Cc:     hughd@google.com, vbabka@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] mm: thp: inc counter for collapsed shmem THP
Message-ID: <20180622080020.fefoaywh77adp5hm@black.fi.intel.com>
References: <1529622949-75504-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529622949-75504-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529622949-75504-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:15:49PM +0000, yang.shi@linux.alibaba.com wrote:
> /sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed is used
> to record the counter of collapsed THP, but it just gets inc'ed in
> anonymous THP collapse path, do this for shmem THP collapse too.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
