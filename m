Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94187C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7872148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7872148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeHVTMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:12:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729257AbeHVTMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:12:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E25BAAF5B;
        Wed, 22 Aug 2018 15:46:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 788E8DAC85; Wed, 22 Aug 2018 17:46:31 +0200 (CEST)
Date:   Wed, 22 Aug 2018 17:46:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     dsterba@suse.com, jbacik@fb.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 0/3] btrfs: remove unneeded variable and if possbile
Message-ID: <20180822154631.GK24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        dsterba@suse.com, jbacik@fb.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534437435-51605-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534437435-51605-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:37:12AM +0800, zhong jiang wrote:
> v3->v4:
>  -  btrfs_destroy_delayed_refs return value would be actually needed.
>     so just remove the unneeded variable "ret" and modify the subject
> 
> v2->v3:
>  - repost the patches with detailed commit message.
> 
> v1->v2:
>  - Fix v1 issue that forget to return after remove the variable "ret".
> 
> zhong jiang (3):
>   btrfs: remove unneeded variable "ret" in btrfs_destroy_delayed_refs
>   btrfs: change btrfs_free_reserved_bytes to be void funtion
>   btrfs: change btrfs_pin_log_trans to be void function

Patches 2 and 3 applied, thanks, but the first one dropped.
