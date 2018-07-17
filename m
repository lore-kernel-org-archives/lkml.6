Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6154FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273492146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273492146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeGQOX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:23:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:40752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731607AbeGQOX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A83BAFCD;
        Tue, 17 Jul 2018 13:51:10 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:51:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     jan <vereecke.jan@skynet.be>
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH] Patch enabling Fn function keys for Laptop Asus G730
 (keyboard 0x1869)
In-Reply-To: <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
Message-ID: <nycvar.YFH.7.76.1807171549510.997@cbobk.fhfr.pm>
References: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com> <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm> <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018, jan wrote:

> Thanks for your reply. However, I am confused. Pleas bear with me as this is
> the very first time that I submit a patch and I followed some guidance that I
> found on the internet (obviously not the correct one).
> 
> I suppose I just need to delete the parts of the email where you write "this
> doesn't go in the changelog".

Yeah, please put into the patch changelog only the things that should end 
up in the actual commit log (the thing you see when doing git log / git 
show etc).

> I am not sure what my signoff should contain. Could you point me to a correct
> guide for this ?

Please read

	Documentation/process/submitting-patches.rst

signoffs specifically are discussed in paragraph 11.

Thanks!

-- 
Jiri Kosina
SUSE Labs

