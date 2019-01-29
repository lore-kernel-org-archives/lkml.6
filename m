Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0071AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE64F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA2Ix2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:53:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2Ix1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:53:27 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goP90-0004xL-Pm; Tue, 29 Jan 2019 09:53:22 +0100
Date:   Tue, 29 Jan 2019 09:53:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eddie James <eajames@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, joel@jms.id.au, jdelvare@suse.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] occ: FSI and hwmon: Fix license headers
In-Reply-To: <1548692604-9899-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1901290953020.1669@nanos.tec.linutronix.de>
References: <1548692604-9899-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Eddie James wrote:

> From: Eddie James <eajames@linux.vnet.ibm.com>
> 
> Source files for the FSI OCC and OCC hwmon drivers had a combination of bad
> license information and missing IBM copyright. Correct the licenses.

Thanks for cleaning that up!

       tglx
