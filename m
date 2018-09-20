Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D0FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5021532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC5021532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anw.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbeITURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:17:23 -0400
Received: from smtp.anw.at ([195.234.102.72]:33840 "EHLO smtp.anw.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387798AbeITURW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:17:22 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 16:17:21 EDT
Received: from [93.92.162.70] (I62-7O.static.anw.at [93.92.162.70])
        by smtp.anw.at (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w8KEQ6JZ013811
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 20 Sep 2018 16:26:07 +0200
Subject: Re: [PATCH] media: ddbridge: remove some duplicated include file
To:     zhong jiang <zhongjiang@huawei.com>, mchehab@kernel.org
Cc:     d.scheller@gmx.net, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537419396-29799-1-git-send-email-zhongjiang@huawei.com>
From:   "Jasmin J." <jasmin@anw.at>
Message-ID: <71432b31-90e1-4b51-8501-4361395870a8@anw.at>
Date:   Thu, 20 Sep 2018 16:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1537419396-29799-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Antivirus: checked in 0.016sec at smtp.anw.at ([195.234.102.72])
        by smf-clamd v1.2.1 - http://smfs.sf.net/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zhong!

Daniel is no longer maintaining the DD driver. In fact the driver is currently
unmaintained.

I have no time to check this in detail, but I guess you checked it already.
I give my ACK now, so that Mauro can merge it:

  Acked-by: Jasmin Jessich <jasmin@anw.at>

BR,
   Jasmin
