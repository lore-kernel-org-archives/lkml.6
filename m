Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07EEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E765215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E765215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeHOPpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:45:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728811AbeHOPpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:45:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC96CACCA;
        Wed, 15 Aug 2018 12:53:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A39E3DAC96; Wed, 15 Aug 2018 14:53:40 +0200 (CEST)
Date:   Wed, 15 Aug 2018 14:53:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] change some function to be void function
Message-ID: <20180815125340.GN24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533736075-8691-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533736075-8691-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:47:52PM +0800, zhong jiang wrote:
> v3->v2:
>  - Repost the patches with detailed changelog.
> v1->v2:
>  - Fix v1 issue that forget to return after remove the variable "ret".
> 
> zhong jiang (3):
>   fs/btrfs/disk-io: change btrfs_destroy_delayed_refs to be void
>     function
>   fs/btrfs/extent-tree: change btrfs_free_reserved_bytes to be void
>     funtion
>   fs/btrfs/tree-log: change btrfs_pin_log_trans to be void function

The patches 2 and 3 can be applied, but please update che subject and
put just "btrfs: " there, not the full file path. That we can find in
the diff. The changelogs can be still improved to be clear about callers
vs callees. Please update and resend.
