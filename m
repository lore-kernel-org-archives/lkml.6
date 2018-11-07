Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D62086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeKHIAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:00:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:45822 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbeKHIAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:00:14 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 86B172ED;
        Wed,  7 Nov 2018 22:27:48 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:27:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] Documentation/proc.txt: Add 2 missing fields for
 /proc/<pid>/status
Message-ID: <20181107152747.1f52f768@lwn.net>
In-Reply-To: <1540329951-22431-1-git-send-email-longman@redhat.com>
References: <1540329951-22431-1-git-send-email-longman@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 17:25:51 -0400
Waiman Long <longman@redhat.com> wrote:

> It was found that two of the fields in the /proc/<pid>/status file were
> missing - CapAmb & Speculation_Store_Bypass. They are now added to the
> proc.txt documentation file.
> 
> v2: Update the example as well.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied, thanks.

jon
