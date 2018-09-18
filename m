Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94488ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F6F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F6F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeIRPwU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRPwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45CF583F42;
        Tue, 18 Sep 2018 10:20:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6F0E61B64;
        Tue, 18 Sep 2018 10:20:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com>
References: <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com> <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com> <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com> <20180913010517.GB7632@shao2-debian> <23069.1536838121@warthog.procyon.org.uk> <7969.1537252241@warthog.procyon.org.uk> <9189.1537255398@warthog.procyon.org.uk>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     dhowells@redhat.com, Rong Chen <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9498.1537266023.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 11:20:23 +0100
Message-ID: <9499.1537266023@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Sep 2018 10:20:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian <zhijianx.li@intel.com> wrote:

> this is not expected.
> could you list/home/dhowells/.lkp/cache

final_initrd  initrd-concatenated  lkp/  lkp-x86_64-ad88cb1a437a_.cgz  osimage/

Note that ~/.lkp is a symlink to somewhere that I don't mind clobbering.

Does this assume that I'm running on some particular OS other than Fedora?

David
