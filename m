Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74B420883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74B420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeGJSZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:25:08 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:49296 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732266AbeGJSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:25:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 6EC1318021E36
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 17:46:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 44128127F;
        Tue, 10 Jul 2018 17:46:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coach07_7137644752d4c
X-Filterd-Recvd-Size: 1326
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Jul 2018 17:46:17 +0000 (UTC)
Message-ID: <5f85df9e26a3ca19e5a6b65a0d8df194581ab29c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Handle long multi-line macros better
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org
Date:   Tue, 10 Jul 2018 10:46:16 -0700
In-Reply-To: <1531244524-16003-1-git-send-email-pheragu@codeaurora.org>
References: <1531244524-16003-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 10:42 -0700, Prakruthi Deepak Heragu wrote:
> Currently, the checkpatch throws an error on long macro expressions which
> is more than one line i.e the opening and the closing bracket pair not
> being on the same line. This patch gives the dangling backslash the
> benefit of doubt and allows it to consider the closing paranthesis on the
> next line as part of the macro expression and doesn't throw an error.

Example please.

