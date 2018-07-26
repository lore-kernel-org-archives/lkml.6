Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFF82083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0+JEHZmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFF82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbeGZQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeGZQkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:40:16 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE9020685;
        Thu, 26 Jul 2018 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532618576;
        bh=eQcDptupJNWwsFC2GOlj7OJTNHhBn2vHZhVSyIrynDs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0+JEHZmnSFv2Ui0zRjgGazBPkohX/ZsbvE+YB6vqyXqEAkmLJ836utAs/yMhOpDeR
         hwuPghSnXIhM7+dAoo3kG9QRmS63wEgzU1/B/aJEweEsMGxzZpfIN3SuxI8izrI+8n
         zjAflvlH2gqv2AA22/j5JSWT1EA+BUwCOcTthrp0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <16564340083ea64de8c956ba65ea59f8@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, jonathanh@nvidia.co,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <16564340083ea64de8c956ba65ea59f8@codethink.co.uk>
Message-ID: <153261857589.48062.4721112255504541100@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [Linux-kernel] tegra clock updates and fixes
Date:   Thu, 26 Jul 2018 08:22:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ben Dooks (2018-07-26 06:32:29)
> On 2018-07-20 14:45, Ben Dooks wrote:
> > Hi, this is a set of clock updates and fixes we did when developing
> > the tegra20/tegra30 auto support. The audio change is due to using
> > the tegra in clock-slave mode (this hasn't been done before)
> > =

> > We have also implemented the clock reset status callback as it is
> > used by some of the driver work we did.
> =

> Is it possible to look at applying the bits of the series that are
> not currently under discussion? If so should I post a smaller series?
> =


Just send it again please. I'd prefer to see some reviewed-by tags from
Nvidia folks on bits that are good to merge.

