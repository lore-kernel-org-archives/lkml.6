Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15CC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE0321A60
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE0321A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeHGDMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:12:33 -0400
Received: from gherkin.frus.com ([192.158.254.49]:52544 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbeHGDMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:12:33 -0400
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 64F343CFF1; Mon,  6 Aug 2018 20:00:49 -0500 (CDT)
Date:   Mon, 6 Aug 2018 20:00:49 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     linux-net@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [BUG] 4.18-rcX iptables regression
Message-ID: <20180807010049.GA1345@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With iptables v1.6.0 and kernel version 4.18-rc7, "iptables [-t table] -L"
produces diagnostic output to the effect of not being able to find the table.
Kernel version 4.17.0 and earlier work fine.

--Bob
