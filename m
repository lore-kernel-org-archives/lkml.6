Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1720869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfBAJGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:06:48 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:53621 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfBAJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:06:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 57AA918398;
        Fri,  1 Feb 2019 10:06:46 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bc8g0INqKJws; Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id E03891835E;
        Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C599C1E092;
        Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94CE1E091;
        Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id AC79525EC;
        Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id A8DAA80C3C; Fri,  1 Feb 2019 10:06:45 +0100 (CET)
Date:   Fri, 1 Feb 2019 10:06:45 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tiwei.bie@intel.com,
        luto@kernel.org
Subject: Re: [PATCH v2] mic: vop: Fix broken virtqueues
Message-ID: <20190201090645.35kz2txrhmpeooxv@axis.com>
References: <20190130162809.14620-1-vincent.whitchurch@axis.com>
 <20190130194023.GB21181@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130194023.GB21181@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:40:23PM +0100, Greg KH wrote:
> This patch is already in my tree, can you just send a "fixup" patch
> instead of me  having to revert the old one and then adding this one
> again?

I've now posted the fixup patch separately as "mic: vop: Fix crash on
remove".  Thanks.
