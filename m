Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA220870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFA220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeLLXmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:42:50 -0500
Received: from namei.org ([65.99.196.166]:51486 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:42:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBCNgRB8007873;
        Wed, 12 Dec 2018 23:42:28 GMT
Date:   Thu, 13 Dec 2018 10:42:27 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/5] security: remove needless usage of module header
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <alpine.LRH.2.21.1812131041490.7600@namei.org>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018, Paul Gortmaker wrote:

> Paul Gortmaker (5):
>   security: audit and remove any unnecessary uses of module.h
>   keys: remove needless modular infrastructure from ecryptfs_format
>   security: fs: make inode explicitly non-modular
>   security: integrity: make evm_main explicitly non-modular
>   security: integrity: make ima_main explicitly non-modular

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-general

-- 
James Morris
<jmorris@namei.org>

