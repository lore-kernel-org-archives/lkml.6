Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A6EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B22594E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="owz4URrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6B22594E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966056AbeF0Swv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:52:51 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:38896 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966032AbeF0Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GqQbkQILp+/Gmg7aFaL+AMFL7Ts/DUKNBPjfWLCX5F0=; b=owz4URrf8pgQiw37+mGg8QuHwh
        qRxaz0Sy/YQWsyUUWy8e2P/JHUgIoCw7c990wo0pg6ujKuG1rCDkzAjKU1rZWIk2du1yAaIZh8e7p
        zb3O22dQlWjNVIaZ0k3KT/nOe12k7wo2Mdhu4AJDVEzv+IRXAeBCZYL9+gwtrTpFUTbyeIugIxX+l
        RqsqRZDIHyYaW5OITvhkm0b6gH1CMwKc/SxPMTBXexbl6WqplMZjxmhOR9+OGk8sRRUn4dFX4iIpB
        qyGYgztpkZtHojULDY3O56j6rWsPH7SLHWyEp7IMsrwbR1amtQ5R7GV47tXu0ee33OSmjF9KYBzNP
        3PjTaBuw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38814 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYFYf-00G57A-10; Wed, 27 Jun 2018 18:52:49 +0000
Date:   Wed, 27 Jun 2018 11:52:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <monstr@monstr.eu>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc:     linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Linux kernel configurations for various Microblaze systems
Message-ID: <20180627185248.GA19743@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
to my list of qemu boot tests of upstream and stable release kernels.

Unfortunately I have been unable to locate working kernel configurations
for the those systems, nor working qemu command lines. I found a few links,
but they are all dead.

I would appreciate any help to get this working. 

Thanks,
Guenter
