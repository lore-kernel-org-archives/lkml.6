Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA627C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804522064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804522064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeLJA1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:27:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53328 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLJA1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:27:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC78F144C6663;
        Sun,  9 Dec 2018 16:27:13 -0800 (PST)
Date:   Sun, 09 Dec 2018 16:27:11 -0800 (PST)
Message-Id: <20181209.162711.1872275132406981860.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181209211139.GB21186@lunn.ch>
References: <20181210080045.0e67ad79@canb.auug.org.au>
        <20181209211139.GB21186@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 09 Dec 2018 16:27:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 9 Dec 2018 22:11:39 +0100

> On Mon, Dec 10, 2018 at 08:00:45AM +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Commits
>> 
>>   dc9d38cec71c ("net: phy: mdio-gpio: Add phy_ignore_ta_mask to platform data")
>>   04fa26bab06d ("net: phy: mdio-gpio: Add platform_data support for phy_mask")
>> 
>> are missing a Signed-off-by from their author.
> 
> Hi David.
> 
> Any idea what happened here? The version in my git repo has SOB.
> 
> https://patchwork.ozlabs.org/patch/1009811/ also has my SOB.

I wonder if "git am" ate it. :-/

Yeah it's the '--' I think.


