Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA25C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA4A21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA4A21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeIUEot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:44:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:33028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbeIUEot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:44:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 15:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,282,1534834800"; 
   d="scan'208";a="71671358"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2018 15:58:59 -0700
Date:   Thu, 20 Sep 2018 15:58:59 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2] vfio/pci: Mask buggy SR-IOV VF INTx support
Message-ID: <20180920225858.GA19661@otc-nc-03>
References: <153747346143.7344.14634545723456004489.stgit@gimli.home>
 <9184057F7FC11744A2107296B6B8EB1E44721E41@fmsmsx101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9184057F7FC11744A2107296B6B8EB1E44721E41@fmsmsx101.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:56:41PM -0700, Eads, Gage wrote:
Thanks Gage.


> Hi Alex,
> > 
> > Known devices with this issue: 8086:270c
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Tested-by: Gage Eads <gage.eads@intel.com>

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
