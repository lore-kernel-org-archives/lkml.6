Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B655C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C751223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C751223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbeKNT2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:28:38 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:47560 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbeKNT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:28:37 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from sneezy.aussec.com (sneezy.aussec.com [172.16.0.4])
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTP id wAE9PwQd000790;
        Wed, 14 Nov 2018 20:26:03 +1100
Received: from c110-21-61-29.farfl4.nsw.optusnet.com.au
 (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29]) by www.aussec.com
 (Horde Framework) with HTTP; Wed, 14 Nov 2018 20:25:53 +1100
Message-ID: <20181114202553.77552e2pm1ujv8yp@www.aussec.com>
Date:   Wed, 14 Nov 2018 20:25:53 +1100
From:   tom burkart <tom@aussec.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] pps: descriptor-based gpio, capture-clear
 addition
References: <20181113034007.3878-1-tom@aussec.com>
 <20181113034007.3878-2-tom@aussec.com>
 <20181113034007.3878-3-tom@aussec.com>
 <20181113151444.cszd2zdwoast3545@localhost>
In-Reply-To: <20181113151444.cszd2zdwoast3545@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Richard Cochran <richardcochran@gmail.com>:

> Device tree is a user space facing ABI, and so you must continue to
> support the legacy binding as well.
Hi Richard,
thanks for the pointer.  I will work on generating a new patch to
address this and therefore not break backward compatibility.

Tom


