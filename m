Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4C3274C4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4C3274C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeF2L2y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:28:54 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:34647 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbeF2L2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:28:50 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 1583B3C0162;
        Fri, 29 Jun 2018 13:28:47 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mRS8-T0juQuw; Fri, 29 Jun 2018 13:28:40 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 654363C015C;
        Fri, 29 Jun 2018 13:28:40 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 29 Jun
 2018 13:28:40 +0200
Date:   Fri, 29 Jun 2018 13:28:36 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Daniel Mack <zonque@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Peter Chen <peter.chen@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Fix issues in UAC2 gadget driver
Message-ID: <20180629112836.GA31628@vmlxhi-102.adit-jv.com>
References: <20180621152252.8313-1-erosca@de.adit-jv.com>
 <20180628113930.GA8176@vmlxhi-102.adit-jv.com>
 <87sh56dri8.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87sh56dri8.fsf@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Fri, Jun 29, 2018 at 09:41:03AM +0300, Felipe Balbi wrote:
> all except for patch 6 is in my queue for current -rc. Patch 6 will go
> during merge window.

Thank you.

Best regards,
Eugeniu.
