Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E79C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D58E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D58E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJORxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:53:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeJORxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:53:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gBznf-0002iU-Ik; Mon, 15 Oct 2018 12:08:35 +0200
Date:   Mon, 15 Oct 2018 12:08:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] LICENSES: Add note to CDDL-1.0 license that it should
 not be used
In-Reply-To: <20181015095314.GA14428@infradead.org>
Message-ID: <alpine.DEB.2.21.1810151208210.23603@nanos.tec.linutronix.de>
References: <20181010110540.22468-1-hdegoede@redhat.com> <alpine.DEB.2.21.1810101518050.15060@nanos.tec.linutronix.de> <20181015095314.GA14428@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Christoph Hellwig wrote:
> On Wed, Oct 10, 2018 at 03:23:07PM +0200, Thomas Gleixner wrote:
> > I'd rather replace the 'GPL-2.0' with something like '$GPL-COMPATIBLE-ID'
> > and say explicitely in the prosa text that CCDL can only be used with OR
> > and not with AND.
> 
> Maybe we should take the whole thing to a higher level, and split
> the other folder into
> 
> legacy/
>  - for licenses that exist but should never be used for new code
> 
> and
> 
> dual/
>  - for licenses that should only be used for dual licensing with
>    something from preferred/

That makes sense.

Thanks,

	tglx

