Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D8AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3AB2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3AB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIKUn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:43:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbeIKUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C74CAED3;
        Tue, 11 Sep 2018 15:44:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04FFBDAD9B; Tue, 11 Sep 2018 17:44:04 +0200 (CEST)
Date:   Tue, 11 Sep 2018 17:44:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        lufq.fnst@cn.fujitsu.com, suy.fnst@cn.fujitsu.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/extent_map: Remove unneeded variable "ret"
Message-ID: <20180911154404.GD2154@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        lufq.fnst@cn.fujitsu.com, suy.fnst@cn.fujitsu.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533474287-15049-1-git-send-email-zhongjiang@huawei.com>
 <5B7E9B1C.40404@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B7E9B1C.40404@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:31:40PM +0800, zhong jiang wrote:
> Hi,  dsterba
> 
> Can you pick up the patch? Thanks

Please send one patch per changed function with relevant changelog that
the return value is not used and that no callees could potentially
return an error that would need to be passed.
