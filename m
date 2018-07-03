Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D99FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319D24C47
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5319D24C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeGCHuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:50:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753781AbeGCHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:50:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B1E2F03;
        Tue,  3 Jul 2018 07:50:12 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:50:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
Message-ID: <20180703075009.GA27649@kroah.com>
References: <20180703070413.28756-1-andrew@aj.id.au>
 <20180703070413.28756-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703070413.28756-2-andrew@aj.id.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:04:10PM +1000, Andrew Jeffery wrote:
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

I can't take patches without any changelog text at all :(

