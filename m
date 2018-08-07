Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32DBC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50868208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XBmq0Zsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50868208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeHGLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:10:55 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38272 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeHGLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:10:55 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5269F25B7C1;
        Tue,  7 Aug 2018 18:57:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1533632254; bh=VIdmRwxMinnTUdRUGDmSN4k80VW4eLxlxNXsid0dsiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBmq0ZsrtzOdZYHjZvhEqJFQFiqXJaZVsmPW8kqjn8rDYWOVhWpBnO/NzqdpVaAkT
         51MLEmtaCkWnLkFnA2sowpcpmGQpwuheaGW0YwxXUJqr5e620ykd1ScKDA6KLNpoje
         vY8fzMaRsZplJThu/omsq229wwuyAdb1p93vFdw8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3C63A940808; Tue,  7 Aug 2018 10:57:32 +0200 (CEST)
Date:   Tue, 7 Aug 2018 10:57:32 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: please clean up the ipvs-next tree
Message-ID: <20180807085727.vduqyxptqr5tcuyu@verge.net.au>
References: <20180806124928.43db0f44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806124928.43db0f44@canb.auug.org.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:49:28PM +1000, Stephen Rothwell wrote:
> Hi Simon,
> 
> The ipvs-next tree appears to contain a set of patches that have been
> merged into the net-next tree as different commits (some of them
> slightly different). This is just causing conflicts.

Thanks Stephen, I'll fix that.


