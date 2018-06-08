Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OU50C8NJGlv1MwAAmS7hNA
	; Fri, 08 Jun 2018 09:17:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16875607E4; Fri,  8 Jun 2018 09:17:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B2DBA601C3;
	Fri,  8 Jun 2018 09:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2DBA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeFHJRx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:17:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59820 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeFHJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:17:51 -0400
Received: from 79.184.253.104.ipv4.supernova.orange.pl (79.184.253.104) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 64122725869a8fab; Fri, 8 Jun 2018 11:17:49 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ravi Chandra Sadineni <ravisadineni@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        chenhong3@huawei.com, Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dtor@google.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the sysfs attribute.
Date: Fri, 08 Jun 2018 11:16:52 +0200
Message-ID: <3644427.ot4qJK4Njo@aspire.rjw.lan>
In-Reply-To: <CAOGSYL3ZHZ2Desafp5bmyEnfUW6xdu3CAhKu2=P7X_omb8Cavw@mail.gmail.com>
References: <20180602023215.176521-1-ravisadineni@chromium.org> <CAOGSYL0ga-H=0a5EEDmOWSZjnmG1Qc=9AxAbM_-ifHDj_FbREg@mail.gmail.com> <CAOGSYL3ZHZ2Desafp5bmyEnfUW6xdu3CAhKu2=P7X_omb8Cavw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 7, 2018 6:47:24 PM CEST Ravi Chandra Sadineni wrote:
> Hi Rafeal,
> 
> Soft ping. Is this patch good to be merged ?

Yes, it is.  It's there in my linux-next branch.

Thanks,
Rafael
