Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DFB20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2GmQkNl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DFB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeIJUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeIJUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:03:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C7120833;
        Mon, 10 Sep 2018 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536592159;
        bh=aszpdtxHuWuXOThOKUDKPKfMAz5aTTwx45GHf7cMTNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2GmQkNl22RpxRQvk1bLFm62+6d/yt5288/wNWPKA2nUQF4FNzR2njgAgnHvtSanI9
         AEd0TPcj4eK+NDAb7VztP5vrSjlZNb8raoi7gnAoYKuiwWEh3jVLQQOlFwbRbs/0Fo
         Xdb8buk3NJgRCkHloQCmOFN1hAUZwE2Ww9xPO3WM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 58E19141FFC; Mon, 10 Sep 2018 12:09:15 -0300 (-03)
Date:   Mon, 10 Sep 2018 12:09:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: include: Add PTR_ERR_OR_ZERO to err.h
Message-ID: <20180910150915.GM5147@kernel.org>
References: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 07, 2018 at 09:34:41AM +0800, Ding Xiang escreveu:
> Add PTR_ERR_OR_ZERO, and tools can use it.

Thanks, applied the two patches.

- Arnaldo
