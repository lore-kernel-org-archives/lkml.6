Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F7C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872920868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKSa7yYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2872920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJLXPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbeJLXPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:15:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4675E2098A;
        Fri, 12 Oct 2018 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539358961;
        bh=KBUD+uP26LIb0qS2tr3fwzhikgik7E+OaZBRD5nCqF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKSa7yYHYhg1UY8Pmk0MIax74E81cOROsjHyeUcmzDzsi3ns2/91jzWs7NVqodmOh
         e9vzfPubilOMeXYJafU6eYMkuIBZkEt25MCIZ2s1ZPkTDsQcg+v0gIl+VBa494sD4/
         gzWCmGaaO8qpARos+NoMaC9amVNg4/tA0KlJ2vYk=
Date:   Fri, 12 Oct 2018 17:42:39 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] ARM: SoC fixes for 4.19
Message-ID: <20181012154239.GB25940@kroah.com>
References: <CAK8P3a0V3ddscW3x94rU0Yfh3HuTWhuhTsaKhKVy85+8ygf3Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0V3ddscW3x94rU0Yfh3HuTWhuhTsaKhKVy85+8ygf3Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:31:17PM +0200, Arnd Bergmann wrote:
> The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:
> 
>   Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> tags/armsoc-fixes-4.19

Now merged, thanks.

greg k-h
