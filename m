Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3851DC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BCD20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m17ZFl3X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bHL/w7PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BCD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeGXXFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:05:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeGXXFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:05:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57BB1605A4; Tue, 24 Jul 2018 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532469404;
        bh=hXUgBolMuZydvp9SR7TRmu5dQgSC2svKT8KUcG+wXPk=;
        h=Date:From:To:Cc:Subject:From;
        b=m17ZFl3X7FrKmJgIlqLZZ59asGShwuWQkO+NlcdY3F2htqGAHHBtGZlQL+s8PefkV
         aW14A1coBZXZ8v12+p9utMTAmbeBVEyatcPdnvKFaIwOpRC8Pii4BHlHO/cMukdEBd
         tnjbOMvZkrC0Df9mdXKyp9OB82gVhK+9cPWOdwGw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7F4A260481;
        Tue, 24 Jul 2018 21:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532469403;
        bh=hXUgBolMuZydvp9SR7TRmu5dQgSC2svKT8KUcG+wXPk=;
        h=Date:From:To:Cc:Subject:From;
        b=bHL/w7PTrXjmBGp+OLi4gB6GBN5UocRFq2zijZSeKd2HksoJTvh9AiC6mBU8gN9bi
         upqJdHe+MV/ik/QGTyHKUBJUo5fsBy1z5pGJ/+EHYqAlWqILRTjcl+YUDYZ2fGiZkA
         gZ1v2+9v9GmArgW5YSGuw3Px2rasNt7ICr+wd9jM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Jul 2018 14:56:43 -0700
From:   pheragu@codeaurora.org
To:     Apw <apw@canonical.com>, Joe <joe@perches.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Bryanh <bryanh@codeaurora.org>, Ckadabi <ckadabi@codeaurora.org>,
        Tsoni <tsoni@codeaurora.org>
Subject: Reminder to review a few patches sent two weeks ago
Message-ID: <e531d3a7a9db2e8d06da01cab2ad090d@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reminder to review a few patches I had sent last week. Below are the 
links for the patches.

https://lkml.org/lkml/2018/7/5/798
http://lists-archives.com/linux-kernel/29168320-checkpatch-check-for-invalid-return-codes.html

- Prakruthi Deepak Heragu
