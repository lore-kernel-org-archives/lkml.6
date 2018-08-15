Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41B216E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC41B216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeHOIpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:45:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbeHOIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:45:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A045FACD2;
        Wed, 15 Aug 2018 05:54:37 +0000 (UTC)
Date:   Wed, 15 Aug 2018 07:54:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Michael Jin <mikhail.jin@gmail.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
Message-ID: <20180815055454.GB23008@nazgul.tnic>
References: <20180810193623.24629-1-mikhail.jin@gmail.com>
 <BN7PR12MB2593F278911BAF74943245F8F8380@BN7PR12MB2593.namprd12.prod.outlook.com>
 <CAO6F7D=iP7-gcRH1f1SsLzjXcgw=ZB4O6GikFoee8qyQWy4HFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO6F7D=iP7-gcRH1f1SsLzjXcgw=ZB4O6GikFoee8qyQWy4HFw@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:14:47PM -0400, Michael Jin wrote:
> Therefore, I would like you to confirm that model 10h uses 0x15e8 (device
> F0) and 0x15ee (device F6) as I can not find any documentation or test
> whether ECC works.

He just asked you to make the change for models 0x10-0x2f. How much more
confirmation do you need?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
