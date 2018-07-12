Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF61C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0221479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F0221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGLNBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:01:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56361 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbeGLNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:01:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1581208|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.CPhePmV_1531399913;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CPhePmV_1531399913)
          by smtp.aliyun-inc.com(10.147.42.16);
          Thu, 12 Jul 2018 20:51:53 +0800
Date:   Thu, 12 Jul 2018 20:51:52 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     David Howells <dhowells@redhat.com>, sandra@codesourcery.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
Message-ID: <20180712125152.GA5226@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <27030.1531302693@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27030.1531302693@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:51:33AM +0100, David Howells wrote:
> Can you say what the --target tuple should be so that I can add the arch to my
> collection of Fedora cross-binutils and cross-gcc tools built from upstream
> binutils and gcc sources?
Metor Graghics are helping us upstream gcc and binutils.

@Sandra,

Could you help me to reply the question?

