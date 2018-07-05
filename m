Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A29E24048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29E24048
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeGELp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:45:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:3977 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753635AbeGELp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:45:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 04:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="52786652"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2018 04:45:54 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Tobias Tefke <tobias.tefke@gmail.com>
Cc:     tobias.tefke@tutanota.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: use correct articles in comments
In-Reply-To: <20180705112756.1663-1-tobias.tefke@tutanota.com>
References: <20180705112756.1663-1-tobias.tefke@tutanota.com>
Date:   Thu, 05 Jul 2018 14:45:54 +0300
Message-ID: <87wou9q51p.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Tefke <tobias.tefke@gmail.com> writes:

> These words are pronounced (and start) with a vowel sound.
> Therefore the article we use has to be 'an' instead of 'a'.

This, however, is not how we compose our changelog messages.

Regards,
--
Alex
