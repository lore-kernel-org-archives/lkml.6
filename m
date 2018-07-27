Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C9F2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C9F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeG0JnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:43:20 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46102 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbeG0JnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:43:19 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fiy19-0007qV-UW; Fri, 27 Jul 2018 09:22:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 09:22:31 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com
Subject: Re: [Linux-kernel] tegra clock updates and fixes
In-Reply-To: <153261857589.48062.4721112255504541100@swboyd.mtv.corp.google.com>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <16564340083ea64de8c956ba65ea59f8@codethink.co.uk>
 <153261857589.48062.4721112255504541100@swboyd.mtv.corp.google.com>
Message-ID: <22193ef215e669f4273f8a66bf5482db@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-26 16:22, Stephen Boyd wrote:
> Quoting Ben Dooks (2018-07-26 06:32:29)
>> On 2018-07-20 14:45, Ben Dooks wrote:
>> > Hi, this is a set of clock updates and fixes we did when developing
>> > the tegra20/tegra30 auto support. The audio change is due to using
>> > the tegra in clock-slave mode (this hasn't been done before)
>> >
>> > We have also implemented the clock reset status callback as it is
>> > used by some of the driver work we did.
>> 
>> Is it possible to look at applying the bits of the series that are
>> not currently under discussion? If so should I post a smaller series?
>> 
> 
> Just send it again please. I'd prefer to see some reviewed-by tags from
> Nvidia folks on bits that are good to merge.

I've seen feedback on some of the tegra3 clock bits, however no one
has made any comments on other bits like the reset controller.

-- 
Ben

