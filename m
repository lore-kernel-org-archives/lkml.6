Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC37C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CBA2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeLSLpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:45:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:25060 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeLSLpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:45:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 03:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="305069899"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2018 03:45:18 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] stm class: Fix a module refcount leak in policy creation error path
In-Reply-To: <20181219084914.GA28855@kroah.com>
References: <20181214155347.75722-1-alexander.shishkin@linux.intel.com> <20181214155347.75722-2-alexander.shishkin@linux.intel.com> <20181219084914.GA28855@kroah.com>
Date:   Wed, 19 Dec 2018 13:45:17 +0200
Message-ID: <87sgyteo4y.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, Dec 14, 2018 at 05:53:45PM +0200, Alexander Shishkin wrote:
>> Commit ccddbbf4ef27 ("stm class: Introduce framing protocol drivers")
>
> I don't see that commit id in Linus's tree, are you sure it is correct?

No, I messed it up somehow. Sorry about that. The real commit is
c7fd62bc69d0. Fixed version follows. Let me know if I should re-send the
whole thing.

Thanks,
--
Alex

