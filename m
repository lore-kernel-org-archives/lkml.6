Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF8420684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="QWDe3eHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAVNtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:49:39 -0500
Received: from cock.li ([185.100.85.212]:52206 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbfAVNti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:49:38 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548164976; bh=KM8SjOvS3lu/30qhBsVMp82py36qzzG24b/8gaII7v0=;
        h=Date:From:To:Subject:From;
        b=QWDe3eHc/1mTg+2Y8t3LkAbek0sjVJqz7/ub3oalwivqQU/AjJoOf86qYDkHsb3jz
         pOpXZtgwj6QWqRMf7SjD3EJoHEf4kOCKCTsfhIinpWobqPKWVa3YrUlh+Qp8zPKt5p
         tiE1khkbeQsdqhfByL8AyliGQjzLM3XeKvsJCwTg6P4eGKEQmoadMwH1Xw8YKYCg7M
         /Z89kldQX8V/BXseOZUGuFj1BtEEtNz5sT1xgusS/Q109GhoRmIutZkiREZ/neW6B8
         5pnC+srQdtLy+B2qVxu4cokgez+8l61N4DXWmhxgSybezEaLhrW5qPukX0viwRgPUr
         LkqCQihFRx+Aw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 13:49:35 +0000
From:   sicevar@redchan.it
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Subject: Slashdot: Author revokes GPL from "Geek Feminists"
Message-ID: <c3d566239ed6ebf0c01cf07e428320b0@redchan.it>
X-Sender: sicevar@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://slashdot.org/submission/9129664/author-rescinds-gpl
