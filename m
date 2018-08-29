Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C532089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C532089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeH2PEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeH2PEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:04:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B32AFAD18;
        Wed, 29 Aug 2018 11:08:02 +0000 (UTC)
Date:   Wed, 29 Aug 2018 13:08:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        sudeep.holla@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add NUMA emulation support
Message-ID: <20180829110802.GD10349@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-08-18 12:09:53, Shuah Khan wrote:
[...]
> The main intent is to use numa emulation in conjunction with cpusets for coarse
> memory management similar to x86_64 use-case for the same.

Could you be more specific please? Why would you want a hack like this
when you have a full featured memory cgroup controller to limit the
amount of memory?
-- 
Michal Hocko
SUSE Labs
