Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D970E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeIJRwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:52:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeIJRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:52:16 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzLlg-00080y-Dg; Mon, 10 Sep 2018 14:58:16 +0200
Date:   Mon, 10 Sep 2018 14:58:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: next-20180910: boots on thinkpad x60 (32bit machine) but has
 problems during suspend
In-Reply-To: <20180910075053.GA26513@amd>
Message-ID: <alpine.DEB.2.21.1809101457400.1292@nanos.tec.linutronix.de>
References: <20180909214632.GA26303@amd> <20180910060533.GA26941@amd> <20180910075053.GA26513@amd>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Pavel Machek wrote:
> 
> Next -0910 seems to boot ok... but when I hit the power button to
> suspend the machine...  Full dmesg is in the attachment.

Is this a next only issue or is this happening on Linus tree as well?

Thanks,

	tglx
