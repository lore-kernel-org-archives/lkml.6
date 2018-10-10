Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151EAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFD52086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFD52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJKDhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:37:04 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:38430 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbeJKDhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:37:04 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9AKDETI010350;
        Wed, 10 Oct 2018 21:13:14 +0100
Date:   Wed, 10 Oct 2018 21:13:13 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] code-of-conduct: Add back the TAB as the central
 reporting point
Message-ID: <20181010211313.5a63ce6f@alans-desktop>
In-Reply-To: <1539202230.12644.12.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
        <1539202230.12644.12.camel@HansenPartnership.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 13:10:30 -0700
> +appropriate to the circumstances. The TAB is obligated to maintain
> +confidentiality with regard to the reporter of an incident.

I would add (except where required by law.)

Alan
