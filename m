Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38730C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394C520838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394C520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJYOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:00:34 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:41818 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJYOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:00:33 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 10:00:33 EDT
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181025052006.CSCL4163.fed1rmfepo203.cox.net@fed1rmimpo110.cox.net>
          for <linux-kernel@vger.kernel.org>;
          Thu, 25 Oct 2018 01:20:06 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id rhL61y00459yGBo01hL6qK; Thu, 25 Oct 2018 01:20:06 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090204.5BD15286.0048,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=f4j8+96M c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10
 a=2sszkzDHKysZIpGQcLwA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id E6AF529A0093;
        Wed, 24 Oct 2018 22:20:05 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Cc:     ischis2@cox.net
Subject: Linux kernel crash
Date:   Wed, 24 Oct 2018 22:20:05 -0700
Message-ID: <1654617.UvxYW9xS0L@thunderbird>
Organization: Personal
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A week ago I upgraded to the latest Ubuntu distribution (Linux thunderbird 
4.18.0-10-generic #11-Ubuntu SMP Thu Oct 11 15:13:55 UTC 2018 x86_64 x86_64 
x86_64 GNU/Linux).   

Whenever I run "shutdown -h now" or "reboot" I receive an immediate kernel 
crash with a dump that has:

"Code: Bad RIP value"

What is the best way of collecting and sending information to upstream.  I 
don't mind learning to build and install the kernel if that will help debug 
this.

sps




