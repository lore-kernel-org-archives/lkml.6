Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4776C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95412147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBTPAR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:00:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:53132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfBTPAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:00:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9864B62B;
        Wed, 20 Feb 2019 15:00:15 +0000 (UTC)
Date:   Wed, 20 Feb 2019 16:00:15 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] genirq/irqdomain: fall back to default domain
 when creating hierarchy domain
Message-Id: <20190220160015.22fad67d70a762746bd49c4b@suse.de>
In-Reply-To: <20190220091537.4cf01191@why.wild-wind.fr.eu.org>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190219155728.19163-10-tbogendoerfer@suse.de>
        <20190219162716.04b0a54b@why.wild-wind.fr.eu.org>
        <20190219174829.26576a5b6bf62cd99adf294a@suse.de>
        <20190220091537.4cf01191@why.wild-wind.fr.eu.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 09:15:37 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> Well, short of doing the above, I'd rather have something in the common
> code that allows the default domain to be retrieved. How about the
> patch below?

Works for me:-) Thank you.

Are you going to submit it for v5.1 ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
