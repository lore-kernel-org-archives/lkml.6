Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1766CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E9E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="09KqKxq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E9E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJ2W2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeJ2W2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:28:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085E32080A;
        Mon, 29 Oct 2018 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540820374;
        bh=r1cTNo0D2RkZ1RPW0mGRyLmlJj+bo5ny7+kdm4klXS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09KqKxq5tXv4TLPmGboHaEE7EcFel8zbaVPnB4kDzGGmviep6FytZLtwBxmHVuEu1
         Hy/+G2cvz12xwee2nGPpKDScr3Wz33UZkC7/bFHrXTAygUccbJ/o/BP4nclHz34euS
         gjGN3VVYaSoJ9q8tuprWFcfGSXT3bKchHQ2cHhns=
Date:   Mon, 29 Oct 2018 09:39:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH AUTOSEL 4.9 91/98] tty: serial: pl011: add ttyAMA for
 matching pl011 console
Message-ID: <20181029133932.GN2015@sasha-vm>
References: <20181025141423.213774-1-sashal@kernel.org>
 <20181025141423.213774-91-sashal@kernel.org>
 <20181025151715.GB32027@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181025151715.GB32027@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:17:15PM +0100, Sudeep Holla wrote:
>Hi Sasha,
>
>On Thu, Oct 25, 2018 at 10:14:16AM -0400, Sasha Levin wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> [ Upstream commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b ]
>>
>
>This commit was later reverted with commit b767ad726c2a ("Revert "tty: serial:
>pl011: add ttyAMA for matching pl011 console"") as it caused regression else
>where. So I assume you can drop this. Unfortunately the revert doesn't
>carry fixes tag hence I thought of mentioning to you.
>
>The original issue still exists.

I'll drop it. Thanks for the heads-up!

--
Thanks,
Sasha
