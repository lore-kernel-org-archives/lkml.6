Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED75C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012DF21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012DF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIYMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:12:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeIYMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:12:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 037E3AC90;
        Tue, 25 Sep 2018 06:06:53 +0000 (UTC)
Date:   Tue, 25 Sep 2018 08:06:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [mm, oom] 6209f6fc62: general_protection_fault:#[##]
Message-ID: <20180925060653.GN18685@dhcp22.suse.cz>
References: <20180925054820.GC27173@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925054820.GC27173@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-09-18 13:48:20, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 6209f6fc62835d84c2a92d237588a114e39436ce ("mm, oom: rework mmap_exit vs. oom_reaper synchronization")
> https://github.com/0day-ci/linux UPDATE-20180911-024633/Tetsuo-Handa/mm-oom-Fix-unnecessary-killing-of-additional-processes/20180910-163452

Do you have a msg-id to the patch that has been tested?
-- 
Michal Hocko
SUSE Labs
