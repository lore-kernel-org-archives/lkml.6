Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 43052C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86F9208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86F9208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=theobroma-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeFLJ27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:28:59 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:55460 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754242AbeFLJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:28:58 -0400
Received: from [86.59.122.178] (port=50514 helo=dhcp-10-2-9-209.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <jakob.unterwurzacher@theobroma-systems.com>)
        id 1fSfbi-00013P-QU; Tue, 12 Jun 2018 11:28:54 +0200
Subject: Re: [PATCH v5 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180411160642.18383-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
 <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
From:   Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <dc74cdb5-0431-d12e-1c09-caa4142b7fe1@theobroma-systems.com>
Date:   Tue, 12 Jun 2018 11:28:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.18 17:34, Marc Kleine-Budde wrote:
> 
> Applied to linux-can-next.
> 
> Thanks,
> Marc
> 

Marc, is the patch supposed to show up on
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/ 
or am I looking at the wrong tree?

Thanks,
Jakob
