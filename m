Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8E9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8E9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeKVEMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:12:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40384 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbeKVEMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:12:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57B1814E34DEB;
        Wed, 21 Nov 2018 09:37:03 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:37:00 -0800 (PST)
Message-Id: <20181121.093700.824404593955121076.davem@davemloft.net>
To:     mst@redhat.com
Cc:     tiwei.bie@intel.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [PATCH net-next v3 00/13] virtio: support packed ring
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181121071308-mutt-send-email-mst@kernel.org>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
        <20181121071308-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Nov 2018 09:37:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 21 Nov 2018 07:20:27 -0500

> Dave, given the holiday, attempts to wrap up the 1.1 spec and the
> patchset size I would very much appreciate a bit more time for
> review. Say until Nov 28?

Ok.
