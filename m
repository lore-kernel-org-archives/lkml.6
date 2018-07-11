Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A27C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C720B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06C720B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeGKJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:55:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbeGKJzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:55:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A876C7A7F0;
        Wed, 11 Jul 2018 09:51:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 648BE2156891;
        Wed, 11 Jul 2018 09:51:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     dhowells@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27029.1531302693.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jul 2018 10:51:33 +0100
Message-ID: <27030.1531302693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 09:51:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 09:51:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you say what the --target tuple should be so that I can add the arch to my
collection of Fedora cross-binutils and cross-gcc tools built from upstream
binutils and gcc sources?

Thanks,
David
