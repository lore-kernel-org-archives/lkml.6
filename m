Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pOcCLUOXGVvwdQAAmS7hNA
	; Thu, 07 Jun 2018 20:36:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C796A6074D; Thu,  7 Jun 2018 20:36:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 611E260452;
	Thu,  7 Jun 2018 20:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 611E260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFGUgW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:36:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753220AbeFGUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41F1BBB42F;
        Thu,  7 Jun 2018 20:36:20 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE6D1002963;
        Thu,  7 Jun 2018 20:36:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/x86: silead_dmi: Sort alphabetically + add 1 more model
Date: Thu,  7 Jun 2018 22:36:14 +0200
Message-Id: <20180607203617.11240-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:36:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 20:36:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren, Andy,

This series is mostly about sorting the silead_dmi.c entries
alphabetically to create some order in the chaos.

It also adds an entry for 1 more model.

Note this series applies on top of the pending
"platform/x86: silead_dmi: Add entry for Chuwi Hi8 S806_206 tablet touchscreen"
commit / on top of the review-andy branch.

Regards,

Hans
