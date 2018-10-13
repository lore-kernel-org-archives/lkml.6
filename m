Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C0DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7908C20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7908C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeJNEkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:40:21 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:33922 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725734AbeJNEkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:40:21 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id CE76F634C86;
        Sun, 14 Oct 2018 00:01:48 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1gBR2i-0002pj-Le; Sun, 14 Oct 2018 00:01:48 +0300
Date:   Sun, 14 Oct 2018 00:01:48 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>
Subject: Re: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
Message-ID: <20181013210148.pulqs6vhfuea4q6h@valkosipuli.retiisi.org.uk>
References: <20181009234245.25830-1-rajmohan.mani@intel.com>
 <33c53caf-633a-f359-4312-9c2dc317efc5@ideasonboard.com>
 <39c26dd4-4454-f557-f510-ae973f5d9c89@linux.intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A5981515F2D@fmsmsx122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A5981515F2D@fmsmsx122.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:00:44PM +0000, Mani, Rajmohan wrote:
> Hi Bingbu, Kieren,
> 
> > Subject: Re: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
> > 
> > 
> > 
> > On 10/11/2018 05:33 PM, Kieran Bingham wrote:
> > > Hi Rajmohan
> > >
> > > Thank you for the patch,
> > >
> > > On 10/10/18 00:42, Rajmohan Mani wrote:
> > >> Removed redundant CIO2_IMAGE_MAX_* definitions
> > >>
> > >> Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2
> > >> driver")
> > >>
> > >> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > > Reviewed-by: Kieran Bingham
> > <kieran.bingham+renesas@ideasonboard.com>
> > >
> > > Looks like this {sh,c}ould be bundled in with  "[PATCH 0/2] Trivial
> > > CIO2 patches" from Sakari at integration.
> > Raj and Sakari, I think this change could be bundled into the Trivial patch sets,
> > what do you think?
> > >
> 
> Sounds good to me.
> I will leave this up to Sakari.

Yes, these are all in my branch for 4.21.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
