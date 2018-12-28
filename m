Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F957C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB64E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="FFPp83BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbeL1R7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:59:33 -0500
Received: from cock.li ([185.100.85.212]:36046 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbeL1R7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:59:33 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546019969; bh=BgvgL1XSBuwpJGazIBPIWF/mZTDnA0TV/CSrPDr/ivI=;
        h=Date:From:To:Cc:Subject:From;
        b=FFPp83BXczGYjB9Hk8gM9TU9pzmPY4lBIoU/vedGgzgYXngqmUBundNj0vDodg6z3
         b7vwiVlnaimvNEEzuTI9hK7JXMAkX5pWHq1GAFVirz+osivGTMNLg/uComxpmqBoS1
         gRxMqAx7O3nOoQol4pGv9w59PGjWk386XQdJ891jeyDVTOiP4riV2tszzrq1olHRVR
         hMlQ/j1F2gOGKLfnZJ0Vd+Cb21EVDhu6oJWfItPYWIWpwZpz6bbhnDEZvyp3NZZ6CQ
         RuTz7nA0fqDqVJDTFYNDzn4w7BoeRTvASLtkc4RuZKQS/tmoIzKCUTeFGEshZcmvgd
         XWQBU0PNA9CvQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 17:59:28 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org
Cc:     gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        dng@lists.dyne.org, misc@openbsd.org
Subject: A license is a temporary grant, not a transfer.
Message-ID: <215d7fb3c30394334d47ce3438b4f260@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1013746
> If you think that rescinding the GPLv2 is possible why don't you do it 
> :^)

You do realize that a license pertains to the licensed article, do you 
not?

Do you imagine that the goal is to "blanket rescind all licenses using 
the GPLv2 verbiage"? Is that it? Are you that stupid a lay person?

The guy who owns the property grants the license. Understand?
He can rescind that license whenever he wishes, unless you pay him not 
to, or he promises not to and you reasonably rely on that promise.
(did you pay for that promise? is it reasonable for you to rely on?).

Did each of the linux programmers make such a promise to you?
No they did not.
Did you pay each of the linux programmers anything.
No you did not.

They can rescind the license from you.

Understand?

A license is a temporary grant, it is not a transfer.

