Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A0B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A0B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJWTqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:52650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeJWTqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:46:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42AC4AF43;
        Tue, 23 Oct 2018 11:23:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0663DA6FB; Tue, 23 Oct 2018 13:22:53 +0200 (CEST)
Date:   Tue, 23 Oct 2018 13:22:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lkp-robot] [Btrfs]  5239834016:  blogbench.read_score -7.2%
 regression
Message-ID: <20181023112253.GP16290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kernel test robot <rong.a.chen@intel.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20181023065507.GJ24195@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023065507.GJ24195@shao2-debian>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 02:55:07PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -7.2% regression of blogbench.read_score due to commit:

Thanks.  I've seen some slightly worse performance results in blogbench,
but overall it's better or still acceptable, also confirmed by other
benchmarks. Nothing to worry about.
