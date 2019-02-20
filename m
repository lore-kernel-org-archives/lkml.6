Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6299C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE862147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="k8b/b1t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfBTQgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:36:22 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:2892 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfBTQgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:36:21 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 444NVy31Pgz7y;
        Wed, 20 Feb 2019 17:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1550680508; bh=mArx3lQNxcAMVi6yx7LwatL78DeNE70aWYwFI/YEqmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8b/b1t05Ri+PAk+ytVgKwgSoxtqzWLxd3xZ9dJoTMURUXEbSbCo0/hzzfruj2ck8
         YvtpHUAQnOkMxFIB8iSBnWPZ8PUCJzUj7XfYgiWUd7BdjBAkI+Z5KAyU4I6Zzb4Mmr
         4hBUnl+YeWvLKQ9a44mjO5YfwR5q6DEGi1RZLUJTyASYSfXuHsof/C337MGRh8i4PX
         ZUpTlxl1rIwgjjfVBBtQK78Sis1n2vvYg2Vay/zxrZd/3DjY1XhEOl5//j6TQ+T99l
         o5qbBhXqVkb0wqQvRvHf/ukuRb3oZRzKjKebGm2FwEr4lFJcaQgU3Rbsl3/RCf606T
         6W6OAqQIialWg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Wed, 20 Feb 2019 17:36:14 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190220163614.GA11116@qmqm.qmqm.pl>
References: <20190218001726.16785-1-digetx@gmail.com>
 <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:30:20PM +0300, Dmitry Osipenko wrote:
> 18.02.2019 3:17, Dmitry Osipenko пишет:
> > Hello,
> > 
> > This patchset adds support for the Trusted Foundations firmware on
> > NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> > firmware and upstream kernel can't boot on those devices without the
> > firmware support.
> 
> Hello Michał,
> 
> Will be awesome if you could test the series on yours TF300T and report back, thanks in advance!

I think I will be able to look into this during the weekend. Which
kernel tree do you suggest as base?

Best Regards,
Michał Mirosław
