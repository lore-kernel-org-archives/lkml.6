Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E356F20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E356F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409912AbeKWX2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:28:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeKWX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:28:31 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQAor-00046C-2e; Fri, 23 Nov 2018 13:44:25 +0100
Date:   Fri, 23 Nov 2018 13:44:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCHv18 01/35] Documentation: v4l: document request API
In-Reply-To: <20181123102908.2ec61ce4@coco.lan>
Message-ID: <alpine.DEB.2.21.1811231343490.2603@nanos.tec.linutronix.de>
References: <20180814142047.93856-1-hverkuil@xs4all.nl> <20180814142047.93856-2-hverkuil@xs4all.nl> <alpine.DEB.2.21.1811121048400.14703@nanos.tec.linutronix.de> <20181118115215.5ebc681c@coco.lan> <20181123075157.077758c0@coco.lan>
 <alpine.DEB.2.21.1811231134100.2603@nanos.tec.linutronix.de> <20181123102908.2ec61ce4@coco.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Mauro Carvalho Chehab wrote:
> Ok, I'll use then the enclosed patch, replacing them by a free
> form license info, adding a TODO at the end, as a reminder.

LGTM. Thanks for fixing this.

      tglx
