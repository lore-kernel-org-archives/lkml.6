Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED25C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1444205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1444205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeH2UHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:07:03 -0400
Received: from namei.org ([65.99.196.166]:44814 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeH2UHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:07:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7TG9LCc012188;
        Wed, 29 Aug 2018 16:09:21 GMT
Date:   Thu, 30 Aug 2018 02:09:21 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Christian Brauner <christian@brauner.io>
cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] security/capabilities: remove check for -EINVAL
In-Reply-To: <20180822115240.18196-1-christian@brauner.io>
Message-ID: <alpine.LRH.2.21.1808300209110.7406@namei.org>
References: <20180822115240.18196-1-christian@brauner.io>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018, Christian Brauner wrote:

> bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
> rc == -EINVAL check.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

