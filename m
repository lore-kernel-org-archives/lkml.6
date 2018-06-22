Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7371E23C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7371E23C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbeFVByC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:54:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:58764 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934184AbeFVBx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:53:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5M1roVE000711;
        Thu, 21 Jun 2018 20:53:52 -0500
Message-ID: <c304c6e08d7baa6e725c2634ea94b7fa326edd5a.camel@kernel.crashing.org>
Subject: linux-next: Please add the fsi tree
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Jun 2018 11:53:50 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen !

Please add the fsi tree at

https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git (master)

To linux-next. It contains the changes that I will send to Greg KH to the FSI
subsystem used by the service processor to communicate with IBM Power chips
(and eventually S390 as well).

Commits in there are intende to be merged via Greg's tree. Signed tags in
there have already been the subject of pull requests to Greg.

Thanks !

Cheers,
Ben.
