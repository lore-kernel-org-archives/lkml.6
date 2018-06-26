Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F4E26B48
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F4E26B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeFZVPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:15:48 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:46735 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZVPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:15:46 -0400
Received: from [78.134.103.148] (port=59302 helo=[192.168.77.58])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fXvJN-001Zf4-8B; Tue, 26 Jun 2018 23:15:41 +0200
Subject: Re: [PATCH v4 0/8] media: imx274: cleanups, improvements and
 SELECTION API support
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
 <20180626121934.5xhp6k7x2se6pmqr@valkosipuli.retiisi.org.uk>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <b83f95a2-f0be-b6e8-f9f7-a7b628bcb075@lucaceresoli.net>
Date:   Tue, 26 Jun 2018 23:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626121934.5xhp6k7x2se6pmqr@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 26/06/2018 14:19, Sakari Ailus wrote:
[...]
> My apologies for delays in reviewing the set. I'll take patches 1--5 and 7
> and then I'll comment on patches 6 and 8 separately. Would that work for
> you?

Sure.

I'll reply to your comment to patch 6 as soon as possible.

Bye,
-- 
Luca
