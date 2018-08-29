Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BCFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C7E2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C7E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeH2USN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:18:13 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:50147 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728976AbeH2USM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:18:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2DC64837F24C;
        Wed, 29 Aug 2018 16:20:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys92_5bdea87dac84a
X-Filterd-Recvd-Size: 1353
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Aug 2018 16:20:31 +0000 (UTC)
Message-ID: <58648986219ce0173ff45d34def0da9f9f34b55f.camel@perches.com>
Subject: Re: [PATCH] [RFC] Drop all 00-INDEX files from Documentation/
From:   Joe Perches <joe@perches.com>
To:     Henrik Austad <henrik@austad.us>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Date:   Wed, 29 Aug 2018 09:20:30 -0700
In-Reply-To: <1535545728-8402-1-git-send-email-henrik@austad.us>
References: <1535545728-8402-1-git-send-email-henrik@austad.us>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 14:28 +0200, Henrik Austad wrote:
> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question.
> 
> A few years back it was mentioned that these files were no longer
> needed, and they have since then grown further out of date, so perhaps
> it is time to just throw them out.

Good idea.

.rst is becoming more common and these 00-INDEX files
are unnecessary and occasionally misleading.

