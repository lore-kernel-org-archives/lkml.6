Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B13AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0048A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HOXtYUUi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="leRQfUkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0048A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGPUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:51:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeGPUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:51:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45AD2607B9; Mon, 16 Jul 2018 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531772565;
        bh=hXUgBolMuZydvp9SR7TRmu5dQgSC2svKT8KUcG+wXPk=;
        h=Date:From:To:Cc:Subject:From;
        b=HOXtYUUiWqIuWqeyJJAE85avM+TCRQgwWbaoJln71okfU8iSrWR2MU6CZhb8k+SSM
         +IEptSf0V9S6Bo7julFwz3pAbvf09m/QaHKpMh2wuFrwDfEWWwZREBW66epLX7gDMW
         ccjSDj5QQlGBv8em65wy3AIgpu/W/dGZW3wwKwcw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A00BD60555;
        Mon, 16 Jul 2018 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531772564;
        bh=hXUgBolMuZydvp9SR7TRmu5dQgSC2svKT8KUcG+wXPk=;
        h=Date:From:To:Cc:Subject:From;
        b=leRQfUkVWTCZOPJdhr+RlhxRSNbw23Fs0ZZZaWAnQzMt965Jfwqbl4Qs30kL1OfGd
         fc1DDtbT6V8tJxGVpQYtEluhYpJifGV2rRR46glBRm66qSzldSECmAz1paMe/FsCWQ
         FMo/TeqzRw7oiHlvxjUK/M1nKx7XJhvMQvVE9Xkg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Jul 2018 13:22:44 -0700
From:   pheragu@codeaurora.org
To:     apw@canonical.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org
Subject: Reminder about previous patches
Message-ID: <54066818736ba17cb04e50cfa2931c29@codeaurora.org>
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
