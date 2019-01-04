Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8609C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB912173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546604705;
	bh=wuKr+0bpssAYtnttbVENNDA39Ib5EdqlZnEHcr56j+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VwxiMnahLRDPtt4JCOGBpBbhCsdpWhTZBzvvdqyJ3qmo7lQy4j1NONm36ugDRHzm4
	 OcONdnicd0xBdBVCK26ZLlaGA6HAegn9sPYoAmFuODH8hi0l0H+32Z2Vsp0PgBuqog
	 ddJv9fc/EU8AkYzVS8017KHKadozBfh4g1tOCPfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfADMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfADMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:25:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0ED2173B;
        Fri,  4 Jan 2019 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546604703;
        bh=wuKr+0bpssAYtnttbVENNDA39Ib5EdqlZnEHcr56j+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4iJ7PkKKORXSb6feYcnyyO49yLUoB5DDqE5aTjhGWSYhlBrT7vYZiR23+rOXPUgJ
         pEG+r9i1JMMXJGJV18ruccbIiTqL1wrk/z7D9Jg3lRjIaZZPOh/MRxZYCKjy5Vfj+I
         PiN/+Cj2YxizKdYIvRr7FIcbNZ3j2cAGBDcfmWnM=
Date:   Fri, 4 Jan 2019 13:25:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] treewide: fix spelling mistake: "lenght" -> "length"
Message-ID: <20190104122500.GA32076@kroah.com>
References: <20190104115022.13553-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104115022.13553-1-mcroce@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:50:22PM +0100, Matteo Croce wrote:
> Not a big issue, but can be annoying when searching for the "length"
> keyword can't find the right code.
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Please break this up into a one-patch-per-subsystem patch so that we can
all apply it when our different trees open.

thahks,

greg k-h
