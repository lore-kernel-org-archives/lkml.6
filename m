Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CAEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8522084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8522084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeKLJX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:23:29 -0500
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:3710 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731254AbeKLJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:23:28 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 12 Nov 2018 10:03:10 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gLzE1-0006Eo-Dr; Mon, 12 Nov 2018 10:33:05 +1100
Date:   Mon, 12 Nov 2018 10:33:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     hmsjwzb <weizhefix@gmail.com>
Cc:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix coding style issue in xfs_acl.c and xfs_aops.c
Message-ID: <20181111233305.GL19305@dastard>
References: <20181111003603.7598-1-weizhefix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111003603.7598-1-weizhefix@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:36:03AM +0800, hmsjwzb wrote:
> Possible unwrapped commit description (prefer a maximum 75 chars per line)

NACK. Our preference is (and always has been) for comments to fill
the entire 80 columns, just like the rest of the kernel. I have no
idea who told you "75 columns is preferred" but they are wrong.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
