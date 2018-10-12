Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0460CC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD631205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD631205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJMA5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:57:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:51114 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeJMA5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:57:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 92BE42E5;
        Fri, 12 Oct 2018 17:24:04 +0000 (UTC)
Date:   Fri, 12 Oct 2018 11:24:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] LICENSES: Add note to CDDL-1.0 license that it
 should not be used
Message-ID: <20181012112403.52e6dd70@lwn.net>
In-Reply-To: <20181010201509.26979-1-hdegoede@redhat.com>
References: <20181010201509.26979-1-hdegoede@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 22:15:08 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The only reason we have the CDDL-1.0 license text around is for some
> dual-licensed files from virtualbox. New code should not use this license.
> 
> Add a note about this and change the example tag to be dual-licensed.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

jon
