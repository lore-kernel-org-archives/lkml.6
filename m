Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C32C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A502080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cnyhistory.org header.i=@cnyhistory.org header.b="lBf6yfP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeLOIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:45:51 -0500
Received: from walmailout06.yourhostingaccount.com ([65.254.253.52]:34553 "EHLO
        walmailout06.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbeLOIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:45:50 -0500
X-Greylist: delayed 1840 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2018 03:45:50 EST
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4] helo=walmailscan04.yourhostingaccount.com)
        by walmailout06.yourhostingaccount.com with esmtp (Exim)
        id 1gY56J-00050W-Pn
        for linux-kernel@vger.kernel.org; Sat, 15 Dec 2018 03:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cnyhistory.org; s=dkim; h=Sender:Date:Subject:From:Reply-To:To:Message-Id:
        Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQ3H6qiSRmW2ABasAsQMPUpcHjAy76gAZKFeT0bbRKM=; b=lBf6yfP/SCnSKv0RoEctgtonB0
        zORlchqJL7AcaYSMDaV/RZHLfwNxTZuwjLJ2zR0ycKN1uX93UuwCG5sxFcPyUbM3KwlSJSJEb2BmL
        ecAdHGm11fpOQr03L1foxrKB/bHR9B3gXTu6Gn4HsNGQnXIRA57X/JT5TW+vlYCQL1NZQa6RrDd+g
        hyJxmRQ1SpNR4GtXsahYkKAwSayti/8r0hpyb9yyHpb2TWdEFX54EXmxUttq7+FHYNIsrUN4ehO3G
        yED4Q7zLInDfn5CHMEDsuhCZpgwsefk8oyahcI4y/195cJbzECTjVVMp1fyvmcTzulCaKXwpR7L1L
        iKCYwK2A==;
Received: from [10.114.3.31] (helo=walimpout11)
        by walmailscan04.yourhostingaccount.com with esmtp (Exim)
        id 1gY56J-0007SO-Ii
        for linux-kernel@vger.kernel.org; Sat, 15 Dec 2018 03:15:07 -0500
Received: from walcustweb1505.yourhostingaccount.com ([10.1.112.89])
        by walimpout11 with 
        id C8F41z0051vmp22018F7Y7; Sat, 15 Dec 2018 03:15:07 -0500
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from pow.ohamuseum by walcustweb1505.yourhostingaccount.com with local (Exim)
        id 1gY55p-0008GU-5U
        for linux-kernel@vger.kernel.org; Sat, 15 Dec 2018 03:14:37 -0500
X-EN-Info: U=pow.ohamuseum P=/cgi-bin/ohacontact.cgi
X-EN-CGIUser: pow.ohamuseum
X-EN-CGIPath: /cgi-bin/ohacontact.cgi
X-EN-OrigIP: 185.17.149.160
Message-Id: <1544861677-170-pow.ohamuseum@walcustweb1505.yourhostingaccount.com>
To:     linux-kernel@vger.kernel.org
Reply-To: karen.cooney@cnyhistory.org
From:   karen.cooney@cnyhistory.org
Subject: Your OHA contact form
X-EN-Timestamp: Sat, 15 Dec 2018 03:14:37 -0500
Date:   Sat, 15 Dec 2018 03:14:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WilliamslupE:

Thank you for filling out our online contact form. 

Onondaga Historical Association
