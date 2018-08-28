Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B555E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B555E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH2BAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:00:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:00:46 -0400
Received: from localhost (unknown [104.129.192.188])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C5B2AF3;
        Tue, 28 Aug 2018 21:07:19 +0000 (UTC)
Date:   Tue, 28 Aug 2018 14:07:17 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     Todd Kjos <tkjos@google.com>, Arve Hj??nnev??g <arve@android.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        ben@decadent.org.uk
Subject: Re: [PATCH v2] binder: use standard functions to allocate fds
Message-ID: <20180828210717.GA31143@kroah.com>
References: <20180828204300.231069-1-tkjos@google.com>
 <CAD0t5oMXgaGNKNbWjFRLmf-O+dd-5Yr0yZs=q1Y07JX0dc9Mbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD0t5oMXgaGNKNbWjFRLmf-O+dd-5Yr0yZs=q1Y07JX0dc9Mbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:43:35PM -0700, Todd Kjos wrote:
> Sorry, forgot to bump the version. Ignore this one.

Huh?  I see two "v2" patches :(

totally confused.

greg k-h
