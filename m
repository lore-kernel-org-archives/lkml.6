Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A99ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C920846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5C920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:28:36 -0400
Received: from namei.org ([65.99.196.166]:39352 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeGPU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:28:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w6GJxKNx021528;
        Mon, 16 Jul 2018 19:59:20 GMT
Date:   Tue, 17 Jul 2018 05:59:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/8] kexec/firmware: support system wide policy
 requiring signatures
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1807170558400.19140@namei.org>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, all!

Series applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


-- 
James Morris
<jmorris@namei.org>

