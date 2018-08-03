Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF00C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C6C21748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C6C21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeHCLjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:39:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732447AbeHCLjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:39:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B3FAD99;
        Fri,  3 Aug 2018 09:44:00 +0000 (UTC)
Date:   Fri, 3 Aug 2018 11:43:59 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Ocean He <oceanhehy@gmail.com>
Cc:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH] ACPI: nfit: return -ENODEV if fail to find NFIT at
 startup
Message-ID: <20180803094359.msvbwncid24ptjem@linux-x5ow.site>
References: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
