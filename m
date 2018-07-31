Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740A6208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740A6208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeGaJGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:06:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729736AbeGaJGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:06:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A4FBADE2;
        Tue, 31 Jul 2018 07:27:27 +0000 (UTC)
Date:   Tue, 31 Jul 2018 09:27:25 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Ye Xiaolong <xiaolong.ye@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, LKP <lkp@01.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LKP] [lkp-robot] [confidence: ] 7757d607c6 [ 56.996267] BUG:
 Bad page map in process trinity-c2 pte:0d755065 pmd:0d55b067
Message-ID: <20180731072725.ecbhfm6642xxao5z@suse.de>
References: <20180721022325.GF12513@shao2-debian>
 <20180727132542.mt35m3knpwpsyb73@suse.de>
 <20180731020036.GB22500@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731020036.GB22500@yexl-desktop>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:00:36AM +0800, Ye Xiaolong wrote:
> On 07/27, Joerg Roedel wrote:
> >May I ask how this was bisected? I found it very hard to reproduce, it
> >triggered less then two times a day with the attached reproducer. Given
> >that the report came pretty fast after the patches landed in
> >tip/x86/pti, I guess it triggered a lot faster in your testing.
> >
> 
> There is higher reproduce rate (2/310) in 0day environment, and we got dozens
> of qemu running simultaneously for bisection thus can get bisect result promptly.

Ah okay, that makes sense. Thanks for your answer and thanks for the
report again.


Regards,

	Joerg

