Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED2D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeIYSib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:38:31 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:38046 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728588AbeIYSib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:38:31 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id 6C97727A4D1;
        Tue, 25 Sep 2018 14:31:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 194B11A1B52;
        Tue, 25 Sep 2018 14:31:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eO76ewmllw_A; Tue, 25 Sep 2018 14:31:07 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.85])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id 460511A1B55;
        Tue, 25 Sep 2018 14:31:05 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alexander.lochmann@tu-dortmund.de,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date:   Tue, 25 Sep 2018 14:31:05 +0200
Message-ID: <6262522.aGb77nX7K0@ws-140106>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de> <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Tuesday, September 25, 2018, 2:06:38 PM CEST Arnd Bergmann wrote:
> We don't really want an empty macro any more, this was used in
> the past, but causes compile-time warnings and undefined behavior
> for no good reason.

Can you elaborate or point me to some other discussion about that undefined behavior?

Best regards,
Alexander



