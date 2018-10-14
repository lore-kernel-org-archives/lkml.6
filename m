Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2769C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420CB20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420CB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJOBf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:35:26 -0400
Received: from gherkin.frus.com ([192.158.254.49]:56294 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeJOBf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:35:26 -0400
X-Greylist: delayed 1233 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 21:35:26 EDT
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 8D1223D001; Sun, 14 Oct 2018 12:33:06 -0500 (CDT)
Date:   Sun, 14 Oct 2018 12:33:06 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     Meelis Roos <mroos@linux.ee>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Relocation (type 4) overflow on alpha for big module
Message-ID: <20181014173306.GA14639@gherkin.frus.com>
References: <5bc11e00-258d-a6ea-fe63-ddcfdb847071@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc11e00-258d-a6ea-fe63-ddcfdb847071@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:07:13AM +0300, Meelis Roos wrote:
> I decided to try btrfs on one of my alphas and got a surprise - btrfs module does not load:

Confirmed on a PWS 433au running 4.19.0-rc6 with latest "sid" toolchain.

--Bob
